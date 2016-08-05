package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javassist.compiler.SyntaxError;

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
	
	public void deleteEmployee(Employee employee) {
		Query query = session().createQuery("delete from Employee where emp_id=:emp_id");
		query.setInteger("emp_id", employee.getEmpId());
		query.executeUpdate();
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
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getEmpDesignationData() {
		String hql = "select d.name as designation, count(e.emp_id) as count " + 
		"from Employee e inner join e.designation as d where e.status=true group by d.name";
		
		Query query = session().createQuery(hql);
		List<Object[]> listResult = query.list();
	
		return listResult;
	}
	
	public Long countUserByEmpId(Employee employee) {
		return (Long) session().createCriteria(User.class)
				.add(Restrictions.eq("employee.emp_id", employee.getEmpId()))
				.setProjection(Projections.rowCount()).uniqueResult();
	}
	

	public void disableEmployee(Employee employee) {
		if(countUserByEmpId(employee) >= 1) {
			// update user status
			Query query = session().createQuery("update User set enabled = :enabled" +
    				" where employee.emp_id = :emp_id");
			
			if(employee.isStatus()) {
				query.setParameter("enabled", true);
			} else {
				query.setParameter("enabled", false);
			}
			
			query.setParameter("emp_id", employee.getEmpId());
			query.executeUpdate();
		}
		
		// update employee status
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("emp_id", employee.getEmpId()));
					
		Employee disabledEmp = (Employee)crit.uniqueResult();
		disabledEmp.setStatus(employee.isStatus());
					
		session().saveOrUpdate(disabledEmp);
	}

	public Employee getStatus(Employee employee) {
		Criteria crit = session().createCriteria(Employee.class);
		crit.add(Restrictions.eq("emp_id", employee.getEmpId()));
		Employee empStatus = (Employee)crit.uniqueResult(); 
		return empStatus;
	}

	public User getEmployeeByUsername(User user) {
		Criteria crit = session().createCriteria(User.class);
		crit.add(Restrictions.eq("username", user.getUsername()));
		User userFetched = (User)crit.uniqueResult(); 
		return userFetched;
	}
}
