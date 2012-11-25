package format.xfl.dom;


import haxe.xml.Fast;
import nme.Assets;

#if neko
import sys.io.File;
#end


class DOMSymbolItem {
	
	
	public var itemID:String;
	public var lastModified:Int;
	public var linkageClassName:String;
	public var linkageExportForAS:Bool;
	public var name:String;
	public var timeline:DOMTimeline;
	
	
	public function new () {
		
		
		
	}
	
	
	public static function load (path:String):DOMSymbolItem {
		
		var data = "";
		
		#if neko
		data = File.getContent (path);
		#else
		data = Assets.getText (path);
		#end
		
		var xml = new Fast (Xml.parse (data).firstElement ());
		return parse (xml);
		
	}
	
	
	public static function parse (xml:Fast):DOMSymbolItem {
		
		var symbolItem = new DOMSymbolItem ();
		
		symbolItem.name = xml.att.name;
		symbolItem.itemID = xml.att.itemID;
		if (xml.has.linkageExportForAS3) symbolItem.linkageExportForAS = (xml.att.linkageExportForAS == "true");
		if (xml.has.linkageClassName) symbolItem.linkageClassName = xml.att.linkageClassName;
		symbolItem.lastModified = Std.parseInt (xml.att.lastModified);
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "timeline":
					
					symbolItem.timeline = DOMTimeline.parse (element.elements.next ());
				
			}
			
		}
		
		return symbolItem;
		
	}
	
	
}