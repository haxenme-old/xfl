package format.xfl.dom;


import format.xfl.geom.Matrix;
import format.xfl.geom.Point;
import haxe.xml.Fast;


class DOMBitmapInstance {
	
	
	public var libraryItemName:String;
	public var matrix:Matrix;
	public var transformationPoint:Point;
	
	
	public function new () {
		
		
		
	}
	
	
	public static function parse (xml:Fast):DOMBitmapInstance {
		
		var bitmapInstance = new DOMBitmapInstance ();
		
		bitmapInstance.libraryItemName = xml.att.libraryItemName;
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "transformationPoint":
					
					bitmapInstance.transformationPoint = Point.parse (element.elements.next ());
				
				case "matrix":
					
					bitmapInstance.matrix = Matrix.parse (element.elements.next ());
				
			}
			
		}
		
		return bitmapInstance;
		
	}
	
	
}