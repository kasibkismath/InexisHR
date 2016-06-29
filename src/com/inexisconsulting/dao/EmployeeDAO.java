package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("employeeDao")
public class EmployeeDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	static int employeeInsertedKey;
	
	public Session session(){
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Employee> getAllEmployees() {
		return session().createQuery("from Employee").list();
	}

	public int addNewEmployee(Employee employee) {
		if(checkEmpExists(employee)) {
			session().saveOrUpdate(employee);
			employeeInsertedKey = employee.getEmpId();
			return getEmpId();
		} else {
			return 0;
		}
	}

	public boolean checkEmpExists(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("nicNo", employee.getNicNo()));
		Employee empExists = (Employee)crit.uniqueResult();
		return empExists == null;
		
	}

	public Employee getEditEmployee(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("id", employee.getEmpId()));
		Employee getEditEmp = (Employee)crit.uniqueResult(); 
		return getEditEmp;
	}

	public void updateEditBasicInfoEmp(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("emp_id", employee.getEmpId()));
		Employee updatedEmp = (Employee)crit.uniqueResult();
		updatedEmp.setFirstName(employee.getFirstName());
		updatedEmp.setLastName(employee.getLastName());
		updatedEmp.setNicNo(employee.getNicNo());
		updatedEmp.setEmail(employee.getEmail());
		updatedEmp.setPhoneNumber(employee.getPhoneNumber());
		updatedEmp.setMobileNumber(employee.getMobileNumber());
		updatedEmp.setHireDate(employee.getHireDate());
		updatedEmp.setDesignation(employee.getDesignation());
		updatedEmp.setEmploymentType(employee.getEmploymentType());
		updatedEmp.setSalary(employee.getSalary());
		updatedEmp.setBirthday(employee.getBirthday());
		updatedEmp.setImageURL(employee.getImageURL());
		session().saveOrUpdate(updatedEmp);
	}

	public void updateEditEduFormEmp(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("emp_id", employee.getEmpId()));
		Employee updatedEmp = (Employee)crit.uniqueResult();
		updatedEmp.setEducation(employee.getEducation());
		session().saveOrUpdate(updatedEmp);
	}
	
	public void updateWorkHistory(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("emp_id", employee.getEmpId()));
		Employee updatedEmp = (Employee)crit.uniqueResult();
		updatedEmp.setPastWork(employee.getPastWork());
		session().saveOrUpdate(updatedEmp);
	}
	
	public static int getEmpId() {
		return employeeInsertedKey;
	}

	public void updateImageURL(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("emp_id", employee.getEmpId()));
		Employee updatedEmpImageURL = (Employee)crit.uniqueResult();
		updatedEmpImageURL.setImageURL(employee.getImageURL());
		session().saveOrUpdate(updatedEmpImageURL);
	}
}
