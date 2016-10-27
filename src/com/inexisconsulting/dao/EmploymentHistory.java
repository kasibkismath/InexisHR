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
@Table(name = "employment_history")
public class EmploymentHistory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "emp_history_id")
	private int emp_history_id;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	@OneToOne
	@JoinColumn(name = "designation_id")
	private Designation designation;

	private int salary;
	private Date addedDate;
	private Date effectiveDate;

	public EmploymentHistory() {
	}

	public int getEmp_history_id() {
		return emp_history_id;
	}

	public void setEmp_history_id(int emp_history_id) {
		this.emp_history_id = emp_history_id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Designation getDesignation() {
		return designation;
	}

	public void setDesignation(Designation designation) {
		this.designation = designation;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public Date getAddedDate() {
		return addedDate;
	}

	public void setAddedDate(Date addedDate) {
		this.addedDate = addedDate;
	}

	public Date getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
}
