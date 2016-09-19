package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

	@SuppressWarnings("unchecked")
	public List<Project> getProjectsByEmpId(Attendance attendance) {
		
		String hql = "from Team_Employee teamEmp inner join teamEmp.team team inner join team.project project "
				+ "where teamEmp.employee.emp_id=:empId and project.status=:status or project.status=:status1";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", attendance.getEmployee().getEmpId());
		query.setParameter("status", "In-Progress");
		query.setParameter("status1", "On-Hold");
		
		List<Project> returnList = query.list();
		return returnList;
	}

	@SuppressWarnings("unchecked")
	public List<Project> getAllProjects() {
		String hql = "from Project";
		
		Query query = session().createQuery(hql);
		
		List<Project> result = query.list();
		return result;
	}

	public boolean checkDuplicateProject(Project project) {
		String sql = "select count(*) from project where project_name=:projectName";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("projectName", project.getProject_name());
		
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

	public void addProject(Project project) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = project.getProject_start();
		String stringstartDate = sdf.format(startDate);
		
		project.setProject_start(sdf.parse(stringstartDate));
		
		session().saveOrUpdate(project);
	}

}
