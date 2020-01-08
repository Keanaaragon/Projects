package com.keana.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.keana.project.models.Review;

@Repository
public interface ReviewRep extends CrudRepository <Review, Long>{
	List<Review> findAll();
}
