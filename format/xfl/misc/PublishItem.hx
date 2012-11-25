package format.xfl.misc;


import haxe.xml.Fast;


class PublishItem {
	
	
	public var publishSize:Int;
	public var publishTime:Int;
	
	
	public function new () {
		
		
		
	}
	
	
	public static function parse (xml:Fast):PublishItem {
		
		var publishItem = new PublishItem ();
		
		publishItem.publishSize = Std.parseInt (xml.att.publishSize);
		publishItem.publishTime = Std.parseInt (xml.att.publishTime);
		
		return publishItem;
		
	}
	
	
}