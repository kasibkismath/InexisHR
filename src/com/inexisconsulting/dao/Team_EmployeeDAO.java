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
	
	public Long getCountFromTeamEmployeeByEmpId(Team_Employee team_employee) {
		String hql = "select count(te.team_emp_id) from Team_Employee as te where " +
					"te.employee.emp_id=:empId";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", team_employee.getEmployee().getEmpId());
		
		Long count = (Long)query.uniqueResult();
		return count;
	}
	
	public Long getTeamCountForLeadByLeadEmpId(Team team) {
		String hql = "select count(team.team_Id) from Team as team where " +
					"team.employee.emp_id=:empId";
	
	Query query = session().createQuery(hql);
	query.setParameter("empId", team.getEmployee().getEmpId());
	
	Long count = (Long)query.uniqueResult();
	return count;
	}

	public Long getTeamEmployeesByEmpId(TeamEmployee_And_Team teamEmpAndTeam) {
		Team_Employee team_employee = teamEmpAndTeam.getTeam_employee();
		Team team = teamEmpAndTeam.getTeam();
		
		return getCountFromTeamEmployeeByEmpId(team_employee) - getTeamCountForLeadByLeadEmpId(team);
	}
}
