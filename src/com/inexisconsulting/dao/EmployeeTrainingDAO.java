package com.inexisconsulting.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("employeeTrainingDao")
public class EmployeeTrainingDAO {
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public int getEmpTrainingCount(Training training) {
		String sql = "select count(*) from emp_training where training_id=:trainingId";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("trainingId", training.getTraining_id());
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			return count;
		}
	}
}
