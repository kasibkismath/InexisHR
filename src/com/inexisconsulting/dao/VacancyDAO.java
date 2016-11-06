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
@Component("vacancyDAO")
public class VacancyDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<Vacancy> getVacanciesByYear() {
		String hql = "from Vacancy as vacancy where year(vacancy.added_date)=:currentYear and "
				+ "year(vacancy.expiry_date)=:currentYear";
		
		Query query = session().createQuery(hql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		
		List<Vacancy> result = query.list();
		return result;
	}

	public boolean checkDuplicateVacancy(Vacancy vacancy) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String sql = "select count(*) from vacancy where vacancy_title=:vacancyTitle and added_date=:currentDate";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("vacancyTitle", vacancy.getVacancy_title());
		query.setParameter("currentDate", sdf.format(date));
		
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

	public void addVacancy(Vacancy vacancy) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date addedDate = vacancy.getAdded_date();
		String stringAddedDate = sdf.format(addedDate);
		
		Date expiryDate = vacancy.getExpiry_date();
		String stringExpiryDate = sdf.format(expiryDate);
		
		vacancy.setAdded_date(sdf.parse(stringAddedDate));
		vacancy.setExpiry_date(sdf.parse(stringExpiryDate));
		
		session().saveOrUpdate(vacancy);
	}

	public Vacancy getVacancyByVacancyId(Vacancy vacancy) {
		Criteria crit = session().createCriteria(Vacancy.class);
		crit.add(Restrictions.eq("vacancy_id", vacancy.getVacancy_id()));
		Vacancy result = (Vacancy) crit.uniqueResult();
		return result;
	}

	public void updateVacancy(Vacancy vacancy) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date expiryDate = vacancy.getExpiry_date();
		String stringExpiryDate = sdf.format(expiryDate);
		
		Criteria crit = session().createCriteria(Vacancy.class);
		crit.add(Restrictions.eq("vacancy_id", vacancy.getVacancy_id()));

		Vacancy updatedVacancy = (Vacancy) crit.uniqueResult();
		
		updatedVacancy.setVacancy_title(vacancy.getVacancy_title());
		updatedVacancy.setJob_desc(vacancy.getJob_desc());
		updatedVacancy.setRoles_responsibilities(vacancy.getRoles_responsibilities());
		updatedVacancy.setExperience(vacancy.getExperience());
		updatedVacancy.setQualification(vacancy.getQualification());
		updatedVacancy.setExpiry_date(sdf.parse(stringExpiryDate));
		updatedVacancy.setStatus(vacancy.getStatus());
	}

	public void deleteVacancy(Vacancy vacancy) {
		Query query = session().createQuery("delete from Vacancy where vacancy_id=:vacancyId");
		query.setInteger("vacancyId", vacancy.getVacancy_id());
		query.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	public List<Vacancy> getAllPendingNonExpiredVacancies() {
		
		String hql = "from Vacancy as vacancy where vacancy.status=:status and vacancy.expiry_date>:currentDate";
		
		Query query = session().createQuery(hql);
		query.setParameter("status", "Pending");
		query.setParameter("currentDate", new Date());
		
		List<Vacancy> result = query.list();
		return result;
	}

	public int getExpiredVacanciesCount() {
		String sql = "select count(*) from vacancy where (status=:status and expiry_date<:currentDate) and "
				+ "(year(added_date)=:currentYear or "
				+ "year(expiry_date)=:currentYear)";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("status", "Pending");
		query.setParameter("currentDate", new Date());
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Vacancy> generateVacanciesReport() {
		String hql = "from Vacancy";
		
		Query query = session().createQuery(hql);
		
		List<Vacancy> result = query.list();
		return result;
	}

}
