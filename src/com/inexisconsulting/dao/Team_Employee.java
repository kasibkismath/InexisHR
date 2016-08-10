package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "team_employee")
public class Team_Employee {

	@Id
	@Column(name = "team_emp_id")
	private int team_emp_id;

	@ManyToOne
	@JoinColumn(name = "team_id")
	private Team team;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	public Team_Employee() {
	}

	public Team_Employee(int team_emp_id, Team team, Employee employee) {
		this.team_emp_id = team_emp_id;
		this.team = team;
		this.employee = employee;
	}

	public int getTeam_emp_id() {
		return team_emp_id;
	}

	public void setTeam_emp_id(int team_emp_id) {
		this.team_emp_id = team_emp_id;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

}
