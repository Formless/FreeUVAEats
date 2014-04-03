package com.example.cs4720.phase4;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONArray;
import org.json.JSONException;

public class Test {
	private static String read(Reader r) throws IOException{
		StringBuilder sb = new StringBuilder();
		int c;
		while((c = r.read()) != -1){
			sb.append((char)c);
		}
		return sb.toString();
	}
	
	public static void main(String[] args) throws IOException, JSONException{
		//JSONparser parser = new JSONparser();
		//parser.parse("http://plato.cs.virginia.edu/~em2ae/pewpew4720/results.json");
		/*
		InputStream is = new URL("http://plato.cs.virginia.edu/~em2ae/pewpew4720/results.json").openStream();
		try{
			BufferedReader r = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = read(r);
			System.out.println(jsonText);
		}
		finally{
			is.close();
		}*/
		System.out.println("blah");
	}
}
