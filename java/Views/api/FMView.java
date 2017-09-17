package Views.api;

import android.content.Context;
import android.view.MotionEvent;
import android.view.View;
import android.widget.FrameLayout;

@SuppressWarnings("deprecation")
public class FMView extends View {

	public FMView(Context context) {
		super(context);
		setClickable(true);
	}
	
	public FMView(Context context,int width,int height) {
		super(context);
		setPos(width,height);
	}
	
	public FMView(Context context,int width,int height,int x,int y) {
		super(context);
		setPos(width,height);
		setX(x);
		setY(y);
	}
	
	@Override
	public void setClickable(boolean clickable) {
		click = clickable;
		super.setClickable(clickable);
	}
	
	public int height;
	public int width;
	public void setPos(int width,int height){
		this.height = height;
		this.width = width;
		setLayoutParams(new FrameLayout.LayoutParams(width, height));
	}
	
	public void onDown(MotionEvent event){
		
	}

	public void onUp(MotionEvent event){
	
	}
	
	public boolean click = true;
	
	@Override
	public boolean onTouchEvent(MotionEvent event) {
		if(click){
			switch (event.getAction()) {
			case MotionEvent.ACTION_DOWN:
				onDown(event);
			case MotionEvent.ACTION_MOVE:
				onMove(event);
				break;
			case MotionEvent.ACTION_OUTSIDE:
				onOut(event);
			case MotionEvent.ACTION_UP:
				onUp(event);
				break;
			default:
				onleave(event);
			}
			if(!clickLisner){
				return true;
			}
		}
		return super.onTouchEvent(event);
	}
	
	public boolean clickLisner = false;
	
	@Override
	public void setOnClickListener(OnClickListener l) {
		if(l != null){
			clickLisner = true;
		}else{
			clickLisner = false;
		}
		super.setOnClickListener(l);
	}

	public void onleave(MotionEvent event) {
		// TODO Auto-generated method stub
		
	}

	public void onOut(MotionEvent event) {
		// TODO Auto-generated method stub
		
	}

	public void onMove(MotionEvent event) {
		// TODO Auto-generated method stub
		
	}

	public void setAnim(int y) {
		// TODO Auto-generated method stub
		
	}
	
}
