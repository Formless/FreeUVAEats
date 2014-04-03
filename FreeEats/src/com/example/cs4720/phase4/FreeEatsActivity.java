package com.example.cs4720.phase4;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import oauth.signpost.OAuth;

import org.json.JSONException;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;


import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ContextMenu;  
import android.view.ContextMenu.ContextMenuInfo;  
import android.view.MenuInflater;
import com.example.cs4720.phase4.R;


public class FreeEatsActivity extends Activity {
	
	 private static final String OAUTH_KEY = "0Oxgh7CrYiaaX8JihSyQ";
	    private static final String OAUTH_SECRET = "WdOZYbtSvKfiq97im927602D1D28NiyXVYnlo3CWXdg";
	
	private JSONparser parser;
	private Button parseJSON; //get all from plato
	private EditText search;  
	private Button parseJSON2; //search from heroku
	private String query;
	
	private ListView groundsEventView;
	private GroundsEvent2ArrayAdapter geventAdapter;
	private GroundsEvent2ArrayAdapter geventAdapter2;
	private ArrayList<GroundsEvent2> data = new ArrayList<GroundsEvent2>();
	private ArrayList<GroundsEvent2> data2 = new ArrayList<GroundsEvent2>();
	
	private Twitter tweet;
	private String tweetStatus = "";
	private SharedPreferences prefs;
	private final Handler mTwitterHandler = new Handler();
	private TextView loginStatus;

	
	final Runnable mUpdateTwitterNotification = new Runnable() {
        public void run() {
        	Toast.makeText(getBaseContext(), "Tweet sent", Toast.LENGTH_LONG).show();
        }
    };
	
    /** Called when the activity is first created. */
    @SuppressWarnings("deprecation")
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        this.prefs = PreferenceManager.getDefaultSharedPreferences(this);
        loginStatus = (TextView)findViewById(R.id.login_status);
        /*
        String username = prefs.getString("username", "n/a");
        String password = prefs.getString("password", "n/a");
        if (username != null && password != null){
          tweet = new Twitter(username, password);
        }
        */
        geventAdapter = new GroundsEvent2ArrayAdapter(getApplicationContext(), android.R.layout.simple_list_item_1, data);
        groundsEventView = (ListView)findViewById(R.id.groundsEventView);
        groundsEventView.setAdapter(geventAdapter);
        
        parseJSON = (Button) findViewById(R.id.parseJSONButton);
        
