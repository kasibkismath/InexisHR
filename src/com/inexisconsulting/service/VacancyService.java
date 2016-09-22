package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Vacancy;
import com.inexisconsulting.dao.VacancyDAO;

@Service("vacancyService")
public class VacancyService {
	
	@Autowired
	private VacancyDAO vacancyDao;

	public List<Vacancy> getVacanciesByYear() {
		return vacancyDao.getVacanciesByYear();
	}

	public boolean checkDuplicateVacancy(Vacancy vacancy) {
		return vacancyDao.checkDuplicateVacancy(vacancy);
	}

	public void addVacancy(Vacancy vacancy) throws ParseException {
		vacancyDao.addVacancy(vacancy);
	}
}
