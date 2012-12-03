package format.xfl.dom;


import haxe.BaseCode;
import haxe.xml.Fast;


class DOMLayer {
	
	
	public var animationType:String;
	//public var autoNamed:Bool;
	//public var color:Int;
	//public var current:Bool;
	public var frames:Array <DOMFrame>;
	//public var isSelected:Bool;
	public var layerType:String;
	//public var locked:Bool;
	//public var name:String;
	
	
	public function new () {
		
		frames = new Array <DOMFrame> ();
		
	}
	
	
	public static function parse (xml:Fast):DOMLayer {
		
		var layer = new DOMLayer ();
		
		if (xml.has.animationType) layer.animationType = xml.att.animationType;
		//layer.name = xml.att.name;
		//layer.color = Std.parseInt ("0x" + xml.att.color.substr (1));
		//if (xml.has.current) layer.current = (xml.att.current == "true");
		//if (xml.has.isSelected) layer.isSelected = (xml.att.isSelected == "true");
		//if (xml.has.locked) layer.locked = (xml.att.locked == "true");
		//if (xml.has.autoNamed) layer.autoNamed = (xml.att.autoNamed == "true");
		if (xml.has.layerType) layer.layerType = xml.att.layerType;
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "frames":
					
					for (frame in element.elements) {
						
						layer.frames.push (DOMFrame.parse (frame));
						
					}
				
			}
			
		}
		
		return layer;
		
	}
	
	
}