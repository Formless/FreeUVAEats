package com.example.cs4720.phase4;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class JSONparser {
	public ArrayList<GroundsEvent2> data = new ArrayList<GroundsEvent2>();
	public ArrayList<GroundsEvent2> data2 = new ArrayList<GroundsEvent2>();

	private static String read(Reader r) throws IOException{
		StringBuilder sb = new StringBuilder();
		int c;
		while((c = r.read()) != -1){
			sb.append((char)c);
		}
		return sb.toString();
	}


	public static JSONArray readJSONArrayFromWeb(String url) throws IOException, JSONException{
		InputStream is = new URL(url).openStream();
		try{
			BufferedReader r = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = read(r);
			JSONArray array = new JSONArray(jsonText);
			return array;
		}
		finally{
			is.close();
		}

	}

	public void parse(String url, int option) throws IOException, JSONException
	{
		data = new ArrayList<GroundsEvent2>();
		data2 = new ArrayList<GroundsEvent2>();
		JSONArray j = readJSONArrayFromWeb(url);
		if(option == 1)
			convertJSONtoGE(j);
		if(option == 2)
			convertJSONtoGE2(j);
	}

	
	public void convertJSONtoGE(JSONArray jarray) throws JSONException{
		String from, dateText, subject, description, timeText;
		data2.clear();
		for(int i = 0;i<jarray.length();i++){
			JSONObject jobj = jarray.getJSONObject(i);
			GroundsEvent2 ge;
			from = (String)jobj.get("e_from");
			subject = (String)jobj.get("e_subject");
			dateText = (String)jobj.get("e_date");
			description = (String)jobj.get("e_body");
			timeText = (String)jobj.get("e_time");
			
			if(from == null || subject == null || dateText == null || description == null || timeText == null){
				return;
			}
			
			//convert date to proper format
			String[] timedata = timeText.split(":");
			String[] datedata = dateText.split("-");
			
			Date d = new Date(Integer.parseInt(datedata[0]), Integer.parseInt(datedata[1]), Integer.parseInt(datedata[2]));
			Time t = new Time(Integer.parseInt(timedata[0]), Integer.parseInt(timedata[1]), 0);
			//put object in arraylist
			ge = new GroundsEvent2(from, subject, d, description, t);
			data2.add(ge);
			data.add(ge);

		}
		
	}

	public void convertJSONtoGE2(JSONArray jarray) throws JSONException{
		String from, dateText, subject, description, timeText;
		data2.clear();
		for(int i = 0;i<jarray.length();i++){
			JSONObject jobj = jarray.getJSONObject(i);
			GroundsEvent2 ge;
			from = (String)jobj.get("from");
			subject = (String)jobj.get("subject");
			dateText = (String)jobj.get("date");
			description = (String)jobj.get("body");
			timeText = (String)jobj.get("time");
			
			if(from == null || subject == null || dateText == null || description == null || timeText == null){
				return;
			}
			
			//convert date to proper format
			String[] timedata = timeText.split(":");
			String[] datedata = dateText.split("-");
			
			Date d = new Date(Integer.parseInt(datedata[0]), Integer.parseInt(datedata[1]), Integer.parseInt(datedata[2]));
			Time t = new Time(Integer.parseInt(timedata[0]), Integer.parseInt(timedata[1]), 0);
			//put object in arraylist
			ge = new GroundsEvent2(from, subject, d, description, t);
			data2.add(ge);
			data.add(ge);

		}
		//System.out.println("-------------" + data2.size());
	}

}
