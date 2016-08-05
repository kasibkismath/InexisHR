package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "performance_appraisal")
public class Performance {

	@Id
	@Column(name = "performance_id")
	private int performance_id;

	@ManyToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	private Date date;
	private int final_score;
	private String status;
	
	public Performance(){}
	
	public Performance(int performance_id, Employee employee, Date date, int final_score, String status) {
		this.performance_id = performance_id;
		this.employee = employee;
		this.date = date;
		this.final_score = final_score;
		this.status = status;
	}

	public int getPerformance_id() {
		return performance_id;
	}

	public void setPerformance_id(int performance_id) {
		this.performance_id = performance_id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getFinal_score() {
		return final_score;
	}

	public void setFinal_score(int final_score) {
		this.final_score = final_score;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}