package format.xfl.dom;


import format.xfl.edge.Edge;
import format.xfl.fill.FillStyle;
import format.xfl.stroke.StrokeStyle;
import haxe.xml.Fast;


class DOMShape {
	
	
	public var edges:Array <Edge>;
	public var fills:Array <FillStyle>;
	public var strokes:Array <StrokeStyle>;
	
	
	public function new () {
		
		edges = new Array <Edge> ();
		fills = new Array <FillStyle> ();
		strokes = new Array <StrokeStyle> ();
		
	}
	
	
	public static function parse (xml:Fast):DOMShape {
		
		var shape = new DOMShape ();
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "fills":
					
					for (childElement in element.elements) {
						
						shape.fills.push (FillStyle.parse (childElement));
						
					}
				
				case "strokes":
					
					for (childElement in element.elements) {
						
						shape.strokes.push (StrokeStyle.parse (childElement));
						
					}
				
				case "edges":
					
					for (childElement in element.elements) {
						
						var edge = Edge.parse (childElement);
						
						if (edge.edges != null && edge.edges != "") {
							
							shape.edges.push (edge);
							
						}
						
					}
				
			}
			
		}
		
		return shape;
		
	}
	
	
}