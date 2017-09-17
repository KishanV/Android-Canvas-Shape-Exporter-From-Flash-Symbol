package com.codeazur.as3swf.exporters
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.exporters.core.DefaultShapeExporter;
	import com.codeazur.as3swf.utils.NumberUtils;
	import com.codeazur.utils.StringUtils;
	
	import flash.display.CapsStyle;
	import flash.display.InterpolationMethod;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class AndroidPaint extends DefaultShapeExporter
	{
		protected var _actionScript:String;
		
		var Pkg:String;
		var Ex:String;
		var Name:String;
		var Wh:String;
		var Ht:String;
		var colors:Array = new Array();
		
		public function AndroidPaint(swf:SWF,Pkg:String,Ex:String,Name:String,Wh:String,Ht:String) {
			super(swf);
			this.Pkg = Pkg;
			this.Ex = Ex;
			this.Name = Name;
			this.Wh = Wh;
			this.Ht = Ht;
			OpenScript();
		}
		
		function OpenScript(){
			_actionScript = Pkg+"\r\rimport android.content.Context;\r\nimport Views.api.FMView;\r\nimport android.graphics.LinearGradient;\r\nimport android.graphics.Shader.TileMode;\r\nimport android.graphics.Path;\r\nimport Views.api.ShapeView;\r\nimport Views.api.shapeImg;\r\nimport android.graphics.Color;\r\nimport android.graphics.Paint;\r\nimport android.graphics.Canvas;\r\nimport com.linedeer.music.player.ab; \r\r";
			_actionScript += "public class "+Name+" extends shapeImg{ \r\r\r\r";
		}
		
		public function finish():void{
			
			
			
			for(var i=0;i < Paints.length-1;i++){
				_actionScript += "		public Paint P"+i+" = new Paint(); \r		public static int Color"+i+" = "+(colors[i] == undefined ? "0" : colors[i])+"; \r		public Path"+i+" S"+i+" = new Path"+i+"();\r\r";
			}
			
			_actionScript += "		public static float Ht = "+Ht+"F; \r";
			_actionScript += "		public static float Wh = "+Wh+"F; \r\r";
			
			_actionScript += "\r 		public "+Name+"(int width,int height,int x,int y) {\r\r			this.width = width;\r			this.height = height;\r\r			init((float)width/(float)Wh, (float)height/(float)Ht, x, y);";
			_actionScript += "\r 			LinearGradient Lg  = null;\r";
			
			for(var i=0;i < Paints.length-1;i++){
				
				
				for(var j=1;j < Paints[i].length;j++){
					//_actionScript += "			S"+i+".init(Ht,Wh);\r";
					_actionScript += "			S"+i+".transform(matrix);\r";
					_actionScript += "			"+Paints[i][j]+"";
					_actionScript += "			P"+i+".setAntiAlias(true);\r";
				}
				_actionScript += "\r";
			}
			_actionScript += "			mask = S0;\r			maskPaint = P0;\r\r";
			
			_actionScript += "		}\r\r";
			
			
			_actionScript += "\r 		public void draw(Canvas canvas) {\r 			if(drawing){\r";
			for(var i=0;i < Paints.length-1;i++){
				
				
				for(var j=1;j < Paints[i].length;j++){
					_actionScript += "				canvas.drawPath(S"+i+", P"+i+");";
				}
				_actionScript += "\r";
			} 
			_actionScript += "			}\r		}\r\r";
			
			
			_actionScript += "\r 		@Override\n 		public void setX(int x) {\r			super.setX(x);\r";
			for(var i=0;i < Paints.length-1;i++){ 
				for(var j=1;j < Paints[i].length;j++){
					_actionScript += "			 S"+i+".transform(matrix);";
				}
				_actionScript += "\r";
			} 
			_actionScript += "		}\r\r";
			
			
			_actionScript += "\r 		@Override\n 		public void setY(int x) {\r			super.setY(x);\r";
			for(var i=0;i < Paints.length-1;i++){ 
				for(var j=1;j < Paints[i].length;j++){
					_actionScript += "			 S"+i+".transform(matrix);";
				}
				_actionScript += "\r";
			} 
			_actionScript += "		}\r\r";
			
			
			_actionScript += "\r 		@Override\n 		public void setSize(int wh, int ht) {\r			super.setSize(wh, ht);\r";
			for(var i=0;i < Paints.length-1;i++){ 
				for(var j=1;j < Paints[i].length;j++){
					_actionScript += "			 S"+i+".transform(matrix);";
				}
				_actionScript += "\r";
			} 
			_actionScript += "		}\r\r 		 public static ShapeView getFMview(Context context,boolean mask){\r\n\t\t   ShapeView view = new ShapeView(context, ab.cd.getHt((int) Wh),ab.cd.getHt((int) Ht));\r\n\t\t   final "+this.Name+" viewImg = new "+this.Name+"(ab.cd.getHt((int) Wh),ab.cd.getHt((int) Ht),0,0);\r\n\t\t   view.mask = mask;\r\n\t\t   view.img = viewImg;\r\n\t\t   viewImg.mask = viewImg.S0;\r\n\t\t   viewImg.maskPaint = viewImg.P0; \r\n\t\t   return view;\r\n\t\t }     ";
			
			_actionScript += "\r\r 		 public static "+this.Name+" getShape(){\r\n\t\t   final "+this.Name+" viewImg = new "+this.Name+"(ab.cd.getHt((int) Wh),ab.cd.getHt((int) Ht),0,0);\r\n\t\t   viewImg.mask = viewImg.S0;\r\n\t\t   viewImg.maskPaint = viewImg.P0; \r\n\t\t   return viewImg;\r\n\t\t }";
			
			_actionScript += "\r\r		 public static int getBackgroundColor(){ return Color0; }"; 
			
			_actionScript += "\n}";
			
			_actionScript += "//Finished...!";
		}
		
		var Paints:Array = [];
		var Pcount:int = -1;
		public function get actionScript():String { return _actionScript; }
		
		override public function beginShape():void {
			Pcount++;
			Paints[Pcount] = new Array();
			Paints[Pcount].push("");
			
		}
		
		
		
		override public function beginFills():void {
			//Pcount++;
			
			
		}

		override public function beginLines():void {
			_actionScript += "// Lines:\r";
		}
		
		override public function beginFill(color:uint, alpha:Number = 1.0):void {
			_actionScript += "class Path"+Pcount+" extends Path{ \r 	public Path"+Pcount+"() {\r";
			if (alpha != 1.0) {
				
				colors.push(StringUtils.printf("(0x%02x%06x)",alpha*255,color));
				Paints[Pcount].push(StringUtils.printf("P"+Pcount+".setColor(0x%02x%06x);\r",alpha*255,color));
				//_actionScript += StringUtils.printf("paint.setColor(0x%02x%06x);\r",alpha*100,color);
			} else {
				colors.push(StringUtils.printf("(0xFF%06x)", color));
				Paints[Pcount].push(StringUtils.printf("P"+Pcount+'.setColor(0xFF%06x);\r', color));
				//_actionScript += StringUtils.printf('paint.setColor(%06x);\r', color);
			}
		}
		
		override public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0):void {
			var asMatrix:String = "null";
			//var from:Point = new Point(-819.2 * matrix.a + matrix.tx, -819.2 * matrix.b + matrix.ty);
			//var to:Point = new Point(819.2 * matrix.a + matrix.tx, 819.2 * matrix.b + matrix.ty);
			
			if (matrix != null) {
				asMatrix = 
					Math.round(-819.2 * matrix.a + matrix.tx) + "," + 
					Math.round(-819.2 * matrix.b + matrix.ty) + "," + 
					Math.round(819.2 * matrix.a + matrix.tx) + "," + 
					Math.round(819.2 * matrix.b + matrix.ty);
			}
import com.codeazur.as3swf.utils.ObjCUtils;

			var asColors:String = "";
			for (var i:uint = 0; i < colors.length; i++) {
				asColors += StringUtils.printf('0x%02x%06x',alphas[i]*255, colors[i]);
				ratios[i] = ObjCUtils.num2str(Number(ratios[i]) / 255);
				if (i < colors.length - 1) { asColors += ","; }
			}
			if (focalPointRatio != 0.0) {
				/*_actionScript += StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s, '%s', '%s', %s);\r", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix,
					spreadMethod,
					interpolationMethod,
					focalPointRatio.toString());*/
			} else if (interpolationMethod != InterpolationMethod.RGB) {
				/**_actionScript += StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s, '%s', '%s'\r);", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix,
					spreadMethod,
					interpolationMethod);/
			} else if (spreadMethod != SpreadMethod.PAD) {
				/*_actionScript += StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s], %s, '%s');\r", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","),
					asMatrix,
					spreadMethod);*/
			} else if (matrix != null) {
				
				_actionScript += "class Path"+Pcount+" extends Path{ \r 	public Path"+Pcount+"() {\r";
				
				Paints[Pcount].push( StringUtils.printf("Lg = new LinearGradient(%s, new int[]{%s}, new float[]{%s}, TileMode.MIRROR);\r", 
					asMatrix,
					asColors,
					ratios.join(",")) 
					+"			Lg.setLocalMatrix(matrix);\r"
					+"			P"+Pcount+".setShader(Lg);\r");
					
			} else {
				/*_actionScript += StringUtils.printf("graphics.beginGradientFill('%s', [%s], [%s], [%s]);\r", 
					type,
					asColors,
					alphas.join(","),
					ratios.join(","));*/
			}
		}
		
		override public function beginBitmapFill(bitmapId:uint, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void {
			var asMatrix:String = "null";
			if (matrix != null) {
				asMatrix = "new Matrix(" + 
					matrix.a + "," + 
					matrix.b + "," + 
					matrix.c + "," + 
					matrix.d + "," + 
					matrix.tx + "," + 
					matrix.ty + ")";
			}
			if (smooth) {
				_actionScript += StringUtils.printf("// graphics.beginBitmapFill(%d, %0d, %0d, %0d);\r", bitmapId, asMatrix, repeat, smooth);
			} else if (!repeat) {
				_actionScript += StringUtils.printf("// graphics.beginBitmapFill(%d, %0d, %0d, %0d);\r", bitmapId, asMatrix, repeat);
			} else {
				_actionScript += StringUtils.printf("// graphics.beginBitmapFill(%d, %0d, %0d, %0d);\r", bitmapId, asMatrix);
			}
		}
		
		override public function endFill():void {
			_actionScript += "	}\r}\r\r";
			Pcount++;
			Paints[Pcount] = new Array();
			Paints[Pcount].push("");
		}
		
		override public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = LineScaleMode.NORMAL, startCaps:String = null, endCaps:String = null, joints:String = null, miterLimit:Number = 3):void {
			if (miterLimit != 3) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %0d, %0d, %0d, %0d, %f);\r", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(startCaps == null ? "null" : "'" + startCaps + "'"),
					(joints == null ? "null" : "'" + joints + "'"),
					miterLimit);
			} else if (joints != null && joints != JointStyle.ROUND) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %0d, %0d, %0d, %0d);\r", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					(startCaps == null ? "null" : "'" + startCaps + "'"),
					"'" + joints + "'");
			} else if(startCaps != null && startCaps != CapsStyle.ROUND) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %0d, %0d, %0d);\r", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"),
					"'" + startCaps + "'");
			} else if(scaleMode != LineScaleMode.NORMAL) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %0d, %0d);\r", 
					thickness, color, alpha, pixelHinting.toString(),
					(scaleMode == null ? "null" : "'" + scaleMode + "'"));
			} else if(pixelHinting) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f, %0d);\r", 
					thickness, color, alpha, pixelHinting.toString());
			} else if(alpha != 1.0) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x, %f);\r", thickness, color, alpha);
			} else if(color != 0) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f, 0x%06x);\r", thickness, color);
			} else if(!isNaN(thickness)) {
				_actionScript += StringUtils.printf("graphics.lineStyle(%f);\r", thickness);
			} else {
				_actionScript += "graphics.lineStyle();\r";
			}
		}
		
		override public function moveTo(x:Number, y:Number):void {
			_actionScript += StringUtils.printf("			moveTo(%0sf, %0sf);\r",
				NumberUtils.roundPixels400(x),
				NumberUtils.roundPixels400(y)
			);
		}
		
		override public function lineTo(x:Number, y:Number):void {
			_actionScript += StringUtils.printf("			lineTo(%0sf, %0sf);\r",
				NumberUtils.roundPixels400(x),
				NumberUtils.roundPixels400(y)
			);
		}
		
		override public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void {
			_actionScript += StringUtils.printf("			quadTo(%0sf, %0sf, %0sf, %0sf);\r",
				NumberUtils.roundPixels400(controlX),
				NumberUtils.roundPixels400(controlY),
				NumberUtils.roundPixels400(anchorX),
				NumberUtils.roundPixels400(anchorY)
			);
		}
	}
}