        parseJSON.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				parser = new JSONparser();
				groundsEventView.setAdapter(geventAdapter);
		        try {
					//parser.parse("http://plato.cs.virginia.edu/~em2ae/pewpew4720/results.json", 1);
		        	//parser.parse("http://phase3remake1112.heroku.com/foodevents.json", 2);
		        	parser.parse("http://plato.cs.virginia.edu/~em2ae/freeuvaeats/upcoming.json", 1);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (JSONException e) {
					e.printStackTrace();
				}
		        data.addAll(parser.data);
		        if(!data.isEmpty())	
		        	geventAdapter.notifyDataSetChanged();
		        Log.i("Web", "button pressed");
		        Log.i("Web", data.get(0).toString());
			}
        	
        	
        	
        });
        
        
        geventAdapter2 = new GroundsEvent2ArrayAdapter(getApplicationContext(), android.R.layout.simple_list_item_1, data2);
        search = (EditText)findViewById(R.id.search);     
        query = search.getText().toString();  
        parseJSON2 = (Button)this.findViewById(R.id.searchButton); 
        
        parseJSON2.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				query = search.getText().toString(); 
			
				groundsEventView.setAdapter(geventAdapter2);
				parser = new JSONparser();
				data2.clear();
		        try {
		        	//System.out.println("http://phase3pewpew4720.heroku.com/foodevents.json?utf8=%E2%9C%93&search="+query);
					parser.parse("http://phase3remake1112.heroku.com/foodevents.json?utf8=%E2%9C%93&search="+query, 2);
				} catch (IOException e) {
					e.printStackTrace();
				} catch (JSONException e) {
					e.printStackTrace();
				}
		        data2.addAll(parser.data2);
		        if(!data2.isEmpty())	
		        	geventAdapter2.notifyDataSetChanged();
		        Log.i("Web", "button pressed");
		        Log.i("Web", data2.get(0).toString());
			}  	
        });
        registerForContextMenu(groundsEventView);
      
        
        
        
        
    }
    
    
    /*
     * Holding a list item to bring up a menu
     * https://github.com/ddewaele/AndroidTwitterSample/blob/master/src/com/ecs/android/sample/twitter/AndroidTwitterSample.java
     * http://www.mikeplate.com/2010/01/21/show-a-context-menu-for-long-clicks-in-an-android-listview/
     */
    
    @Override
    public void onCreateContextMenu(ContextMenu menu, View v,
        ContextMenuInfo menuInfo) {
      if (v.getId()==R.id.groundsEventView) {
        AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo)menuInfo; 
        
        if(groundsEventView.getAdapter().getClass() == geventAdapter.getClass()){
        	menu.setHeaderTitle(data2.get(info.position).getSubject());
        	tweetStatus = data2.get(info.position).toTwitter();
        }
        else{ //gevent2*/
        	menu.setHeaderTitle(data2.get(info.position).getSubject());
        	tweetStatus = data2.get(info.position).toTwitter();
        }
        String[] menuItems = getResources().getStringArray(R.array.contextMenu);
        for (int i = 0; i<menuItems.length; i++) {
          menu.add(Menu.NONE, i, i, menuItems[i]);
        }
        
      }
    }
    
    @Override
    public boolean onContextItemSelected(MenuItem item) {
   
      AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo)item.getMenuInfo();
      int menuItemIndex = item.getItemId();
      String[] menuItems = getResources().getStringArray(R.array.contextMenu);
      String menuItemName = menuItems[menuItemIndex];
      String message;
      if(groundsEventView.getAdapter().getClass() == geventAdapter.getClass()){
    	  message = data2.get(info.position).toTwitter();
      }
      else{ //gevent2
    	  message = data2.get(info.position).toTwitter();
      }
      //tweet it if tweet button was selected
      if(menuItemIndex==0){
    	  if (TwitterUtils.isAuthenticated(prefs)) {
      		sendTweet(message);
      	} else {
				Intent i = new Intent(getApplicationContext(), PrepareRequestTokenActivity.class);
				i.putExtra("tweet_msg",message);
				startActivity(i);
      	}
      }

  
      return true;
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu){
      android.view.MenuInflater inflater = getMenuInflater();
      inflater.inflate(R.menu.menu, menu);
      return true;
    }
    
    // Called when menu item is selected //
    @Override
    public boolean onOptionsItemSelected(MenuItem item){
      
      switch(item.getItemId()){
      
      case R.id.menuPrefs:
        // Launch Prefs activity
        Intent i = new Intent(FreeEatsActivity.this, Prefs.class);
        startActivity(i);
        Toast.makeText(FreeEatsActivity.this, tweetStatus, Toast.LENGTH_LONG).show();
        break;
        
      }    
      return true;
    }
    
  
    @Override
	protected void onResume() {
		super.onResume();
		updateLoginStatus();
	}
    
    public void updateLoginStatus() {
		loginStatus.setText("Logged into Twitter : " + TwitterUtils.isAuthenticated(prefs));
	}
	

	public void sendTweet(final String message) {
		Thread t = new Thread() {
	        public void run() {

	        	try {
	        		TwitterUtils.sendTweet(prefs, message);
	        		mTwitterHandler.post(mUpdateTwitterNotification);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
	        }

	    };
	    t.start();
	}

	private void clearCredentials() {
		SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
		final Editor edit = prefs.edit();
		edit.remove(OAuth.OAUTH_TOKEN);
		edit.remove(OAuth.OAUTH_TOKEN_SECRET);
		edit.commit();
	}
	
	private String getTweetMsg() {
		return "Tweeting from Android App at " + new Date().toLocaleString();
	}
    
}