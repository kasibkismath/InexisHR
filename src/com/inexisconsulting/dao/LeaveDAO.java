package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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
@Component("leaveDao")
public class LeaveDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public Long getLeaveSumByLeaveTypeAndYear(Leave leave) {
		String sql = "select COALESCE(sum(no_days),0) as total "
				+ "from leaves "
				+ "join leave_type "
				+ "on leaves.leave_type_id = leave_type.leave_type_id "
				+ "where leaves.emp_id=:empId and year(leave_from)=:currentYear "
				+ "and year(leave_to)=:currentYear and "
				+ "leaves.leave_type_id=:leaveTypeId and leaves.status!=:rejectedStatus";
		
		Query query = session().createSQLQuery(sql);
		
		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("leaveTypeId", leave.getLeaveType().getLeave_type_id());
		query.setParameter("rejectedStatus", "Rejected");
		
		long sum = ((Number) query.uniqueResult()).longValue();
		return sum;
	}

	public float getLeaveSumByYearForCausalAndMedicalLeaves(Leave leave) {
		String sql = "select COALESCE(sum(no_days),0) as total "
				+ "from leaves "
				+ "join leave_type "
				+ "on leaves.leave_type_id = leave_type.leave_type_id "
				+ "where leaves.emp_id=:empId and year(leave_from)=:currentYear "
				+ "and year(leave_to)=:currentYear and "
				+ "(leave_type.name=:leave1 or leave_type.name=:leave2)"
				+ "and leaves.status!=:rejectedStatus";
		
		Query query = session().createSQLQuery(sql);
		
		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("leave1", "Medical Leave");
		query.setParameter("leave2", "Casual Leave");
		query.setParameter("rejectedStatus", "Rejected");
		
		float sum = ((Number) query.uniqueResult()).floatValue();
		return sum;
	}

	public boolean checkDuplicateLeave(Leave leave) throws HibernateException, ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// dates 
		Date fromDate = leave.getLeave_from();
		Date toDate = leave.getLeave_to();

		// convert date to string
		String stringFromDate = sdf.format(fromDate);
		String stringToDate = sdf.format(toDate);
		
		String sql = "select count(leave_id) as count from leaves "
				+ "where emp_id=:empId and leave_from>=:leaveFrom and leave_to<=:leaveTo and "
				+ "leaves.status!=:rejectedStatus";
		
		Query query = session().createSQLQuery(sql);
		
		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("leaveFrom", sdf.parse(stringFromDate));
		query.setParameter("leaveTo", sdf.parse(stringToDate));
		query.setParameter("rejectedStatus", "Rejected");
		
		if(query.uniqueResult() == null) {
			return false;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			if(count == 1) {
				return true;
			} else {
				return false;
			}
		}
	}

	public void addLeave(Leave leave) throws ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// get dates from leave object
		Date fromDate = leave.getLeave_from();
		Date toDate = leave.getLeave_to();
		
		// convert Date type to String
		String stringFromDate = sdf.format(fromDate);
		String stringToDate = sdf.format(toDate);
		
		// set to Date Type from String
		Date convertedFromDate = sdf.parse(stringFromDate);
		Date convertedToDate = sdf.parse(stringToDate);
		
		// set dates to leave object
		leave.setLeave_from(convertedFromDate);
		leave.setLeave_to(convertedToDate);
		
		session().saveOrUpdate(leave);
	}
}
