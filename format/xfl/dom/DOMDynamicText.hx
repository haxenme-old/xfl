package format.xfl.dom;


import format.xfl.geom.Matrix;
import haxe.xml.Fast;


class DOMDynamicText {
	
	
	public var height:Float;
	public var isSelectable:Bool;
	public var matrix:Matrix;
	public var name:String;
	public var width:Float;
	
	
	public function new () {
		
		
		
	}
	
	
	public static function parse (xml:Fast):DOMDynamicText {
		
		var dynamicText = new DOMDynamicText ();
		
		dynamicText.height = Std.parseFloat (xml.att.height);
		dynamicText.width = Std.parseFloat (xml.att.width);
		if (xml.has.name) dynamicText.name = xml.att.name;
		if (xml.has.isSelectable) dynamicText.isSelectable = (xml.att.isSelectable == "yes");
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "matrix":
					
					dynamicText.matrix = Matrix.parse (element.elements.next ());
				
			}
			
		}
		
		return dynamicText;
		
	}
	
	
}