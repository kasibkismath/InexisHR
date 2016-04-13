package com.inexisconsulting.controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.service.UserService;

@Controller
public class MainController {

	@Autowired
	private UserService userService;

	@RequestMapping("/header")
	public String headerPage() {
		return "header";
	}

	@RequestMapping(value = "/backupDatabase", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Boolean> backupDataWithDatabase(@RequestBody Map<String, Object> data) {

		String dumpExePath = data.get("dumpExePath").toString();
		String host = data.get("host").toString();
		String port = data.get("port").toString();
		String user = data.get("user").toString();
		String password = data.get("password").toString();
		String database = data.get("database").toString();
		String backupPath = data.get("backupPath").toString();

		boolean status = false;
		try {
			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			Date date = new Date();
			String filepath = "Inexis-HR-DB-Backup2-" + dateFormat.format(date) + ".sql";

			String batchCommand = "";
			if (password != "") {
				// Backup with database
				batchCommand = dumpExePath + " -u " + user + " -p " + password + " " + database
						+ ">" + backupPath + filepath;
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
}
