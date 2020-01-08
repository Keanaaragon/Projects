package com.keana.project.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

@Entity
@Table(name="wines")
public class Wine {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
 
    @Size(min=1, max=200, message="Type must be present")
    private String type;
   
    @Size(min=1, message="Name must be present")
    private String name;
    
    @Size(min=1, message="Winery must be present")
    private String winery;
    
    @Min(1000)
    private Integer vintage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
   
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "review", 
        joinColumns = @JoinColumn(name = "wines_id"), 
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )     
    private List<User> users;
	public Wine() {
		
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getWinery() {
		return winery;
	}


	public void setWinery(String winery) {
		this.winery = winery;
	}


	public Integer getVintage() {
		return vintage;
	}


	public void setVintage(Integer vintage) {
		this.vintage = vintage;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}



    

}
