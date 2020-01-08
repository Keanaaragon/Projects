package com.keana.project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.keana.project.models.Review;
import com.keana.project.models.User;
import com.keana.project.models.Wine;
import com.keana.project.repositories.ReviewRep;
import com.keana.project.repositories.UserRep;
import com.keana.project.repositories.WineRep;

@Service
public class ReviewServices {
	private final UserRep userRepository;
	private final WineRep wineRep;
	private final ReviewRep reviewRep;
	
	public ReviewServices(UserRep userRepository, WineRep wineRep, ReviewRep reviewRep) {
		this.userRepository = userRepository;
		this.wineRep = wineRep;
		this.reviewRep = reviewRep;
	}
	
	//User
	public void addUser(User user) {
		userRepository.save(user);
	}
	
	public void setWine(Wine wine) {
		
	}
	
	public void addReview(Review review) {
		reviewRep.save(review);
	}
	

    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
	
	
	//Wine
	public void addWine(Wine wine) {
		wineRep.save(wine);
	}
	
	public List<Wine> getWineAll() {
		return wineRep.findAll();
	}
	
    
	public Wine findWineById(Long id) {
		Optional<Wine> u = wineRep.findById(id);
		
		if(u.isPresent()) {
	        return u.get();
		} else {
		    return null;
		}
	}
}
