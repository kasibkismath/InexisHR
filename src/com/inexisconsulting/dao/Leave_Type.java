package com.inexisconsulting.dao;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "leave_type")
public class Leave_Type {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "leave_type_id")
	private int leave_type_id;

	private String name;

	public Leave_Type() {
	}

	public int getLeave_type_id() {
		return leave_type_id;
	}

	public void setLeave_type_id(int leave_type_id) {
		this.leave_type_id = leave_type_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
