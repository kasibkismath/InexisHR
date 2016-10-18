package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Training;
import com.inexisconsulting.dao.TrainingDAO;
import com.inexisconsulting.dao.TrainingsAndAvailability;

@Service("trainingService")
public class TrainingService {
	
	@Autowired
	private TrainingDAO trainingDao;

	public List<TrainingsAndAvailability> getAllTrainingsByYear() {
		return trainingDao.getAllTrainingsByYear();
	}

}
