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
@Table(name = "leaves")
public class Leave {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "leave_id")
	private int leave_id;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	@OneToOne
	@JoinColumn(name = "leave_type_id")
	private Leave_Type leaveType;

	private Date leave_from;
	private Date leave_to;
	private String leave_option;
	private Float no_days;
	private String status;
	private String reason;

	public Leave() {
	}

	public int getLeave_id() {
		return leave_id;
	}

	public void setLeave_id(int leave_id) {
		this.leave_id = leave_id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Leave_Type getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(Leave_Type leaveType) {
		this.leaveType = leaveType;
	}

	public Date getLeave_from() {
		return leave_from;
	}

	public void setLeave_from(Date leave_from) {
		this.leave_from = leave_from;
	}

	public Date getLeave_to() {
		return leave_to;
	}

	public void setLeave_to(Date leave_to) {
		this.leave_to = leave_to;
	}

	public String getLeave_option() {
		return leave_option;
	}

	public void setLeave_option(String leave_option) {
		this.leave_option = leave_option;
	}

	public Float getNo_days() {
		return no_days;
	}

	public void setNo_days(Float no_days) {
		this.no_days = no_days;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
}
