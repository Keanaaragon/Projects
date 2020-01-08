package com.keana.project.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.keana.project.models.Review;
import com.keana.project.models.User;
import com.keana.project.models.Wine;
import com.keana.project.repositories.ReviewRep;
import com.keana.project.repositories.UserRep;
import com.keana.project.repositories.WineRep;
import com.keana.project.services.ReviewServices;
import com.keana.project.services.UserService;
import com.keana.project.services.WineService;
import com.keana.project.validator.UserValidator;

@Controller
public class MainController {
	private final UserRep userRep;
	private final WineRep wineRep;
	private final ReviewRep reviewRep;
	private final UserService userService;
	private final WineService wineService;
	
	

	
    private final UserValidator userValidator;

	
	public MainController(
			UserRep userRep,
			WineRep wineRep,
			ReviewRep reviewRep,
			UserService userService,
			WineService wineService,
			UserValidator userValidator

			) {
		this.userRep = userRep;
		this.wineRep = wineRep;
		this.reviewRep = reviewRep;
		this.userService = userService;
		this.wineService = wineService;
        this.userValidator = userValidator;


	}
	
	
//	@GetMapping("/")
//	public String regAndLogin(@ModelAttribute("user_r") User user_r) {
//		return "logReg.jsp";
//	}
	@GetMapping("/")
	public String regAndLogin(Model model) {
		model.addAttribute("user_r", new User());
		return "logReg.jsp";
	}
	
	@PostMapping("/registration")
	public String register(@Valid @ModelAttribute("user_r") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
        if(result.hasErrors()) {
            return "logReg.jsp";
        }
        User u = userService.registerUser(user);
        session.setAttribute("userId", u.getId());
        return "redirect:/wines";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("email_l") String email, @RequestParam("password_l") String password, Model model, HttpSession session) {
		boolean isAuthenticated = userService.authenticateUser(email, password);
		if(isAuthenticated) {
			User u = userService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/wines";
		} else {
			model.addAttribute("error", "Invalid Credentials. Please try again");
			return "logReg.jsp";
		}
	}
	
	@GetMapping("/wines")
	public String dashboard(Model model, HttpSession session) {
		List<Wine> t = wineRep.findAll();
		//User u = userService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("t", t);
//		model.addAttribute("u", u);
		return "dashboard.jsp";
	}
	
	@GetMapping("/wines/new")
	public String renderCreateWine(@ModelAttribute("wine") Wine wine, HttpSession session, Model model) {
		User u = userService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("u", u);
		return "createWine.jsp";
	}
	
	@GetMapping("/review/new/{item_id}")
	public String renderCreateReview(@ModelAttribute("review") Review review, HttpSession session, Model model, @PathVariable("item_id") Long id) {
		User u = userService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("u", u);
		Wine wine = wineService.findWineById(id);
		model.addAttribute("item", wine);
		return "createReview.jsp";
	}
	
	@PostMapping("/review/new/{item_id}")
	public String createReview(HttpSession session, @Valid @ModelAttribute("review") Review review, BindingResult result,@PathVariable("item_id") Long id) {
		if(result.hasErrors()) {
			return "createReview.jsp";
 
		} else {
			Wine w = wineService.findWineById(id);
			User u = userService.findUserById((Long) session.getAttribute("userId"));
			review.setWine(w);
			review.setUser(u);
			reviewRep.save(review);
			return "redirect:/wines/{item_id}";
		}
	}
	
	@PostMapping("/wines/new")
	public String createWine(@Valid @ModelAttribute("wines") Wine wine, BindingResult result) {
		if(result.hasErrors()) {
			return "createWine.jsp";
 
		} else {
			wineRep.save(wine);
			return "redirect:/wines";
		}
	}
		
	@GetMapping("/wines/{item_id}")
	public String displayWine(@PathVariable("item_id") Long id, Model model) {
		Wine a = wineService.findWineById(id);
		model.addAttribute("wine", a);
		List<Review> r = reviewRep.findAll();
		System.out.println(r);
		model.addAttribute("Review", r);
		return "view.jsp";
	}
	
	@GetMapping("/wines/{item_id}/edit")
	public String editWine(@PathVariable("item_id") Long id, Model model) {
		Wine a = wineService.findWineById(id);
		model.addAttribute("wine", a);
		return "editWine.jsp";
	}
	
	
	@PostMapping("/wines/{item_id}/edit")
	public String editWine(@PathVariable("item_id") Long id, @Valid @ModelAttribute("wines") Wine wine, BindingResult result) {
		if(result.hasErrors()) {
			System.out.println(result);
			return "editwine.jsp";

		} else {
			Wine a = wineService.findWineById(id);
			a.setType(wine.getType());
			a.setName(wine.getName());
			a.setWinery(wine.getWinery());
			a.setVintage(wine.getVintage());
			wineRep.save(a);
			return "redirect:/wines";
		}
	}
	
	@GetMapping("/wines/{item_id}/delete")
	public String deleteWine(@PathVariable("item_id") Long id) {
		wineRep.deleteById(id);
		return "redirect:/wines";
	}
	
}
