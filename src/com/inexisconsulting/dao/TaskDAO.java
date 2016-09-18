package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("taskDao")
public class TaskDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Task> getAllTasks() {
		return session().createQuery("from Tasks tasks order by tasks.expected_start_date desc").list();
	}

	public void addTask(Task task) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date expectedStartDate = task.getExpected_start_date();
		String stringExpectedStartDate = sdf.format(expectedStartDate);
		
		Date expectedEndDate = task.getExpected_end_date();
		String stringExpectedEndDate = sdf.format(expectedEndDate);
		
		task.setExpected_start_date(sdf.parse(stringExpectedStartDate));
		task.setExpected_end_date(sdf.parse(stringExpectedEndDate));
		
		session().saveOrUpdate(task);
	}

	public boolean checkDuplicateTask(Task task) {
		String sql = "select count(*) from task where task.emp_id=:empId and task_title=:taskTitle";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", task.getEmployee().getEmpId());
		query.setParameter("taskTitle", task.getTask_title());
		
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
	public List<Task> getAssignedTasksByLeadId(Task task) {
		String hql = "from Task as task where task.assigned_by.emp_id=:assignedBy and "
				+ "(year(task.expected_start_date)=:expStartDate or year(task.expected_end_date)=:expEndDate)";
		
		Query query = session().createQuery(hql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("expStartDate", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("expEndDate", Calendar.getInstance().get(Calendar.YEAR));
		
		List<Task> result= query.list();
		return result;
	}

	public Task getTaskByTaskId(Task task) {
		Criteria crit = session().createCriteria(Task.class);
		crit.add(Restrictions.eq("task_id", task.getTask_id()));
		Task result = (Task) crit.uniqueResult();
		return result;
	}

	public void updateTask(Task task) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date expectedStartDate = task.getExpected_start_date();
		String stringExpectedStartDate = sdf.format(expectedStartDate);
		
		Date expectedEndDate = task.getExpected_end_date();
		String stringExpectedEndDate = sdf.format(expectedEndDate);
		
		Criteria crit = session().createCriteria(Task.class);
		crit.add(Restrictions.eq("task_id", task.getTask_id()));

		Task updatedTask = (Task) crit.uniqueResult();
		
		updatedTask.setTask_title(task.getTask_title());
		updatedTask.setTask_desc(task.getTask_desc());
		updatedTask.setPriority(task.getPriority());
		updatedTask.setExpected_start_date(sdf.parse(stringExpectedStartDate));
		updatedTask.setExpected_end_date(sdf.parse(stringExpectedEndDate));
	}

	public void deleteTask(Task task) {
		Query query = session().createQuery("delete from Task where task_id=:taskId");
		query.setInteger("taskId", task.getTask_id());
		query.executeUpdate();
	}

	public int getPendingTaskCount(Task task) {
		String sql = "select count(*) from task where assigned_by=:assignedBy and status=:status and "
				+ "year(expected_start_date)=:expStartDate";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("status", "Pending");
		query.setParameter("expStartDate", Calendar.getInstance().get(Calendar.YEAR));
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	public int getOnHoldTaskCount(Task task) {
		String sql = "select count(*) from task where assigned_by=:assignedBy and status=:status and "
				+ "year(expected_start_date)=:expStartDate";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("status", "On-Hold");
		query.setParameter("expStartDate", Calendar.getInstance().get(Calendar.YEAR));
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	public int getCompletedTaskCount(Task task) {
		String sql = "select count(*) from task where assigned_by=:assignedBy and status=:status and "
				+ "year(expected_start_date)=:expStartDate";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("status", "Completed");
		query.setParameter("expStartDate", Calendar.getInstance().get(Calendar.YEAR));
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	public int getTerminatedTaskCount(Task task) {
		String sql = "select count(*) from task where assigned_by=:assignedBy and status=:status and "
				+ "year(expected_start_date)=:expStartDate";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("status", "Terminated");
		query.setParameter("expStartDate", Calendar.getInstance().get(Calendar.YEAR));
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	public int getOverdueTaskCount(Task task) {
		String sql = "select count(*) from task where assigned_by=:assignedBy and "
				+ "expected_end_date<:currentDate and status=:pendingStatus or status=:onHoldStatus";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("pendingStatus", "Pending");
		query.setParameter("onHoldStatus", "On-Hold");
		query.setParameter("currentDate", Calendar.getInstance());
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getEmployeeTaskCompletionPercentage(Task task) {
		String sql = "select Result1.EmpName as 'Emp Name', "
				+ "round((Result1.completedCount/Result2.totalCount) * 100,0) as 'Completion Percentage' "
				+ "from "
				+ "( "
				+ "select concat(emp.firstName, ' ' ,emp.lastName) as EmpName, count(*) as completedCount, "
				+ "emp.emp_id "
				+ "from task "
				+ "join employee as emp "
				+ "on task.emp_id = emp.emp_id "
				+ "where task.assigned_by=:assignedBy and year(task.expected_start_date)=:currentYear "
				+ "and task.status=:status  "
				+ "group by emp.emp_id "
				+ ") as Result1 "
				+ "inner join " 
				+ "( "
				+ "select concat(emp.firstName, ' ' ,emp.lastName) as EmpName, count(*) as totalCount, "
				+ "emp.emp_id "
				+ "from task  "
				+ "join employee as emp "
				+ "on task.emp_id = emp.emp_id "
				+ "where task.assigned_by=:assignedBy and year(task.expected_start_date)=:currentYear "
				+ "group by emp.emp_id "
				+ ") as Result2 "
				+ "on Result1.emp_id = Result2.emp_id";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("assignedBy", task.getAssigned_by().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("status", "Completed");
		
		List<Object[]> result = query.list();
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<Task> getMyTasks(Task task) {
		String hql = "from Task as task where task.employee.emp_id=:employee and "
				+ "(year(task.expected_start_date)=:expStartDate or year(task.expected_end_date)=:expEndDate)";
		
		Query query = session().createQuery(hql);
		query.setParameter("employee", task.getEmployee().getEmpId());
		query.setParameter("expStartDate", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("expEndDate", Calendar.getInstance().get(Calendar.YEAR));
		
		List<Task> result= query.list();
		return result;
	}

	public void updateMyTask(Task task) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date actualStartDate = task.getActual_start_date();
		String stringAcutalStartDate = sdf.format(actualStartDate);
		
		Date actualEndDate = task.getActual_end_date();
		String stringAcutalEndDate = sdf.format(actualEndDate);
		
		Criteria crit = session().createCriteria(Task.class);
		crit.add(Restrictions.eq("task_id", task.getTask_id()));

		Task updatedMyTask = (Task) crit.uniqueResult();
		
		updatedMyTask.setStatus(task.getStatus());
		updatedMyTask.setActual_start_date(sdf.parse(stringAcutalStartDate));
		updatedMyTask.setActual_end_date(sdf.parse(stringAcutalEndDate));
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getTaskStatusAndCount(Task task) {
		String sql = "select status, count(*) as count from task where emp_id=:empId and "
				+ "year(expected_start_date)=:currentYear "
				+ "group by status";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", task.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		
		List<Object[]> result = query.list();
		return result;
	}
	
	public int getCompletedTaskPercentageByEmployee(Task task) {
		String sql = "select "
				+ "round((Result1.completedCount/Result2.totalCount) * 100,0) as 'Completion Percentage' "
				+ "from "
				+ "( "
				+ "select count(*) as completedCount, emp.emp_id "
				+ "from task "
				+ "join employee as emp "
				+ "on task.emp_id = emp.emp_id "
				+ "where task.emp_id=:loggedInEmp and year(task.expected_start_date)=:currentYear "
				+ "and task.status=:status  "
				+ "group by emp.emp_id "
				+ ") as Result1 "
				+ "inner join " 
				+ "( "
				+ "select count(*) as totalCount, emp.emp_id "
				+ "from task  "
				+ "join employee as emp "
				+ "on task.emp_id = emp.emp_id "
				+ "where task.emp_id=:loggedInEmp and year(task.expected_start_date)=:currentYear "
				+ "group by emp.emp_id "
				+ ") as Result2 "
				+ "on Result1.emp_id = Result2.emp_id";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("loggedInEmp", task.getEmployee().getEmpId());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		query.setParameter("status", "Completed");
		
		if(query.uniqueResult() == null)
			return 0;
		
		int completedPercentage = ((Number) query.uniqueResult()).intValue();
		return completedPercentage; 
	}
}
