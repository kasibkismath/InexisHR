package com.inexisconsulting.dao;

import java.util.Calendar;
import java.util.List;

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

}
