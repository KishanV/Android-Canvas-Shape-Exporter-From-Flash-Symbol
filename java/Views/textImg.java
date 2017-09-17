package Views;

import com.linedeer.game.ab;

import android.graphics.LinearGradient;
import android.graphics.Rect;
import android.graphics.Shader.TileMode;

import Views.api.shapeImg;

import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Canvas;

public class textImg extends shapeImg {

	public Paint P0 = new Paint();

	float Ht = 5;
	float Wh = 379;
	float lastPOint;

	int[] colors = new int[] { Color.parseColor("#ffffffff"), Color.parseColor("#ffffffff"), Color.parseColor("#00ffffff") };
	float[] points;

	public textImg(int width, int height, int x, int y, int Size) {

		P0.setAntiAlias(true);
		P0.setColor(Color.parseColor("#ffffffff"));
		P0.setTextSize(Size);
		P0.setTypeface(ab.cd.cuprumFont);
		this.height = height;
		this.width = width;
		init((float) width / (float) Wh, (float) height / (float) Ht, x, y);

		lastPOint = ((100f / width) * (width - (ab.cd.DPIX[30]))) / 100f;
		LinearGradient Lg = null;

		points = new float[] { 0.0f, lastPOint, 1.0f };
		Lg = new LinearGradient(0, 2, 379, 2, colors, points, TileMode.CLAMP);
		Lg.setLocalMatrix(matrix);
		// P0.setShader(Lg);
		
	}

	public String Text = "";
	public float Y = 0;
	public float X = 0;
	
	public void setText(String text) {
		Text = text;
		Rect bounds = new Rect();

		P0.getTextBounds(text, 0, text.length(), bounds);
		if(width == 0 ||  height == 0){
			width = (bounds.right - bounds.left);
			height = (bounds.bottom - bounds.top);
		}
		Y = (int) ((-bounds.top) + ((height - (bounds.bottom - bounds.top)) / 2f));
		X = 0;
	}

	

	public void setText(String text, boolean center) {
		Text = text;
		Rect bounds = new Rect();

		P0.getTextBounds(text, 0, text.length(), bounds);
		if(width == 0 || height == 0){
			 width = (bounds.right - bounds.left);
		 	  height = (bounds.bottom - bounds.top);
		}
		Y = (int) ((-bounds.top) + ((height - (bounds.bottom - bounds.top)) / 2f));

		if (width < (bounds.right + bounds.left)) {
			X = 0;
		} else {
			X = (width - (bounds.right + bounds.left)) / 2f;
			// P0.setTextAlign(Align.CENTER);
		}
	}

	public void draw(Canvas canvas) {
		// canvas.drawPath(S0, P0);
		canvas.drawText(Text, x + X, y + Y, P0);
	}

	public float textX() {
		return x + X;
	}

	public float textY() {
		return y + Y;
	}

	public void setEfects(int[] colors, float[] points) {
		points[points.length - 2] = lastPOint;
		LinearGradient Lg = new LinearGradient(0, 2, 379, 2, colors, points, TileMode.CLAMP);
		Lg.setLocalMatrix(matrix);
		P0.setShader(Lg);
	}

	public void removeEfects() {
		points = new float[] { 0.0f, 1.0f, 1.0f };
		LinearGradient Lg = new LinearGradient(0, 2, 379, 2, colors, points, TileMode.CLAMP);
		Lg.setLocalMatrix(matrix);
		P0.setShader(Lg);
	}

	public void setColor(int color) {
		int[] colors = new int[] {
				color,
				color,
				Color.argb(0, Color.red(color), Color.green(color),
						Color.blue(color)) };
		float[] points = new float[] { 0.0f, 1.0f, 1.0f };

		points[points.length - 2] = lastPOint;
		LinearGradient Lg = new LinearGradient(0, 2, 379, 2, colors, points,
				TileMode.CLAMP);
		Lg.setLocalMatrix(matrix);
		P0.setShader(Lg);
	}
}