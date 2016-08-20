package com.inexisconsulting.dao;

public class Team_Member_And_Lead_Appraisal {

	private TeamEmployee_And_Team teamEmployeeAndTeam;
	private Lead_Appraisal lead_Appraisal;

	public Team_Member_And_Lead_Appraisal() {
	}

	public Team_Member_And_Lead_Appraisal(TeamEmployee_And_Team teamEmployeeAndTeam, Lead_Appraisal lead_Appraisal) {
		this.teamEmployeeAndTeam = teamEmployeeAndTeam;
		this.lead_Appraisal = lead_Appraisal;
	}

	public TeamEmployee_And_Team getTeamEmployeeAndTeam() {
		return teamEmployeeAndTeam;
	}

	public void setTeamEmployeeAndTeam(TeamEmployee_And_Team teamEmployeeAndTeam) {
		this.teamEmployeeAndTeam = teamEmployeeAndTeam;
	}

	public Lead_Appraisal getLead_Appraisal() {
		return lead_Appraisal;
	}

	public void setLead_Appraisal(Lead_Appraisal lead_Appraisal) {
		this.lead_Appraisal = lead_Appraisal;
	}

}
