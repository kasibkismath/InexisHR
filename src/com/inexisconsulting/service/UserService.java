package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.User;
import com.inexisconsulting.dao.UserDAO;

@Service("userService")
public class UserService {
	
	@Autowired
	private UserDAO userDao;
	
	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}

	public void deleteUser(User user) {
		userDao.deleteUser(user);
	}

	public User getEditUser(User user) {
		return userDao.getEditUser(user);
		
	}

	public void updateEditUser(User user) {
		userDao.updateEditUser(user);
		
	}

	public void addNewUser(User user) {
		userDao.addNewUser(user);
	}

	public boolean checkUserExists(User user) {
		return userDao.checkUserExists(user);
		
	}
}
