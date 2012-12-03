package format.xfl.dom;


import format.xfl.geom.Matrix;
import haxe.xml.Fast;


class DOMStaticText {
	
	
	public var height:Float;
	public var isSelectable:Bool;
	public var left:Float;
	public var matrix:Matrix;
	public var textRuns:Array <DOMTextRun>;
	public var width:Float;
	
	
	public function new () {
		
		textRuns = new Array <DOMTextRun> ();
		
	}
	
	
	public static function parse (xml:Fast):DOMStaticText {
		
		var staticText = new DOMStaticText ();
		
		staticText.height = Std.parseFloat (xml.att.height);
		staticText.width = Std.parseFloat (xml.att.width);
		if (xml.has.left) staticText.left = Std.parseFloat (xml.att.left);
		if (xml.has.isSelectable) staticText.isSelectable = (xml.att.isSelectable == "yes");
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "matrix":
					
					staticText.matrix = Matrix.parse (element.elements.next ());
				
				case "textRuns":
					
					for (childElement in element.elements) {
						
						staticText.textRuns.push (DOMTextRun.parse (childElement));
						
					}
				
				//case "filters":
					
					//<DropShadowFilter blurX="2" blurY="2" distance="1" quality="3" strength="0.3"/>
				
			}
			
		}
		
		return staticText;
		
	}
	
	
}