package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.TeamEmployee_And_Team;
import com.inexisconsulting.dao.Team_Employee;
import com.inexisconsulting.dao.Team_EmployeeDAO;

@Service("teamEmployeeService")
public class Team_EmployeeService {
	
	@Autowired
	private Team_EmployeeDAO teamEmployeeDao;

	public List<Team_Employee> getTeamEmployeesByLeadId(Team_Employee team_employee) {
		return teamEmployeeDao.getTeamEmployeesByLeadId(team_employee);
	}

	public Long getTeamEmployeesByEmpId(TeamEmployee_And_Team teamEmpAndTeam) {
		return teamEmployeeDao.getTeamEmployeesByEmpId(teamEmpAndTeam);
	}

	public List<Team_Employee> getAllTeamMembers() {
		return teamEmployeeDao.getAllTeamMembers();
	}

	public boolean checkTeamMemberDuplicate(Team_Employee teamEmp) {
		return teamEmployeeDao.checkTeamMemberDuplicate(teamEmp);
	}

	public void addTeamEmployee(Team_Employee teamEmp) {
		teamEmployeeDao.addTeamEmployee(teamEmp);
	}

}
