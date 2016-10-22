package com.inexisconsulting.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
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

	@SuppressWarnings("unchecked")
	public List<EmployeeTraining> getAllEmpTrainingsByYear() {
		String hql = "from EmployeeTraining as empTraining "
				+ "where year(empTraining.training.expected_start_date)=:currentYear or "
				+ "year(empTraining.training.expected_end_date)=:currentYear";
		
		Query query = session().createQuery(hql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		
		List<EmployeeTraining> empTraining = query.list();
		return empTraining;
	}
	
	@SuppressWarnings("unchecked")
	public List<Employee> getEmpTrainingEmployees() {
		String hql = "from Employee where status=:status";
		
		Query query = session().createQuery(hql);
		query.setParameter("status", true);
		
		List<Employee> empTrainingEmployees = query.list();
		return empTrainingEmployees;
	}

	public boolean checkDuplicateEmpTraining(EmployeeTraining empTraining) {
		String sql = "select count(*) from emp_training where emp_id=:empId and training_id=:trainingId";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", empTraining.getEmployee().getEmpId());
		query.setParameter("trainingId", empTraining.getTraining().getTraining_id());
		
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

	public void addEmpTraining(EmployeeTraining empTraining) {
		session().saveOrUpdate(empTraining);
	}

	public boolean checkEmpTrainingAvailability(EmployeeTraining empTraining) {
		String sql = "select (train.max_candidates - COALESCE(empTrain.empTrainCount,0)) AS AvailableSlots "
				+ "from training as train " + "left join ( "
				+ "select count(*) as empTrainCount, training_id as empTrainingId " + "from emp_training "
				+ "group by training_id " + ") as empTrain " 
				+ "on empTrain.empTrainingId = train.training_id "
				+ "where train.training_id=:trainingId";

		Query query = session().createSQLQuery(sql);
		query.setParameter("trainingId", empTraining.getTraining().getTraining_id());
		
		if (query.uniqueResult() == null) {
			return false;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();

			if (count == 0) {
				return true;
			} else {
				return false;
			}
		}
	}

	public EmployeeTraining getEmpTrainingByEmpTrainingId(EmployeeTraining empTraining) {
		Criteria crit = session().createCriteria(EmployeeTraining.class);
		crit.add(Restrictions.eq("emp_training_id", empTraining.getEmp_training_id()));
		EmployeeTraining result = (EmployeeTraining) crit.uniqueResult();
		return result;
	}
}
