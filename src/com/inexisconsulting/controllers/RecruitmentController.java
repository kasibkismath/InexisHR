package com.inexisconsulting.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Vacancy;
import com.inexisconsulting.service.VacancyService;

@Controller
public class RecruitmentController {

	@Autowired
	private VacancyService vacancyService;

	@RequestMapping("/Recruitment")
	@SuppressWarnings("unchecked")
	public String showAttendanceMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Recruitment/recruitmentMain";
	}

	// get all vacancies by current year
	@RequestMapping(value = "/Recruitment/GetVacanciesByYear", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Vacancy> getVacanciesByYear() {
		return vacancyService.getVacanciesByYear();
	}

	// add vacancy
	@RequestMapping(value = "/Recruitment/AddVacancy", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addVacancy(@RequestBody Vacancy vacancy) throws ParseException {
		vacancyService.addVacancy(vacancy);
	}

	// checks for duplicate vacancy by vacancy title and added date = current
	// date
	@RequestMapping(value = "/Recruitment/CheckDuplicateVacancy", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateVacancy(@RequestBody Vacancy vacancy) {
		return vacancyService.checkDuplicateVacancy(vacancy);
	}

}
