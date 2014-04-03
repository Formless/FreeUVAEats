package com.example.cs4720.phase4;

import java.util.List;
import android.content.Context;
import android.widget.ArrayAdapter;

import com.example.cs4720.phase4.GroundsEvent;


public class GroundsEventArrayAdapter extends ArrayAdapter<GroundsEvent>{

	public GroundsEventArrayAdapter(Context context, int textViewResourceId,
			List<GroundsEvent> objects) {
		super(context, textViewResourceId, objects);
		
	}
}
