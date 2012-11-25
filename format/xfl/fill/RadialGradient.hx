package format.xfl.fill;


import format.xfl.geom.Matrix;
import haxe.xml.Fast;


class RadialGradient {
	
	
	public var entries:Array <GradientEntry>;
	public var matrix:Matrix;
	public var spreadMethod:String;
	

	public function new () {
		
		entries = new Array <GradientEntry> ();
		
	}
	
	
	public static function parse (xml:Fast):RadialGradient {
		
		var radialGradient = new RadialGradient ();
		
		radialGradient.spreadMethod = xml.att.spreadMethod;
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "matrix":
					
					radialGradient.matrix = Matrix.parse (element.elements.next ());
				
				case "GradientEntry":
					
					radialGradient.entries.push (GradientEntry.parse (element));
				
			}
			
		}
		
		return radialGradient;
		
	}
	
	
}