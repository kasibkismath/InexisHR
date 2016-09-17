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
}
