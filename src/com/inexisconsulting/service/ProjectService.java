package com.inexisconsulting.service;

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

}
