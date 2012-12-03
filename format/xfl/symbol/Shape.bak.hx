package format.xfl.instance;


import format.xfl.dom.DOMShape;
import format.xfl.edge.Edge;
import format.xfl.fill.LinearGradient;
import format.xfl.fill.RadialGradient;
import format.xfl.fill.SolidColor;
import format.xfl.stroke.SolidStroke;
import nme.display.GradientType;


class Shape extends nme.display.Shape {
	
	
	private var currentFill:Int;
	private var currentFill0:Int;
	private var currentFill1:Int;
	private var currentStroke:Int;
	private var domShape:DOMShape;
	
	
	public function new (domShape:DOMShape) {
		
		super ();
		
		this.domShape = domShape;
		
		currentFill = -1;
		currentFill0 = -1;
		currentFill1 = -1;
		currentStroke = -1;
		
		for (edge in domShape.edges) {
			
			if (edge.fillStyle0 == 0 && edge.fillStyle1 == 0) {
				
				if (currentFill != 0) {
					
					currentFill = 0;
					graphics.endFill ();
					
				}
				
			} else {
				
				if (edge.fillStyle0 > -1) {
					
					currentFill0 = edge.fillStyle0;
					
				}
				
				if (currentFill0 > 0) {
					
					if (currentFill0 != currentFill) {
						
						setFill (currentFill0);
						
					}
					
					renderEdge (edge, true);
					
				}
				
				if (edge.fillStyle1 > -1) {
					
					currentFill1 = edge.fillStyle1;
					
				}
				
				if (currentFill1 > 0) {
					
					if (currentFill1 != currentFill) {
						
						setFill (currentFill1);
						
					}
					
					renderEdge (edge, false);
					
				}
				
			}
			
		}
		
		for (edge in domShape.edges) {
			
			if (edge.strokeStyle != currentStroke) {
				
				setStroke (edge.strokeStyle);
				
			}
			
			//renderEdge (edge);
			
		}
		
	}
	
	
	private function renderEdge (edge:Edge, reverse:Bool = false):Void {
		
		var data = edge.edges;
		
		if (data != null && data != "") {
			
			data = StringTools.replace (data, "!", " ! ");
			data = StringTools.replace (data, "|", " | ");
			data = StringTools.replace (data, "/", " | ");
			data = StringTools.replace (data, "[", " [ ");
			data = StringTools.replace (data, "]", " [ ");
			
			var commands = data.split (" ");
			
			var positionX = 0.0;
			var positionY = 0.0;
			
			for (i in 0...commands.length) {
				
				switch (commands[i]) {
					
					case "!":
						
						var x = Std.parseInt (commands[i + 1]) / 20;
						var y = Std.parseInt (commands[i + 2]) / 20;
						
						if (positionX != x || positionY != y) {
							
							// fill style
							
							positionX = x;
							positionY = y;
							
							if (currentStroke == 0) { trace ("graphics.moveTo (" + x + ", " + y + ");"); }
							
							graphics.moveTo (x, y);
							
						}
					
					case "|":
						
						var x = Std.parseInt (commands[i + 1]) / 20;
						var y = Std.parseInt (commands[i + 2]) / 20;
						
						if (currentStroke == 0) { trace ("graphics.lineTo (" + x + ", " + y + ");"); }
						
						if (reverse) {
							
							graphics.moveTo (x, y);
							graphics.lineTo (positionX, positionY);
							graphics.moveTo (x, y);
							
						} else {
							
							graphics.lineTo (x, y);
							
						}
						
						positionX = x;
						positionY = y;
					
					case "[":
						
						var controlX = Std.parseInt (StringTools.replace (commands[i + 1], "#", "0x").split (".")[0]) / 20;
						var controlY = Std.parseInt (StringTools.replace (commands[i + 2], "#", "0x").split (".")[0]) / 20;
						var anchorX = Std.parseInt (StringTools.replace (commands[i + 3], "#", "0x").split (".")[0]) / 20;
						var anchorY = Std.parseInt (StringTools.replace (commands[i + 4], "#", "0x").split (".")[0]) / 20;
						
						if (currentStroke == 0) { trace ("graphics.curveTo (" + controlX + ", " + controlY + ", " + positionX + ", " + positionY + ");"); }
						
						if (reverse) {
							
							graphics.moveTo (anchorX, anchorY);
							graphics.curveTo (controlX, controlY, positionX, positionY);
							graphics.moveTo (anchorX, anchorY);
							
						} else {
							
							graphics.curveTo (controlX, controlY, anchorX, anchorY);
							
						}
						
						positionX = anchorX;
						positionY = anchorY;
					
				}
				
			}
			
		}
		
	}
	
	
	private function setFill (index:Int):Void {
		
		for (fillStyle in domShape.fills) {
			
			if (fillStyle.index == index) {
				
				if (Std.is (fillStyle.data, SolidColor)) {
					
					trace ("Fill: " + StringTools.hex (fillStyle.data.color));
					graphics.beginFill (fillStyle.data.color, fillStyle.data.alpha);
					
				} else if (Std.is (fillStyle.data, LinearGradient)) {
					
					var data:LinearGradient = cast fillStyle.data;
					
					var colors = [];
					var alphas = [];
					var ratios = [];
					
					for (entry in data.entries) {
						
						colors.push (entry.color);
						alphas.push (1);
						ratios.push (0xFF * entry.ratio);
						
					}
					
					graphics.beginGradientFill (GradientType.LINEAR, colors, alphas, ratios, data.matrix);
					
				} else if (Std.is (fillStyle.data, RadialGradient)) {
					
					var data:RadialGradient = cast fillStyle.data;
					
					var colors = [];
					var alphas = [];
					var ratios = [];
					
					for (entry in data.entries) {
						
						colors.push (entry.color);
						alphas.push (1);
						ratios.push (0xFF * entry.ratio);
						
					}
					
					graphics.beginGradientFill (GradientType.RADIAL, colors, alphas, ratios, data.matrix);
					
				}
				
			}
			
		}
		
		currentFill = index;
		
	}
	
	
	private function setStroke (index:Int):Void {
		
		if (index > 0) {
			
			for (strokeStyle in domShape.strokes) {
				
				if (strokeStyle.index == index) {
					
					if (Std.is (strokeStyle.data, SolidStroke)) {
						
						if (Std.is (strokeStyle.data.fill, SolidColor)) {
							
							graphics.lineStyle (strokeStyle.data.weight, strokeStyle.data.fill.color, strokeStyle.data.fill.alpha);
							
						}
						
					}
					
				}
				
			}
			
		} else {
			
			graphics.lineStyle ();
			
		}
		
		currentStroke = index;
		
	}
	
	
}