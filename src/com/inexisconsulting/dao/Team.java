package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "team")
public class Team {

	@Id
	@Column(name = "team_id")
	private int team_Id;

	@ManyToOne
	@JoinColumn(name = "project_id")
	private Project project;

	@ManyToOne
	@JoinColumn(name = "emp_id_lead")
	private Employee employee;

	private String team_name;
	
	private String status;

	public Team() {
	}

	public Team(int team_Id, Project project, Employee employee, String team_name, String status) {
		this.team_Id = team_Id;
		this.project = project;
		this.employee = employee;
		this.team_name = team_name;
		this.status = status;
	}

	public int getTeam_Id() {
		return team_Id;
	}

	public void setTeam_Id(int team_Id) {
		this.team_Id = team_Id;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
