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

}
