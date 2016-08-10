package com.inexisconsulting.dao;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "team_employee")
public class Team_Employee {

	@ManyToOne
	@JoinColumn(name = "team_id")
	private Team team;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	public Team_Employee() {
	}

	public Team_Employee(Team team, Employee employee) {
		this.team = team;
		this.employee = employee;
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
