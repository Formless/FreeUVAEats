package com.example.cs4720.phase4;

import java.util.List;
import android.content.Context;
import android.widget.ArrayAdapter;

import com.example.cs4720.phase4.GroundsEvent2;


public class GroundsEvent2ArrayAdapter extends ArrayAdapter<GroundsEvent2>{

	public GroundsEvent2ArrayAdapter(Context context, int textViewResourceId,
			List<GroundsEvent2> objects) {
		super(context, textViewResourceId, objects);
		
	}
}
