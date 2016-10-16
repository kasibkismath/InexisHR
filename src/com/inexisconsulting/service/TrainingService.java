package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Training;
import com.inexisconsulting.dao.TrainingDAO;

@Service("trainingService")
public class TrainingService {
	
	@Autowired
	private TrainingDAO trainingDao;

	public List<Training> getAllTrainingsByYear() {
		return trainingDao.getAllTrainingsByYear();
	}

}
