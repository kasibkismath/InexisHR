package com.inexisconsulting.dao;

import java.util.Calendar;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
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
				+ "leaves.leave_type_id=:leaveTypeId";
		
		Query query = session().createSQLQuery(sql);
		
		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("leaveTypeId", leave.getLeaveType().getLeave_type_id());
		
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
				+ "(leave_type.name=:leave1 or leave_type.name=:leave2)";
		
		Query query = session().createSQLQuery(sql);
		
		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("leave1", "Medical Leave");
		query.setParameter("leave2", "Casual Leave");
		
		float sum = ((Number) query.uniqueResult()).floatValue();
		return sum;
	}

}
