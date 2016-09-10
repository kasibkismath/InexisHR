package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("projectDao")
public class ProjectDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Project> getProjects() {
		String hql = "from Project as project where project.status=:status or project.status=:status1";
		
		Query query = session().createQuery(hql);
		query.setParameter("status", "In-Progress");
		query.setParameter("status1", "On-Hold");
		
		List<Project> returnList = query.list();
		return returnList;
	}

}
