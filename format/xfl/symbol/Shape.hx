package format.xfl.symbol;


import format.xfl.dom.DOMShape;
import format.xfl.fill.LinearGradient;
import format.xfl.fill.SolidColor;
import format.xfl.fill.RadialGradient;
import format.xfl.stroke.SolidStroke;
import flash.display.GradientType;
import nme.display.Graphics;


class Shape extends nme.display.Shape {
	
	
	private var commands:Array <RenderCommand>;
	private var fillStyles:Array <RenderCommand>;
	private var lineStyles:Array <RenderCommand>;
	
	
	public function new (domShape:DOMShape) {
		
		super ();
		
		commands = [];
		fillStyles = readFillStyles (domShape);
		lineStyles = readLineStyles (domShape);
		
		var penX = 0.0;
		var penY = 0.0;
		
		var currentFill0 = -1;
		var currentFill1 = -1;
		var currentLine = -1;
		
		var edges = new Array <RenderCommand> ();
		var fills = new Array <ShapeEdge> ();
		
		for (edge in domShape.edges) {
			
			var newLineStyle = (edge.strokeStyle > -1 && edge.strokeStyle != currentLine);
			var newFillStyle0 = (edge.fillStyle0 > -1 && edge.fillStyle0 != currentFill0);
			var newFillStyle1 = (edge.fillStyle1 > -1 && edge.fillStyle1 != currentFill1);
			//var newStyles = (newLineStyle);
			
			//if (newLineStyle) {
				//
				// this isn't quite right ... when is the right time to flush the commands?
				//
				//flushCommands (edges, fills);
				//edges = [];
				//fills = [];
				//currentFill0 = -1;
				//currentFill1 = -1;
				//currentLine = -1;
				//
			//}
			
			if (newFillStyle0) {
				
				currentFill0 = edge.fillStyle0;
				
			}
			
			if (newFillStyle1) {
				
				currentFill1 = edge.fillStyle1;
				
			}
			
			if (newLineStyle) {
				
				var lineStyle = edge.strokeStyle;
				
				var func = lineStyles[lineStyle];
				edges.push (func);
				currentLine = lineStyle;
				
			}
			
			var data = edge.edges;
			
			if (data != null && data != "") {
				
				data = StringTools.replace (data, "!", " ! ");
				data = StringTools.replace (data, "|", " | ");
				data = StringTools.replace (data, "/", " | ");
				data = StringTools.replace (data, "[", " [ ");
				data = StringTools.replace (data, "]", " [ ");
				
				var cmds = data.split (" ");
				
				for (i in 0...cmds.length) {
					
					switch (cmds[i]) {
						
						case "!":
							
							var px = Std.parseInt (cmds[i + 1]) / 20;
							var py = Std.parseInt (cmds[i + 2]) / 20;
							
							//if (px != penX || py != penY) {
								
								edges.push (function (g:Graphics) {
									
									g.moveTo (px, py);
									
								});
								
							//}
							
							penX = px;
							penY = py;
						
						case "|":
							
							var px = Std.parseInt (cmds[i + 1]) / 20;
							var py = Std.parseInt (cmds[i + 2]) / 20;
							
							if (currentLine > 0) {
								
								edges.push (function (g:Graphics) {
									
									//trace ("lineTo");
									g.lineTo (px, py);
									
								});
								
							} else {
								
								edges.push (function (g:Graphics) {
									
									//trace ("moveTo");
									g.moveTo (px, py);
									
								});
								
							}
							
							if (currentFill0 > 0) {
								
								fills.push (ShapeEdge.line (currentFill0, penX, penY, px, py));
								
							}
							
							if (currentFill1 > 0) {
								
								fills.push (ShapeEdge.line (currentFill1, px, py, penX, penY));
								
							}
							
							penX = px;
							penY = py;
						
						case "[":
							
							var cx = Std.parseInt (StringTools.replace (cmds[i + 1], "#", "0x").split (".")[0]) / 20;
							var cy = Std.parseInt (StringTools.replace (cmds[i + 2], "#", "0x").split (".")[0]) / 20;
							var px = Std.parseInt (StringTools.replace (cmds[i + 3], "#", "0x").split (".")[0]) / 20;
							var py = Std.parseInt (StringTools.replace (cmds[i + 4], "#", "0x").split (".")[0]) / 20;
							
							if (currentLine > 0) {
								
								edges.push (function (g:Graphics) {
									
									//trace ("curveTo");
									g.curveTo (cx, cy, px, py);
									
								});
								
							}
							
							if (currentFill0 > 0) {
								
								fills.push (ShapeEdge.curve (currentFill0, penX, penY, cx, cy, px, py));
								
							}
							
							if (currentFill1 > 0) {
								
								fills.push (ShapeEdge.curve (currentFill1, px, py, cx, cy, penX, penY));
								
							}
							
							penX = px;
							penY = py;
							
					}
					
				}
				
			}
			
		}
		
		flushCommands (edges, fills);
		
		for (command in commands) {
			
			command (this.graphics);
			
		}
		
	}
	
	
	private function flushCommands (edges:Array <RenderCommand>, fills:Array <ShapeEdge>) {
		
		var left = fills.length;
		
		while (left > 0) {
			
			var first = fills[0];
			fills[0] = fills[--left];
			
			if (first.fillStyle >= fillStyles.length) {
				
				//throw ("Invalid fill style");
				continue;
				
			}
			
			commands.push (fillStyles[first.fillStyle]);
			
			var mx = first.x0;
			var my = first.y0;
			
			commands.push (function (gfx:Graphics) { 
				
				gfx.moveTo (mx, my);
				
			});
			
			commands.push (first.asCommand ());
			
			var prev = first;
			var loop = false;
			
			while (!loop) {
				
				var found = false;
				
				for (i in 0...left) {
					
					if (prev.connects(fills[i])) {
						
						prev = fills[i];
						fills[i] = fills[--left];
						
						commands.push (prev.asCommand ());
						
						found = true;
						
						if (prev.connects (first)) {
							
							loop = true;
							
						}
						
						break;
						
					}
					
				}
				
				if (!found) {
					
					/*trace("Remaining:");
					
					for (f in 0...left)
						fills[f].dump ();
					
					throw("Dangling fill : " + prev.x1 + "," + prev.y1 + "  " + prev.fillStyle);*/
					
					break;
					
				}
				
			}
			
		}
		
		if (fills.length > 0) {
			
			commands.push (function (gfx:Graphics) {
				
				gfx.endFill ();
				
			});
			
		}
		
		commands = commands.concat (edges);
		
		if (edges.length > 0) {
			
			commands.push (function(gfx:Graphics) {
				
				gfx.lineStyle ();
				
			});
			
		}
		
	}
	
	
	private function readFillStyles (domShape:DOMShape):Array <RenderCommand> {
		
		var result = [];
		
		// Special null fill-style
		result.push (function(g:Graphics) {
			
			g.endFill();
			
		});
		
		for (fillStyle in domShape.fills) {
			
			if (Std.is (fillStyle.data, SolidColor)) {
				
				var color = fillStyle.data.color;
				var alpha = fillStyle.data.alpha;
				
				result.push (function (g:Graphics) {
					
					g.beginFill (color, alpha);
					
				});
				
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
				
				result.push (function (g:Graphics) {
					
					g.beginGradientFill (GradientType.LINEAR, colors, alphas, ratios, data.matrix);
					
				});
				
			} else if (Std.is (fillStyle.data, RadialGradient)) {
				
				#if !html5
				var data:RadialGradient = cast fillStyle.data;
				
				var colors = [];
				var alphas = [];
				var ratios = [];
				
				for (entry in data.entries) {
					
					colors.push (entry.color);
					alphas.push (1);
					ratios.push (0xFF * entry.ratio);
					
				}
				
				result.push (function (g:Graphics) {
					
					g.beginGradientFill (GradientType.RADIAL, colors, alphas, ratios, data.matrix);
					
				});
				#end
				
			}
			
		}
		
		return result;
		
	}
	
	
	private function readLineStyles (domShape:DOMShape):Array <RenderCommand> {
		
		var result = [];
		
		// Special null line-style
		result.push (function (g:Graphics) {
			
			g.lineStyle ();
			
		});
		
		for (strokeStyle in domShape.strokes) {
			
			if (Std.is (strokeStyle.data, SolidStroke)) {
				
				if (Std.is (strokeStyle.data.fill, SolidColor)) {
					
					var weight = strokeStyle.data.weight;
					var color = strokeStyle.data.fill.color;
					var alpha = strokeStyle.data.fill.alpha;
					
					result.push (function (g:Graphics) { g.lineStyle (weight, color, alpha); } );
					
				}
				
			}
			
		}
		
		return result;
		
	}
	
	
	public function render (graphics:Graphics) {
		
		//waitingLoader = false;
		
		for (command in commands) {
			
			command (graphics);
			
		}
		
		//return waitingLoader;
		
	}
	

}


