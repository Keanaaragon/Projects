package com.keana.project.services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.keana.project.models.Wine;
import com.keana.project.repositories.WineRep;

@Service
public class WineService {
	private final WineRep wineRep;
	public WineService(WineRep wineRep) {
		this.wineRep = wineRep;
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

