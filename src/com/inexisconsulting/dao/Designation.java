package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "designation")
public class Designation {

	@Id
	@Column(name = "designation_id")
	private int designation_id;
	private String name;
	
	public Designation(){
		
	}

	public Designation(int designation_id, String name) {
		this.designation_id = designation_id;
		this.name = name;
	}

	public int getDesignationId() {
		return designation_id;
	}

	public void setDesignationId(int designation_id) {
		this.designation_id = designation_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
