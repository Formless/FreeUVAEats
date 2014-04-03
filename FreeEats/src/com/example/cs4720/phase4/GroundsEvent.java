package com.example.cs4720.phase4;
import java.sql.Time;
import java.util.Date;

//container class for each "free crap" event on Grounds
public class GroundsEvent {
	private Date e_date;
	private Time e_time;
	private String e_body;
	private String e_subject;
	private String e_from;
	
	//e_from, e_subject, e_date, e_time, e_body
	

	public Date getEvent_date() {
		return e_date;
	}
	public void setEvent_date(Date event_date) {
		this.e_date = event_date;
	}
	public Time getEvent_time() {
		return e_time;
	}
	public void setEvent_time(Time event_time) {
		this.e_time = event_time;
	}
	public String getDescription() {
		return e_body;
	}
	public void setDescription(String description) {
		this.e_body = description;
	}
	
	public GroundsEvent(String subject, String from, Date event_date,
			Time event_time, String description) {
		super();
		this.e_subject = subject;
		this.e_from = from;
		this.e_date = event_date;
		this.e_time = event_time;
		this.e_body = description;
	}
	
	@Override
	public String toString() {
		return e_subject + " on " + e_date.getMonth() + "/" + e_date.getDate() + " at " + e_time
				+ "\n" + "Description: " + e_body;
	}
	
	public String toTwitter() {
		return e_subject + " on " + e_date.getMonth() + "/" + e_date.getDate() + " at " + e_time;
	}
	public Date getE_date() {
		return e_date;
	}
	public void setE_date(Date e_date) {
		this.e_date = e_date;
	}
	public Time getE_time() {
		return e_time;
	}
	public void setE_time(Time e_time) {
		this.e_time = e_time;
	}
	public String getE_body() {
		return e_body;
	}
	public void setE_body(String e_body) {
		this.e_body = e_body;
	}
	public String getE_subject() {
		return e_subject;
	}
	public void setE_subject(String e_subject) {
		this.e_subject = e_subject;
	}
	public String getE_from() {
		return e_from;
	}
	public void setE_from(String e_from) {
		this.e_from = e_from;
	}
	
	
	
}
