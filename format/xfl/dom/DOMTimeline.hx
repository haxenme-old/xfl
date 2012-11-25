package format.xfl.dom;


import haxe.xml.Fast;


class DOMTimeline {
	
	
	public var layers:Array <DOMLayer>;
	public var name:String;
	
	
	public function new () {
		
		layers = new Array <DOMLayer> ();
		
	}
	
	
	public static function parse (xml:Fast):DOMTimeline {
		
		var timeline = new DOMTimeline ();
		
		if (xml.has.name) timeline.name = xml.att.name;
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "layers":
					
					for (layer in element.elements) {
						
						timeline.layers.push (DOMLayer.parse (layer));
						
					}
				
			}
			
		}
		
		return timeline;
		
	}
	
	
}