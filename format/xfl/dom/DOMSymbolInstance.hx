package format.xfl.dom;


import format.xfl.geom.Matrix;
import format.xfl.geom.Point;
import haxe.xml.Fast;


class DOMSymbolInstance {
	
	
	public var centerPoint3DX:Float;
	public var centerPoint3DY:Float;
	public var libraryItemName:String;
	public var loop:String;
	public var matrix:Matrix;
	public var selected:Bool;
	public var symbolType:String;
	public var transformationPoint:Point;
	
	
	public function new () {
		
		matrix = new Matrix ();
		transformationPoint = new Point ();
		
	}
	
	
	public static function parse (xml:Fast):DOMSymbolInstance {
		
		var symbolInstance = new DOMSymbolInstance ();
		
		symbolInstance.libraryItemName = xml.att.libraryItemName;
		
		if (xml.has.centerPoint3DX) {
			
			symbolInstance.centerPoint3DX = Std.parseFloat (xml.att.centerPoint3DX);
			symbolInstance.centerPoint3DY = Std.parseFloat (xml.att.centerPoint3DY);
			
		}
		
		if (xml.has.selected) {
			
			symbolInstance.selected = (xml.att.selected == "true");
			
		}
		
		if (xml.has.symbolType) {
			
			symbolInstance.symbolType = xml.att.symbolType;
			
		}
		
		if (xml.has.loop) {
			
			symbolInstance.loop = xml.att.loop;
			
		}
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "transformationPoint":
					
					symbolInstance.transformationPoint = Point.parse (element.elements.next ());
				
				case "matrix":
					
					symbolInstance.matrix = Matrix.parse (element.elements.next ());
				
			}
			
		}
		
		return symbolInstance;
		
	}
	
	
}