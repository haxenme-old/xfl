package format.xfl.dom;


import format.xfl.geom.Color;
import format.xfl.geom.Matrix;
import format.xfl.geom.Point;
import haxe.xml.Fast;


class DOMSymbolInstance {
	
	
	//public var centerPoint3DX:Float;
	//public var centerPoint3DY:Float;
	public var cacheAsBitmap:Bool;
	public var color:Color;
	public var exportAsBitmap:Bool;
	public var libraryItemName:String;
	public var loop:String;
	public var matrix:Matrix;
	public var name:String;
	//public var selected:Bool;
	public var symbolType:String;
	public var transformationPoint:Point;
	
	
	public function new () {
		
		
		
	}
	
	
	public function clone ():DOMSymbolInstance {
		
		var duplicate = new DOMSymbolInstance ();
		
		if (color != null) duplicate.color = new Color (color.redMultiplier, color.greenMultiplier, color.blueMultiplier, color.alphaMultiplier, color.redOffset, color.greenOffset, color.blueOffset, color.alphaOffset);
		duplicate.libraryItemName = libraryItemName;
		duplicate.loop = loop;
		if (matrix != null) duplicate.matrix = new Matrix (matrix.a, matrix.b, matrix.c, matrix.d, matrix.tx, matrix.ty);
		duplicate.name = name;
		duplicate.symbolType = symbolType;
		duplicate.transformationPoint = transformationPoint;
		
		return duplicate;
		
	}
	
	
	public static function parse (xml:Fast):DOMSymbolInstance {
		
		var symbolInstance = new DOMSymbolInstance ();
		
		symbolInstance.libraryItemName = xml.att.libraryItemName;
		//if (xml.has.centerPoint3DX) symbolInstance.centerPoint3DX = Std.parseFloat (xml.att.centerPoint3DX);
		//if (xml.has.centerPoint3DY) symbolInstance.centerPoint3DY = Std.parseFloat (xml.att.centerPoint3DY);
		if (xml.has.name) symbolInstance.name = xml.att.name;
		//if (xml.has.selected) symbolInstance.selected = (xml.att.selected == "true");
		if (xml.has.symbolType) symbolInstance.symbolType = xml.att.symbolType;
		if (xml.has.loop) symbolInstance.loop = xml.att.loop;
		if (xml.has.cacheAsBitmap) symbolInstance.cacheAsBitmap = (xml.att.cacheAsBitmap == "true");
		if (xml.has.exportAsBitmap) symbolInstance.exportAsBitmap = (xml.att.exportAsBitmap == "true");
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "transformationPoint":
					
					symbolInstance.transformationPoint = Point.parse (element.elements.next ());
				
				case "matrix":
					
					symbolInstance.matrix = Matrix.parse (element.elements.next ());
				
				case "color":
					
					symbolInstance.color = Color.parse (element.elements.next ());
				
			}
			
		}
		
		return symbolInstance;
		
	}
	
	
}