package com.inexisconsulting.controllers;

import java.io.IOException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.User;
import com.inexisconsulting.service.UserService;

@Controller
public class AdministrationController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/administration")
	public String showAdministrationPage(Model model, Principal principal) {

		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Administration/administration";
	}

	@RequestMapping(value = "/administration/user/all", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<User> getAllUsers() {
		List<User> allUsers = userService.getAllUsers();
		return allUsers;
	}

	@RequestMapping(value = "/administration/user/delete", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public User deleteUser(@RequestBody User user) {
		userService.deleteUser(user);
		return user;
	}

	@RequestMapping(value = "/administration/user/getEditUser", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public User getEditUser(@RequestBody User user) {
		User getEditUser = userService.getEditUser(user);
		return getEditUser;
	}

	@RequestMapping(value = "/administration/user/updateEditUser", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateEditUser(@RequestBody User user) {
		userService.updateEditUser(user);
	}

	@RequestMapping(value = "/administration/user/addNewUser", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addNewUser(@RequestBody User user) {
		userService.addNewUser(user);
	}

	@RequestMapping(value = "/administration/user/checkUserExists", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkUserExists(@RequestBody User user) {
		return userService.checkUserExists(user);
	}

	/*
	 * Database Backup and Restore Code
	 * 
	 */

	@RequestMapping(value = "/backupDatabase", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public Map<String, Boolean> backupDataWithDatabase() {

		String dumpExePath = "mysqldump";
		String host = "localhost";
		String port = "3306";
		String user = "root";
		String password = "RootAdmin@123";
		String database = "test";
		String backupPath = System.getProperty("user.home") + "\\Downloads\\";

		boolean status = false;
		try {
			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy 'at time' HH-mm-ss");
			Date date = new Date();
			String filepath = database + "-DB-Backup-" + dateFormat.format(date) + ".sql";

			String batchCommand = "";
			if (password != "") {
				// Backup with database
				batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user + " -p" + password
						+ " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";
			} else {
				batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user
						+ " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";
			}

			Process runtime = Runtime.getRuntime().exec(batchCommand);
			int processComplete = runtime.waitFor();

			if (processComplete == 0) {
				status = true;
			} else {
				status = false;
			}
		} catch (IOException ioe) {
			System.out.println(ioe);
		} catch (Exception e) {
			System.out.println(e);
		}
		return Collections.singletonMap("success", status);
	}

	@RequestMapping(value = "/restoreDatabase", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Boolean> restoreDatabase(@RequestBody Map<String, Object> data) {
		String dbUserName = "root";
		String dbPassword = "RootAdmin@123";
		String database = "test";
		String source = "C:\\Users\\Kasib\\Desktop\\" + data.get("fileName").toString();

		String[] executeCmd = new String[] { "mysql", "--user=" + dbUserName, "--password=" + dbPassword, "-e",
				"source " + source };

		boolean status = false;
		Process runtimeProcess;
		try {
			runtimeProcess = Runtime.getRuntime().exec(executeCmd);
			int processComplete = runtimeProcess.waitFor();

			if (processComplete == 0) {
				status = true;
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
		return Collections.singletonMap("success", status);
	}

}
