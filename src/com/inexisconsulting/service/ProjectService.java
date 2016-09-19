package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Attendance;
import com.inexisconsulting.dao.Project;
import com.inexisconsulting.dao.ProjectDAO;

@Service("projectService")
public class ProjectService {
	
	@Autowired
	private ProjectDAO projectDao;
	
	public List<Project> getProjects() {
		return projectDao.getProjects();
	}

	public List<Project> getProjectsByEmpId(Attendance attendance) {
		return projectDao.getProjectsByEmpId(attendance);
	}

	public List<Project> getAllProjects() {
		return projectDao.getAllProjects();
	}

	public boolean checkDuplicateProject(Project project) {
		return projectDao.checkDuplicateProject(project);
	}

	public void addProject(Project project) throws ParseException {
		projectDao.addProject(project);
	}

	public Project getProjectByProjectId(Project project) {
		return projectDao.getProjectByProjectId(project);
	}

	public void updateProject(Project project) throws ParseException {
		projectDao.updateProject(project);
	}

	public void deleteProject(Project project) {
		projectDao.deleteProject(project);
	}

}
