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
		/*String sql = "select train.*, (train.max_candidates - "
				+ "(select count(*) from emp_training as empTrain "
				+ "where train.training_id = empTrain.training_id)) as 'Available Slots' "
				+ "from training as train "
				+ "left join emp_training as empTrain "
				+ "on train.training_id = empTrain.training_id where "
				+ "year(train.expected_start_date)=:currentYear or "
				+ "year(train.expected_end_date)=:currentYear";*/
		
		String sql = "select train.*, COALESCE( empTrain.cnt, 0 ) AS AvailableSlots "
				+ "from training train left join "
				+ "( select emp_training.training_id, emp_training.count(*) as cnt from emp_training, training "
				+ "where emp_training.training_id = training.training_id ) empTrain "
				+ "on train.training_id = empTrain.training_id "
				+ "where "
				+ "year(train.expected_start_date)=:currentYear or "
				+ "year(train.expected_end_date)=:currentYear";

		Query query = session().createSQLQuery(sql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));

		List<TrainingsAndAvailability> trainings = query.list();
		return trainings;
	}

}