typedef RenderCommand = Graphics -> Void;


class ShapeEdge {
	
	
	public var fillStyle:Int;
	public var isQuadratic:Bool;
	public var cx:Float;
	public var cy:Float;
	public var x0:Float;
	public var x1:Float;
	public var y0:Float;
	public var y1:Float;
	
	
	public function new () {
		
		
		
	}
	
	
	public function asCommand ():RenderCommand {
		
		if (isQuadratic) {
			
			return function (gfx:Graphics) { 
				
				//trace ("lineTo");
				gfx.curveTo (cx, cy, x1, y1);
				
			}
			
		} else {
			
			return function (gfx:Graphics) { 
				
				//trace ("lineTo");
				gfx.lineTo (x1, y1); 
				
			}	
			
		}
		
	}
	
	
	public function connects (next:ShapeEdge) {
		
		return fillStyle == next.fillStyle && Math.abs (x1 - next.x0) < 0.00001 && Math.abs (y1 - next.y0) < 0.00001;
		
	}
	
	
	public static function curve (style:Int, x0:Float, y0:Float, cx:Float, cy:Float, x1:Float, y1:Float):ShapeEdge {
		
		var result = new ShapeEdge ();
		
		result.fillStyle = style;
		result.x0 = x0;
		result.y0 = y0;
		result.cx = cx;
		result.cy = cy;
		result.x1 = x1;
		result.y1 = y1;
		result.isQuadratic = true;
		
		return result;
		
	}
	
	
	public function dump ():Void {
		
		trace (x0 + "," + y0 + " -> " + x1 + "," + y1 + " (" + fillStyle + ")" );
		
	}
	
	
	public static function line (style:Int, x0:Float, y0:Float, x1:Float, y1:Float):ShapeEdge {
		
		var result = new ShapeEdge();
		
		result.fillStyle = style;
		result.x0 = x0;
		result.y0 = y0;
		result.x1 = x1;
		result.y1 = y1;
		result.isQuadratic = false;
		
		return result;
		
	}
	
	
}