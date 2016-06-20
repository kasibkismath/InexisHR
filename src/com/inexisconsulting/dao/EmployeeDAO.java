package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("employeeDao")
public class EmployeeDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public Session session(){
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Employee> getAllEmployees() {
		return session().createQuery("from Employee").list();
	}

	public void addNewEmployee(Employee employee) {
		session().saveOrUpdate(employee);
		
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

}
