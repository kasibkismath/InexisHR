package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("employeeProjectHistoryDao")
public class EmployeeProjectHistoryDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public void addEmployeeProjectHistory(EmployeeProjectHistory empProjectHistory) 
			throws ParseException {
		// format
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// convert to Date
		Date fromDate = empProjectHistory.getFromDate();
		Date toDate = empProjectHistory.getToDate();
		
		// convert dates to string
		String stringFromDate = sdf.format(fromDate);
		String stringToDate = sdf.format(toDate);
		
		// set dates
		empProjectHistory.setFromDate(sdf.parse(stringFromDate));
		empProjectHistory.setToDate(sdf.parse(stringToDate));
		
		session().saveOrUpdate(empProjectHistory);
	}

	public boolean checkDuplicateEmpProjectHistory(EmployeeProjectHistory empProjectHistory) 
			throws HibernateException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// dates
		Date fromDate = empProjectHistory.getFromDate();
		Date toDate = empProjectHistory.getToDate();

		// convert date to string
		String stringFromDate = sdf.format(fromDate);
		String stringToDate = sdf.format(toDate);

		String sql = "select count(*) from employee_project_history where emp_id=:empId and "
				+ "team_id=:teamId and fromDate<=:to_Date and toDate>=:from_Date";

		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", empProjectHistory.getEmployee().getEmpId());
		query.setParameter("teamId", empProjectHistory.getTeam().getTeam_Id());
		query.setParameter("from_Date", sdf.parse(stringFromDate));
		query.setParameter("to_Date", sdf.parse(stringToDate));
		
		if (query.uniqueResult() == null) {
			return false;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();

			if (count == 1) {
				return true;
			} else {
				return false;
			}
		}
	}

	@SuppressWarnings("unchecked")
	public List<EmployeeProjectHistory> getAllEmpProjectHistories() {
		String hql = "from EmployeeProjectHistory where employee.status=:empStatus";
		
		Query query = session().createQuery(hql);
		query.setParameter("empStatus", true);
		
		List<EmployeeProjectHistory> empProjectHistories = query.list();
		return empProjectHistories;
	}

	public EmployeeProjectHistory getEmpProjectById(EmployeeProjectHistory empProjectHistory) {
		Criteria crit = session().createCriteria(EmployeeProjectHistory.class);
		crit.add(Restrictions.eq("emp_proj_history_id", empProjectHistory.getEmp_proj_history_id()));
		EmployeeProjectHistory result = (EmployeeProjectHistory) crit.uniqueResult();
		return result;
	}

	public void updateEmpProjectHistory(EmployeeProjectHistory empProjectHistory) 
			throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// dates
		Date fromDate = empProjectHistory.getFromDate();
		Date toDate = empProjectHistory.getToDate();

		// convert date to string
		String stringFromDate = sdf.format(fromDate);
		String stringToDate = sdf.format(toDate);
		
		Criteria crit = session().createCriteria(EmployeeProjectHistory.class);
		crit.add(Restrictions.eq("emp_proj_history_id", empProjectHistory.getEmp_proj_history_id()));

		EmployeeProjectHistory updatedLeave = (EmployeeProjectHistory) crit.uniqueResult();
		updatedLeave.setFromDate(sdf.parse(stringFromDate));
		updatedLeave.setToDate(sdf.parse(stringToDate));
	}

	public void deleteEmpProjectHistory(EmployeeProjectHistory empProjectHistory) {
		Query query = session().createQuery("delete from EmployeeProjectHistory where "
				+ "emp_proj_history_id=:empProjectHistoryId");
		query.setInteger("empProjectHistoryId", empProjectHistory.getEmp_proj_history_id());
		query.executeUpdate();
	}
}
