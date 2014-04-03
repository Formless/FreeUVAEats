package com.example.cs4720.phase4;

import oauth.signpost.OAuth;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import android.content.SharedPreferences;

public class TwitterUtils {

	public static boolean isAuthenticated(SharedPreferences prefs) {

		//returning null
		
		//382834326-zTYbTDtWHzPPWslB78mWsAhKOLtPcfPNIXksktVO
		String token = prefs.getString(OAuth.OAUTH_TOKEN, "");
		//QCxu5ihKZEJpoUKrdGC6Bg5prB1D5kLySpeQdF0yWo
		String secret = prefs.getString(OAuth.OAUTH_TOKEN_SECRET, "");

		System.out.println(token + " ! ");
		System.out.println(secret + " ! ");
		
		

		try {
			AccessToken a = new AccessToken(token,secret);
			Twitter twitter = new TwitterFactory().getInstance();
			twitter.setOAuthConsumer(Constants.CONSUMER_KEY, Constants.CONSUMER_SECRET);
			twitter.setOAuthAccessToken(a);
			twitter.getAccountSettings();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public static void sendTweet(SharedPreferences prefs,String msg) throws Exception {
		String token = prefs.getString(OAuth.OAUTH_TOKEN, "");
		String secret = prefs.getString(OAuth.OAUTH_TOKEN_SECRET, "");

		AccessToken a = new AccessToken(token,secret);
		Twitter twitter = new TwitterFactory().getInstance();
		twitter.setOAuthConsumer(Constants.CONSUMER_KEY, Constants.CONSUMER_SECRET);
		twitter.setOAuthAccessToken(a);
        twitter.updateStatus(msg);
	}	
}
