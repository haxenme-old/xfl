package format.xfl.dom;


import haxe.xml.Fast;


class DOMFrame {
	
	
	public var elements:Array <Dynamic>;
	public var index:Int;
	public var keyMode:Int;
	
	
	public function new () {
		
		elements = new Array <Dynamic> ();
		
	}
	
	
	public static function parse (xml:Fast):DOMFrame {
		
		var frame = new DOMFrame ();
		
		frame.index = Std.parseInt (xml.att.index);
		frame.keyMode = Std.parseInt (xml.att.keyMode);
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "elements":
					
					for (childElement in element.elements) {
						
						switch (childElement.name) {
							
							case "DOMBitmapInstance":
								
								frame.elements.push (DOMBitmapInstance.parse (childElement));
							
							case "DOMShape":
								
								frame.elements.push (DOMShape.parse (childElement));
							
							case "DOMSymbolInstance":
								
								frame.elements.push (DOMSymbolInstance.parse (childElement));
							
						}
						
					}
				
			}
			
		}
		
		return frame;
		
	}
	
	
}