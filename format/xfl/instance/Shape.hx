package format.xfl.instance;


import format.xfl.dom.DOMShape;
import format.xfl.edge.Edge;
import format.xfl.fill.LinearGradient;
import format.xfl.fill.RadialGradient;
import format.xfl.fill.SolidColor;
import format.xfl.stroke.SolidStroke;
import nme.display.GradientType;


class Shape extends nme.display.Shape {
	
	
	public function new (domShape:DOMShape) {
		
		super ();
		
		var fillIndex = 0;
		var strokeIndex = 0;
		
		for (edge in domShape.edges) {
			
			var updatedFill = false;
			
			if (edge.fillStyle0 == 0 && edge.fillStyle1 == 0) {
				
				if (fillIndex != 0) {
					
					graphics.endFill ();
					
				}
				
				fillIndex = 0;
				
			} else {
				
				if (edge.fillStyle0 > 0 && edge.fillStyle0 != fillIndex) {
					
					fillIndex = edge.fillStyle0;
					updatedFill = true;
					
				}
				
				if (edge.fillStyle1 > 0 && edge.fillStyle1 != fillIndex) {
					
					fillIndex = edge.fillStyle1;
					updatedFill = true;
					
				}
				
			}
			
			if (edge.strokeStyle > 0 && edge.strokeStyle != strokeIndex) {
				
				for (strokeStyle in domShape.strokes) {
					
					if (strokeStyle.index == edge.strokeStyle) {
						
						if (Std.is (strokeStyle.data, SolidStroke)) {
							
							if (Std.is (strokeStyle.data.fill, SolidColor)) {
								
								graphics.lineStyle (strokeStyle.data.weight, strokeStyle.data.fill.color, strokeStyle.data.fill.alpha);
								
							}
							
						}
						
					}
					
				}
				
			}
			
			if (updatedFill) {
				
				for (fillStyle in domShape.fills) {
					
					if (fillStyle.index == fillIndex) {
						
						if (Std.is (fillStyle.data, SolidColor)) {
							
							graphics.beginFill (cast (fillStyle.data, SolidColor).color);
							
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
				
			}
			
			renderEdge (edge);
			
		}
		
	}
	
	
	private function renderEdge (edge:Edge):Void {
		
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
							
							graphics.moveTo (x, y);
							
						}
					
					case "|":
						
						var x = Std.parseInt (commands[i + 1]) / 20;
						var y = Std.parseInt (commands[i + 2]) / 20;
						
						positionX = x;
						positionY = y;
						
						graphics.lineTo (x, y);
					
					case "[":
						
						var controlX = Std.parseInt (StringTools.replace (commands[i + 1], "#", "0x").split (".")[0]) / 20;
						var controlY = Std.parseInt (StringTools.replace (commands[i + 2], "#", "0x").split (".")[0]) / 20;
						var anchorX = Std.parseInt (StringTools.replace (commands[i + 3], "#", "0x").split (".")[0]) / 20;
						var anchorY = Std.parseInt (StringTools.replace (commands[i + 4], "#", "0x").split (".")[0]) / 20;
						
						positionX = anchorX;
						positionY = anchorY;
						
						graphics.curveTo (controlX, controlY, anchorX, anchorY);
					
				}
				
			}
			
		}
		
	}
	
	
}