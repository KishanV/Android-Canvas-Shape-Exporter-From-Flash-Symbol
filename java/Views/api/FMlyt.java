package Views.api;

import android.content.Context;
import android.widget.FrameLayout;

public class FMlyt extends FrameLayout{

	
	public FrameLayout.LayoutParams param;
	public FMlyt(Context context,int width,int height,int x,int y) {
		super(context);
	 
		param = new FrameLayout.LayoutParams(width, height);
		setLayoutParams(param);
		setX(x);
		setY(y);
	}
	
	public void init(){
		
	}
	
	public FMlyt(Context context, int width, int height) {
		super(context);
		param = new FrameLayout.LayoutParams(width, height);
		param.width = width;
		param.height = height;
		setLayoutParams(param);
	}
	
	public FMlyt(Context context) {
		super(context);
	}
	
	public void setSize(int width, int height){
		param.width = width;
		param.height = height;
		setLayoutParams(param);
	}
	
	public void setWidth(int width){
		param.width = width;
		setLayoutParams(param);
	}
	
	public void setHeight(int height){
		param.height = height;
		setLayoutParams(param);
	}
}
