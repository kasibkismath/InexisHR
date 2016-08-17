package com.inexisconsulting.dao;

public class Team_Member_And_Lead_Appraisal {

	private Team_Employee team_employee;
	private Lead_Appraisal lead_Appraisal;

	public Team_Member_And_Lead_Appraisal() {
	}

	public Team_Member_And_Lead_Appraisal(Team_Employee team_employee, Lead_Appraisal lead_Appraisal) {
		this.team_employee = team_employee;
		this.lead_Appraisal = lead_Appraisal;
	}

	public Team_Employee getTeam_employee() {
		return team_employee;
	}

	public void setTeam_employee(Team_Employee team_employee) {
		this.team_employee = team_employee;
	}

	public Lead_Appraisal getLead_Appraisal() {
		return lead_Appraisal;
	}

	public void setLead_Appraisal(Lead_Appraisal lead_Appraisal) {
		this.lead_Appraisal = lead_Appraisal;
	}

}
