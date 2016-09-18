package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Task;
import com.inexisconsulting.dao.TaskDAO;

@Service("taskService")
public class TaskService {
	
	@Autowired
	private TaskDAO taskDao;
	
	public List<Task> getAllTasks() {
		return taskDao.getAllTasks();
	}

	public void addTask(Task task) throws ParseException {
		taskDao.addTask(task);
	}

	public boolean checkDuplicateTask(Task task) {
		return taskDao.checkDuplicateTask(task);
	}

	public List<Task> getAssignedTasksByLeadId(Task task) {
		return taskDao.getAssignedTasksByLeadId(task);
	}

	public Task getTaskByTaskId(Task task) {
		return taskDao.getTaskByTaskId(task);
	}

	public void updateTask(Task task) throws ParseException {
		taskDao.updateTask(task);
	}

	public void deleteTask(Task task) {
		taskDao.deleteTask(task);
	}

	public int getPendingTaskCount(Task task) {
		return taskDao.getPendingTaskCount(task);
	}

	public int getOnHoldTaskCount(Task task) {
		return taskDao.getOnHoldTaskCount(task);
	}

	public int getCompletedTaskCount(Task task) {
		return taskDao.getCompletedTaskCount(task);
	}

	public int getTerminatedTaskCount(Task task) {
		return taskDao.getTerminatedTaskCount(task);
	}

	public int getOverdueTaskCount(Task task) {
		return taskDao.getOverdueTaskCount(task);
	}

	public List<Object[]> getEmployeeTaskCompletionPercentage(Task task) {
		return taskDao.getEmployeeTaskCompletionPercentage(task);
	}

	public List<Task> getMyTasks(Task task) {
		return taskDao.getMyTasks(task);
	}

	public void updateMyTask(Task task) throws ParseException {
		taskDao.updateMyTask(task);
	}

	public List<Object[]> getTaskStatusAndCount(Task task) {
		return taskDao.getTaskStatusAndCount(task);
	}

	public int getCompletedTaskPercentageByEmployee(Task task) {
		return taskDao.getCompletedTaskPercentageByEmployee(task);
	}
}
