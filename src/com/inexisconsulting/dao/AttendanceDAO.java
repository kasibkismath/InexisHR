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
@Component("attendanceDao")
public class AttendanceDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public boolean checkAttendanceDuplicate(Attendance attendance) throws HibernateException, ParseException {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = attendance.getDate();

		String stringDate = sdf.format(date);

		String sql = "select count(*) as count from attendance where emp_id=:empId and project_id=:projectId and "
				+ "task_type=:taskType and date=:date";

		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", attendance.getEmployee().getEmpId());
		query.setParameter("projectId", attendance.getProject().getProject_id());
		query.setParameter("taskType", attendance.getTask_type());
		query.setParameter("date", sdf.parse(stringDate));

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

	public void addAttendance(Attendance attendance) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = attendance.getDate();
		String stringDate = sdf.format(date);
		
		attendance.setDate(sdf.parse(stringDate));
		
		session().saveOrUpdate(attendance);
	}

	@SuppressWarnings("unchecked")
	public List<Attendance> getAttendancesByEmpId(Attendance attendance) {
		String hql = "from Attendance as attendance where attendance.employee.emp_id=:empId "
				+ "and year(attendance.date)=:currentYear order by attendance.date desc";

		Query query = session().createQuery(hql);
		query.setParameter("empId", attendance.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));

		List<Attendance> attendances = query.list();
		return attendances;
	}

	public Attendance getAttendanceByAttendanceId(Attendance attendance) {
		Criteria crit = session().createCriteria(Attendance.class);
		crit.add(Restrictions.eq("attd_id", attendance.getAttd_id()));
		Attendance result = (Attendance) crit.uniqueResult();
		return result;
	}

	public void updateAttendance(Attendance attendance) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = attendance.getDate();
		String stringDate = sdf.format(date);
		
		Criteria crit = session().createCriteria(Attendance.class);
		crit.add(Restrictions.eq("attd_id", attendance.getAttd_id()));

		Attendance updatedAttendance = (Attendance) crit.uniqueResult();
		
		updatedAttendance.setDate(sdf.parse(stringDate));
		updatedAttendance.setProject(attendance.getProject());
		updatedAttendance.setStatus(attendance.getStatus());
		updatedAttendance.setTask(attendance.getTask());
		updatedAttendance.setTask_type(attendance.getTask_type());
		updatedAttendance.setTime_spent(attendance.getTime_spent());
	}

}
