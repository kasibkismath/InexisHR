package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

	public Project getProjectByProjectId(Project project) {
		Criteria crit = session().createCriteria(Project.class);
		crit.add(Restrictions.eq("project_id", project.getProject_id()));
		Project result = (Project) crit.uniqueResult();
		return result;
	}

	public void updateProject(Project project) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = project.getProject_start();
		String stringstartDate = sdf.format(startDate);
		
		Criteria crit = session().createCriteria(Project.class);
		crit.add(Restrictions.eq("project_id", project.getProject_id()));

		Project updatedProject = (Project) crit.uniqueResult();
		
		updatedProject.setProject_name(project.getProject_name());
		updatedProject.setStatus(project.getStatus());
		updatedProject.setProject_start(sdf.parse(stringstartDate));
		updatedProject.setProject_client(project.getProject_client());
	}

	public void deleteProject(Project project) {
		Query query = session().createQuery("delete from Project where project_id=:projectId");
		query.setInteger("projectId", project.getProject_id());
		query.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getProjectEmployeeSummary() {
		String sql = "select project.project_name as 'Project Name', count(*) as Count "
				+ "from project "
				+ "join team "
				+ "on project.project_id = team.project_id "
				+ "join team_employee "
				+ "on team_employee.team_id = team.team_id "
				+ "join employee "
				+ "on employee.emp_id = team_employee.emp_id "
				+ "where (project.status=:projectStatus1 or project.status=:projectStatus2) and "
				+ "team.status=:teamStatus and employee.status=:employeeStatus "
				+ "group by project.project_name";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("projectStatus1", "In-Progress");
		query.setParameter("projectStatus2", "On-Hold");
		query.setParameter("teamStatus", "Active");
		query.setParameter("employeeStatus", true);
		
		List<Object[]> result = query.list();
		return result;
	}

}
