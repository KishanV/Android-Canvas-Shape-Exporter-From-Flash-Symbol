package Views.api;

import java.util.Calendar;

import com.animator.cubic;
import com.linedeer.game.ab;

import android.content.Context;
import android.graphics.Typeface;
import android.util.FloatMath;
import android.util.Log;
import android.view.VelocityTracker;
import android.view.ViewConfiguration;
import android.view.animation.Interpolator;

public class config {

	public float DPI;
	public int[] DPIX = new int[1001];
	public static Interpolator AF; 
	public boolean isLive = false;
	
	public static Interpolator TH  = new Interpolator() {
		public float getInterpolation(float t) {
			t -= 1.0f;
			return t * t * t * t * t + 1.0f;
		}
	};
	
	public  int DPW;
	public  int DPH;
	public Calendar Time;
	public boolean debug = false;

	public config(Context baseContext,int width,int height) {
		DPW = width;
		DPH = height;
		Time = Calendar.getInstance();
		DPI = baseContext.getResources().getDisplayMetrics().density;
		Log.i("My", DPI+" Dpi");
		for(int i = 1;i < 1001;i++){
			DPIX[i] = (int)(DPI * i);
		}
		AF = new cubic();
		init();
	}
	
	public float getFromDpi(float val){
		return val / DPI;
	}
	float PerHt = (100.0f / 725f);
	float PerWh = (100.0f / 480f);
	
	private float MainCtrlHeightPer = 0;
	public int Main_Ctrl_Mid_Height_Per = 0;
	public int Main_Ctrl_Mid_Width_Per = 0;
	
	public int MainCtrlHeight = 0;
	private float perht = 0; 
	private float perwh = 0;
	public Typeface cuprumFont;
	 
	public void init(){
		
		perht = (DPH/100f);
		perwh = (DPW/100f);
		//Ctrl Main Layout
		//Height 13.5 percent
		cuprumFont = Typeface.createFromAsset(ab.ef.getAssets(), "CUPRUM-REGULAR.TTF");
		MainCtrlHeight = (int)((PerHt * 108f) * (perht));	
		
		Main_Ctrl_Mid_Height_Per = (int)((PerHt * 69f) * (perht));
		Main_Ctrl_Mid_Width_Per = (int)((PerHt * 287f) * (perht));
	}
	
	public float DPIX(float val) {
		return (DPI * val);
	}
}
