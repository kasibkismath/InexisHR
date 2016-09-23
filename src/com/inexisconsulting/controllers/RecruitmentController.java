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

import com.inexisconsulting.dao.Applicant;
import com.inexisconsulting.dao.Vacancy;
import com.inexisconsulting.service.ApplicantService;
import com.inexisconsulting.service.VacancyService;

@Controller
public class RecruitmentController {

	@Autowired
	private VacancyService vacancyService;

	@Autowired
	private ApplicantService applicantService;

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

	// get vacancy by vacancy_id
	@RequestMapping(value = "/Recruitment/GetVacancyByVacancyId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Vacancy getVacancyByVacancyId(@RequestBody Vacancy vacancy) {
		return vacancyService.getVacancyByVacancyId(vacancy);
	}

	// update vacancy
	@RequestMapping(value = "/Recruitment/UpdateVacancy", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateVacancy(@RequestBody Vacancy vacancy) throws ParseException {
		vacancyService.updateVacancy(vacancy);
	}

	// delete vacancy
	@RequestMapping(value = "/Recruitment/DeleteVacancy", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteVacancy(@RequestBody Vacancy vacancy) {
		vacancyService.deleteVacancy(vacancy);
	}

	// get all applicants by current year of vacancy
	@RequestMapping(value = "/Recruitment/GetApplicantsByCurrentYear", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Applicant> getAllApplicantsByCurrentYear() {
		return applicantService.getAllApplicantsByCurrentYear();
	}

	// get all pending non expired vacancies
	@RequestMapping(value = "/Recruitment/GetAllPendingNonExpiredVacancies", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Vacancy> getAllPendingNonExpiredVacancies() {
		return vacancyService.getAllPendingNonExpiredVacancies();
	}

	// add applicant
	@RequestMapping(value = "/Recruitment/AddApplicant", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addApplicant(@RequestBody Applicant applicant) throws ParseException {
		applicantService.addApplicant(applicant);
	}

	// get applicant by applicant_id
	@RequestMapping(value = "/Recruitment/GetApplicantByApplicantId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Applicant getApplicantByApplicantId(@RequestBody Applicant applicant) {
		return applicantService.getApplicantByApplicantId(applicant);
	}

	// update applicant
	@RequestMapping(value = "/Recruitment/UpdateApplicant", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateApplicant(@RequestBody Applicant applicant) throws ParseException {
		applicantService.updateApplicant(applicant);
	}

	// delete applicant
	@RequestMapping(value = "/Recruitment/DeleteApplicant", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteApplicant(@RequestBody Applicant applicant) {
		applicantService.deleteApplicant(applicant);
	}
}
