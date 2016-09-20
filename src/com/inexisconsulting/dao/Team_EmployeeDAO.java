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
		String hql = "select te.employee as employee "
				+ "from Team_Employee as te inner join te.team as t where t.employee.emp_id=:empId";

		Query query = session().createQuery(hql);
		query.setParameter("empId", team_employee.getEmployee().getEmpId());

		List<Team_Employee> listResult = query.list();
		return listResult;
	}

	public Long getCountFromTeamEmployeeByEmpId(Team_Employee team_employee) {
		String hql = "select count(te.team_emp_id) from Team_Employee as te where " + "te.employee.emp_id=:empId";

		Query query = session().createQuery(hql);
		query.setParameter("empId", team_employee.getEmployee().getEmpId());

		Long count = (Long) query.uniqueResult();
		return count;
	}

	public Long getTeamCountForLeadByLeadEmpId(Team team) {
		String hql = "select count(team.team_Id) from Team as team where " + "team.employee.emp_id=:empId";

		Query query = session().createQuery(hql);
		query.setParameter("empId", team.getEmployee().getEmpId());

		Long count = (Long) query.uniqueResult();
		return count;
	}

	public Long getTeamEmployeesByEmpId(TeamEmployee_And_Team teamEmpAndTeam) {
		Team_Employee team_employee = teamEmpAndTeam.getTeam_employee();
		Team team = teamEmpAndTeam.getTeam();

		return getCountFromTeamEmployeeByEmpId(team_employee) - getTeamCountForLeadByLeadEmpId(team);
	}

	@SuppressWarnings("unchecked")
	public List<Team_Employee> getAllTeamMembers() {
		String hql = "from Team_Employee";
		Query query = session().createQuery(hql);

		List<Team_Employee> result = query.list();
		return result;
	}

	public boolean checkTeamMemberDuplicate(Team_Employee teamEmp) {
		String sql = "select count(*) from team_employee where team_id=:teamId and emp_id=:empId";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("teamId", teamEmp.getTeam().getTeam_Id());
		query.setParameter("empId", teamEmp.getEmployee().getEmpId());
		
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

	public void addTeamEmployee(Team_Employee teamEmp) {
		session().saveOrUpdate(teamEmp);
	}

}
