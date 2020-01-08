package com.keana.project.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.keana.project.models.User;
import com.keana.project.models.Wine;

public interface WineRep extends CrudRepository<Wine, Long>{
	List<Wine> findAll();
	Optional<Wine> findById(Long id);
	void deleteById(Long id);
}
