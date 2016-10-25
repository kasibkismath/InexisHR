package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "contract")
public class Contract {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "contract_id")
	private int contract_id;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	private String contractURL;

	public Contract() {
	}

	public int getContract_id() {
		return contract_id;
	}

	public void setContract_id(int contract_id) {
		this.contract_id = contract_id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getContractURL() {
		return contractURL;
	}

	public void setContractURL(String contractURL) {
		this.contractURL = contractURL;
	}
}
