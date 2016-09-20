package com.inexisconsulting.dao;

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

	public boolean checkDuplicateTeam(Team team) {
		String sql = "select count(*) from team where team_name=:teamName and project_id=:projectId";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("teamName", team.getTeam_name());
		query.setParameter("projectId", team.getProject().getProject_id());
		
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

	public void addTeam(Team team) {
		session().saveOrUpdate(team);
	}

	public Team getTeamByTeamId(Team team) {
		Criteria crit = session().createCriteria(Team.class);
		crit.add(Restrictions.eq("team_Id", team.getTeam_Id()));
		Team result = (Team) crit.uniqueResult();
		return result;
	}

	public void updateTeam(Team team) {
		Criteria crit = session().createCriteria(Team.class);
		crit.add(Restrictions.eq("team_Id", team.getTeam_Id()));

		Team updatedTeam = (Team) crit.uniqueResult();
		updatedTeam.setTeam_name(team.getTeam_name());
		updatedTeam.setProject(team.getProject());
		updatedTeam.setEmployee(team.getEmployee());
		updatedTeam.setStatus(team.getStatus());
	}

	public void deleteTeam(Team team) {
		Query query = session().createQuery("delete from Team where team_Id=:teamId");
		query.setInteger("teamId", team.getTeam_Id());
		query.executeUpdate();
	}

}
