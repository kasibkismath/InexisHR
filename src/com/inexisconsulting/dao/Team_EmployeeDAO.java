package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("teamEmployeeDao")
public class Team_EmployeeDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Team_Employee> getTeamEmployeesByLeadId(Team_Employee team_employee) {
		String hql = "select te.employee as employee " + 
				"from Team_Employee as te inner join te.team as t where t.employee.emp_id=:empId";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", team_employee.getEmployee().getEmpId());
		
		List<Team_Employee> listResult = query.list();
			
		return listResult;
	}
}
