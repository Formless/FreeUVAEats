package com.example.cs4720.phase4;
import java.sql.Time;
import java.util.Date;

//container class for each "free crap" event on Grounds
public class GroundsEvent2 {
	private String from;
	private String subject;
	private Date date;
	private String body;
	private Time time;
	//TODO: Add time
	
	public GroundsEvent2(String from, String subject, Date date,
			String description, Time t) {
		super();
		this.from = from;
		this.subject = subject;
		this.date = date;
		this.body = description;
		this.time = t;
	}
	
	public String getFrom() {
		return from;
	}



	public void setFrom(String from) {
		this.from = from;
	}



	public String getSubject() {
		return subject;
	}



	public void setSubject(String subject) {
		this.subject = subject;
	}



	public Date getDate() {
		return date;
	}



	public void setDate(Date date) {
		this.date = date;
	}



	public String getDescription() {
		return body;
	}



	public void setDescription(String description) {
		this.body = description;
	}



	@Override
	public String toString() {
		return subject + " on " + date.getMonth() + "/" + date.getDate() + " at " + time
				+ "\n" + "Description: " + body;
	}
	
	public String toTwitter() {
		return subject + " on " + date.getMonth() + "/" + date.getDate() + " at " + time;
	}
	
	
}
