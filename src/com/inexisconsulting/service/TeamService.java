package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Project;
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

	public List<Team> getAllTeams() {
		return teamDao.getAllTeams();
	}

	public boolean checkDuplicateTeam(Team team) {
		return teamDao.checkDuplicateTeam(team);
	}

	public void addTeam(Team team) {
		teamDao.addTeam(team);
	}

	public Team getTeamByTeamId(Team team) {
		return teamDao.getTeamByTeamId(team);
	}

	public void updateTeam(Team team) {
		teamDao.updateTeam(team);
	}

	public void deleteTeam(Team team) {
		teamDao.deleteTeam(team);
	}

}