package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "emp_training")
public class EmployeeTraining {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "emp_training_id")
	private int emp_training_id;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	@OneToOne
	@JoinColumn(name = "training_id")
	private Training training;

	private String status;
	private Date actual_start_date;
	private Date actual_end_date;
	private String remarks;

	public EmployeeTraining() {
	}

	public int getEmp_training_id() {
		return emp_training_id;
	}

	public void setEmp_training_id(int emp_training_id) {
		this.emp_training_id = emp_training_id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Training getTraining() {
		return training;
	}

	public void setTraining(Training training) {
		this.training = training;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getActual_start_date() {
		return actual_start_date;
	}

	public void setActual_start_date(Date actual_start_date) {
		this.actual_start_date = actual_start_date;
	}

	public Date getActual_end_date() {
		return actual_end_date;
	}

	public void setActual_end_date(Date actual_end_date) {
		this.actual_end_date = actual_end_date;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
