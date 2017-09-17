package Views.api;

import android.graphics.Canvas;
import android.graphics.Matrix;

public class shapeImg implements ShapeInterface{
	
	public float scalex;
	public float height;
	public float width;
	public float scaley;
	public float x;
	public float y;
	public Matrix matrix = new Matrix(); 
	public boolean changed = false;
	
	public void init(float scalex,float scaley,float x,float y) {
		this.scalex = scalex;
		this.scaley = scaley;
		this.x =  x;
		this.y =  y;
		matrix.postScale(scalex,scaley);
		matrix.postTranslate(x,y);
		
	} 
	
	public void setX(int x) {
		this.x = x; 
		matrix.reset();
		matrix.postScale(scalex,scaley);
		matrix.postTranslate(x,y);
		changed = true;
	}
	
	public void setY(int y) {
		this.y = y;
		matrix.reset();
		matrix.postScale(scalex,scaley);
		matrix.postTranslate(x,y);
		changed = true;
	}

	
	@Override
	public void setDown(){}
	
	@Override
	public void setUp(){}
	
	@Override
	public void draw(Canvas canvas) {}
}
