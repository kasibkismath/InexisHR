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
	public List<Training> getAllTrainingsByYear() {
		String hql = "from Training as training where "
				+ "year(training.expected_start_date)=:currentYear or "
				+ "year(training.expected_end_date)=:currentYear";

		Query query = session().createQuery(hql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));

		List<Training> trainings = query.list();
		return trainings;
	}

}
