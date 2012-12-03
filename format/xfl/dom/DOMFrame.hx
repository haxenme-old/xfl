package format.xfl.dom;


import haxe.xml.Fast;
import format.xfl.geom.MotionObject;


class DOMFrame {
	
	
	public var duration:Int;
	public var elements:Array <Dynamic>;
	public var index:Int;
	//public var keyMode:Int;
	public var motionObject:MotionObject;
	public var tweenType:String;
	
	
	public function new () {
		
		duration = 1;
		elements = new Array <Dynamic> ();
		
	}
	
	
	public static function parse (xml:Fast):DOMFrame {
		
		var frame = new DOMFrame ();
		
		frame.index = Std.parseInt (xml.att.index);
		if (xml.has.duration) frame.duration = Std.parseInt (xml.att.duration);
		if (xml.has.tweenType) frame.tweenType = xml.att.tweenType;
		//frame.keyMode = Std.parseInt (xml.att.keyMode);
		
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
							
							case "DOMDynamicText":
								
								frame.elements.push (DOMDynamicText.parse (childElement));
							
							case "DOMStaticText":
								
								frame.elements.push (DOMStaticText.parse (childElement));
							
							default:
								
								#if neko
								Sys.println ("Warning: Unrecognized DOMFrame element \"" + childElement.name + "\"");
								#end
							
						}
						
					}
				
				case "motionObjectXML":
					
					frame.motionObject = MotionObject.parse (element);
				
			}
			
		}
		
		return frame;
		
	}
	
	
}