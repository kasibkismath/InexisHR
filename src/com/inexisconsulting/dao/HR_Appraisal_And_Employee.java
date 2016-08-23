package com.inexisconsulting.dao;


public class HR_Appraisal_And_Employee {
	
	private HR_Appraisal hr_appraisal;
	private Employee emp;
	
	public HR_Appraisal_And_Employee() {	
	}

	public HR_Appraisal_And_Employee(HR_Appraisal hr_appraisal, Employee emp) {
		this.hr_appraisal = hr_appraisal;
		this.emp = emp;
	}

	public HR_Appraisal getHr_appraisal() {
		return hr_appraisal;
	}

	public void setHr_appraisal(HR_Appraisal hr_appraisal) {
		this.hr_appraisal = hr_appraisal;
	}

	public Employee getEmp() {
		return emp;
	}

	public void setEmp(Employee emp) {
		this.emp = emp;
	}
}
