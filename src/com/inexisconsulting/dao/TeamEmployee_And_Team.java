package com.inexisconsulting.dao;

public class TeamEmployee_And_Team {
	
	private Team_Employee team_employee;
	private Team team;
	
	public TeamEmployee_And_Team() {
	}

	public Team_Employee getTeam_employee() {
		return team_employee;
	}

	public void setTeam_employee(Team_Employee team_employee) {
		this.team_employee = team_employee;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}
}
