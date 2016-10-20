package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("trainingDao")
public class TrainingDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<TrainingsAndAvailability> getAllTrainingsByYear() {
		String sql = "select train.*, "
				+ "(train.max_candidates - COALESCE(empTrain.empTrainCount,0)) AS AvailableSlots "
				+ "from training as train "
				+ "left join ( "
				+ "select count(*) as empTrainCount, training_id as empTrainingId "
				+ "from emp_training "
				+ "group by training_id "
				+ ") as empTrain "
				+ "on empTrain.empTrainingId = train.training_id "
				+ "where year(train.expected_start_date)=:currentYear or "
				+ "year(train.expected_end_date)=:currentYear";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));

		List<TrainingsAndAvailability> trainings = query.list();
		return trainings;
	}

	public boolean checkDuplicateTraining(Training training) throws HibernateException, ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// dates
		Date expStartDate = training.getExpected_start_date();
		Date expEndDate = training.getExpected_end_date();

		// convert date to string
		String stringExpStartDate = sdf.format(expStartDate);
		String stringExpEndDate = sdf.format(expEndDate);
		
		String sql = "select count(*) from training where name=:trainingName and "
				+ "level_of_difficulty=:difficultyLevel and type_of_training=:trainingType and "
				+ "(expected_start_date>=:expStartDate and expected_end_date<=:expEndDate)";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("trainingName", training.getName());
		query.setParameter("difficultyLevel", training.getLevel_of_difficulty());
		query.setParameter("trainingType", training.getType_of_training());
		query.setParameter("expStartDate", sdf.parse(stringExpStartDate));
		query.setParameter("expEndDate", sdf.parse(stringExpEndDate));
		
		if (query.uniqueResult() == null) {
			return false;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();

			if (count == 1) {
				return true;
			} else {
				return false;
			}
		}
	}

}
