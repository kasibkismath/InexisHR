package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("teamDao")
public class TeamDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Team> getTeamByLeadId(Team team) {
		
		String hql = "from Team as tm where tm.employee.emp_id=:empId";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", team.getEmployee().getEmpId());
		
		List<Team> listResult = query.list();
		return listResult;
	}
	
	@SuppressWarnings("unchecked")
	public List<Team_Employee> getEmployeesByLeadId(Team team) {
		String hql = "select teamEmp.employee from Team_Employee as teamEmp inner join teamEmp.team where "
				+ "teamEmp.team.employee.emp_id=:leadId and teamEmp.employee.emp_id!=:leadId and "
				+ "teamEmp.employee.status=:status "
				+ "order by teamEmp.employee.firstName, teamEmp.employee.lastName";
		
		Query query = session().createQuery(hql);
		query.setParameter("leadId", team.getEmployee().getEmpId());
		query.setParameter("status", true);
		
		List<Team_Employee> result = query.list();
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<Team> getAllTeams() {
		
		String hql = "from Team";
		
		Query query = session().createQuery(hql);
		
		List<Team> listResult = query.list();
		return listResult;
	}

}
