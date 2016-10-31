package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
@Component("leaveDao")
public class LeaveDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public Long getLeaveSumByLeaveTypeAndYear(Leave leave) {
		String sql = "select COALESCE(sum(no_days),0) as total " + "from leaves " + "join leave_type "
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
		String sql = "select COALESCE(sum(no_days),0) as total " + "from leaves " + "join leave_type "
				+ "on leaves.leave_type_id = leave_type.leave_type_id "
				+ "where leaves.emp_id=:empId and year(leave_from)=:currentYear "
				+ "and year(leave_to)=:currentYear and " + "(leave_type.name=:leave1 or leave_type.name=:leave2)"
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
				+ "where emp_id=:empId and leave_from<=:leaveTo and leave_to>=:leaveFrom and "
				+ "leaves.status!=:rejectedStatus";

		Query query = session().createSQLQuery(sql);

		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("leaveFrom", sdf.parse(stringFromDate));
		query.setParameter("leaveTo", sdf.parse(stringToDate));
		query.setParameter("rejectedStatus", "Rejected");

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

	@SuppressWarnings("unchecked")
	public List<Leave> getLeavesForLoggedInEmployeeByYear(Leave leave) {

		String hql = "from Leave as leave where leave.employee.emp_id=:empId "
				+ "and year(leave.leave_from)=:currentYear order by leave.leave_from desc";

		Query query = session().createQuery(hql);
		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));

		List<Leave> leaves = query.list();
		return leaves;
	}

	public Leave getLeaveByLeaveId(Leave leave) {
		Criteria crit = session().createCriteria(Leave.class);
		crit.add(Restrictions.eq("leave_id", leave.getLeave_id()));
		Leave result = (Leave) crit.uniqueResult();
		return result;
	}

	public void updateLeave(Leave leave) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// get dates from leave object
		Date fromDate = leave.getLeave_from();
		Date toDate = leave.getLeave_to();

		// convert Date type to String
		String stringFromDate = sdf.format(fromDate);
		String stringToDate = sdf.format(toDate);

		Criteria crit = session().createCriteria(Leave.class);
		crit.add(Restrictions.eq("leave_id", leave.getLeave_id()));

		Leave updatedLeave = (Leave) crit.uniqueResult();

		updatedLeave.setLeave_from(sdf.parse(stringFromDate));
		updatedLeave.setLeave_to(sdf.parse(stringToDate));
		updatedLeave.setLeaveType(leave.getLeaveType());
		updatedLeave.setNo_days(leave.getNo_days());
		updatedLeave.setLeave_option(leave.getLeave_option());
		updatedLeave.setReason(leave.getReason());
		updatedLeave.setStatus(leave.getStatus());
		updatedLeave.setEmployee(leave.getEmployee());

		session().saveOrUpdate(updatedLeave);
	}

	public void deleteLeave(Leave leave) {
		Query query = session().createQuery("delete from Leave where leave_id=:leaveId");
		query.setInteger("leaveId", leave.getLeave_id());
		query.executeUpdate();
	}

	public float getPendingLeaveCountByYear(Leave leave) {
		String sql = "select sum(leaves.no_days) as sum from leaves where emp_id=:empId "
				+ "and year(leaves.leave_from)=:currentYear and leaves.status=:status";

		Query query = session().createSQLQuery(sql);

		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("status", "Pending");

		if (query.uniqueResult() == null) {
			return 0;
		} else {
			float count = ((Number) query.uniqueResult()).floatValue();
			return count;
		}
	}

	public float getApprovedLeaveCount(Leave leave) {
		String sql = "select sum(leaves.no_days) as sum from leaves join leave_type on "
				+ "leaves.leave_type_id = leave_type.leave_type_id "
				+ "where emp_id=:empId "
				+ "and year(leaves.leave_from)=:currentYear and leaves.status=:status and "
				+ "(leave_type.Name=:annual or leave_type.Name=:medical or leave_type.Name=:casual)";

		Query query = session().createSQLQuery(sql);

		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("status", "Approved");
		query.setParameter("annual", "Annual Leave");
		query.setParameter("medical", "Medical Leave");
		query.setParameter("casual", "Casual Leave");

		if (query.uniqueResult() == null) {
			return 0;
		} else {
			float count = ((Number) query.uniqueResult()).floatValue();
			return count;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getLeaveTypeSumByYear(Leave leave) {
		
		String sql = "select leave_type.Name as LeaveType, sum(leaves.no_days) as sum "
				+ "from leaves join leave_type on leaves.leave_type_id = leave_type.leave_type_id "
				+ "where leaves.emp_id=:empId and year(leaves.leave_from)=:currentYear "
				+ "and leaves.status=:status "
				+ "group by LeaveType";

		Query query = session().createSQLQuery(sql);

		query.setParameter("empId", leave.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("status", "Approved");
		
		List<Object[]> result = query.list();
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<Leave> getAllLeavesByYear() {
		
		String hql = "from Leave as leave where "
				+ "year(leave.leave_from)=:currentYear order by leave.leave_from desc";

		Query query = session().createQuery(hql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));

		List<Leave> leaves = query.list();
		return leaves;
	}

	public void updateLeaveStatus(Leave leave) {
		Criteria crit = session().createCriteria(Leave.class);
		crit.add(Restrictions.eq("leave_id", leave.getLeave_id()));

		Leave updatedLeaveStatus = (Leave) crit.uniqueResult();
		updatedLeaveStatus.setStatus(leave.getStatus());
		
		session().saveOrUpdate(updatedLeaveStatus);
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getLeaveSummaryForCEO() {
		String sql = "select EmpName, "
				+ "SUM(CASE WHEN LeaveType = 'Annual Leave' THEN NoOfDays ELSE 0 END) 'Annual Leave', "
				+ "SUM(CASE WHEN LeaveType = 'Casual Leave' THEN NoOfDays ELSE 0 END) 'Casual Leave', "
				+ "SUM(CASE WHEN LeaveType = 'Medical Leave' THEN NoOfDays ELSE 0 END) 'Medical Leave' "
				+ "from( "
				+ "select concat(employee.firstName, ' ', employee.lastName) as EmpName, "
				+ "leave_type.Name as LeaveType, sum(leaves.no_days) as NoOfDays "
				+ "from leaves "
				+ "join leave_type on leaves.leave_type_id = leave_type.leave_type_id "
				+ "join employee on leaves.emp_id = employee.emp_id "
				+ "where year(leaves.leave_from)=:currentYear and leaves.status=:leaveStatus and "
				+ "employee.status=:empStatus "
				+ "group by EmpName, leave_type.Name "
				+ "order by EmpName "
				+ ") as Result "
				+ "group by EmpName";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("leaveStatus", "Approved");
		query.setParameter("empStatus", true);
		
		List<Object[]> result = query.list();
		return result;
	}

	public float getPendingLeaveCountByYearForCEO() {
		String sql = "select count(leaves.leave_id) as count from leaves where "
				+ "year(leaves.leave_from)=:currentYear and leaves.status=:status";

		Query query = session().createSQLQuery(sql);

		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("status", "Pending");

		if (query.uniqueResult() == null) {
			return 0;
		} else {
			float count = ((Number) query.uniqueResult()).floatValue();
			return count;
		}
	}

}
