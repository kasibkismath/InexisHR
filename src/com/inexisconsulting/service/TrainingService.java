package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
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

	public boolean checkDuplicateTraining(Training training) throws HibernateException, ParseException {
		return trainingDao.checkDuplicateTraining(training);
	}

	public void addTraining(Training training) throws ParseException {
		trainingDao.addTraining(training);
	}

	public Training getTrainingByTrainingId(Training training) {
		return trainingDao.getTrainingByTrainingId(training);
	}

	public void updateTraining(Training training) throws ParseException {
		trainingDao.updateTraining(training);
	}

	public void deleteTraining(Training training) {
		trainingDao.deleteTraining(training);
	}

}
