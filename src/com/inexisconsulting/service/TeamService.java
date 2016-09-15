package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Team;
import com.inexisconsulting.dao.TeamDAO;
import com.inexisconsulting.dao.Team_Employee;

@Service("teamService")
public class TeamService {
	
	@Autowired
	private TeamDAO teamDao;

	public List<Team> getTeamsByLeadId(Team team) {
		return teamDao.getTeamByLeadId(team);
	}

	public List<Team_Employee> getEmployeesByLeadId(Team team) {
		return teamDao.getEmployeesByLeadId(team);
	}
	
	

}
