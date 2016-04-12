package com.inexisconsulting.dao;

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
@Component("userDao")
public class UserDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getAllUsers() {
		return session().createQuery("from User").list();
	}

	public void deleteUser(User user) {
		Query query = session().createQuery("delete from User where id=:id");
		query.setInteger("id", user.getId());
		query.executeUpdate();
	}

	public User getEditUser(User user) {
		Criteria crit = session().createCriteria(User.class);
		crit.add(Restrictions.eq("id", user.getId()));
		User uniqueUser = (User)crit.uniqueResult(); 
		return uniqueUser;
	}

	public void updateEditUser(User user) {
		Criteria crit = session().createCriteria(User.class);
		crit.add(Restrictions.eq("username", user.getUsername()));
		User updatedUser = (User)crit.uniqueResult();
		updatedUser.setAuthority(user.getAuthority());
		updatedUser.setEmail(user.getEmail());
		updatedUser.setEnabled(user.isEnabled());
		session().saveOrUpdate(updatedUser);
	}

	public void addNewUser(User user) {
		if(checkUserExists(user) == true){
			session().saveOrUpdate(user);
		}
	}

	public boolean checkUserExists(User user) {
		Criteria crit = session().createCriteria(User.class);
		crit.add(Restrictions.eq("username", user.getUsername()));
		User userExists = (User)crit.uniqueResult();
		return userExists == null;
	}

	public User getUser(User user) {
		Criteria crit = session().createCriteria(User.class);
		crit.add(Restrictions.eq("username", user.getUsername()));
		User fetchedUser = (User)crit.uniqueResult(); 
		return fetchedUser;
	}
}
