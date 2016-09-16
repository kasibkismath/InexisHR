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
}
