package format.xfl.dom;


import haxe.xml.Fast;


class DOMBitmapItem {
	
	
	public var bitmapDataHRef:String;
	//public var frameBottom:Int;
	//public var frameRight:Int;
	public var href:String;
	public var isJPEG:Bool;
	public var itemID:String;
	public var linkageClassName:String;
	public var linkageExportForAS:Bool;
	public var name:String;
	public var quality:Int;
	public var sourceExternalFilepath:String;
	public var sourceLastImported:Int;
	
	
	public function new () {
		
		
		
	}
	
	
	public static function parse (xml:Fast):DOMBitmapItem {
		
		var bitmapItem = new DOMBitmapItem ();
		
		bitmapItem.name = xml.att.name;
		bitmapItem.itemID = xml.att.itemID;
		if (xml.has.linkageClassName) bitmapItem.linkageClassName = xml.att.linkageClassName;
		if (xml.has.linkageExportForAS) bitmapItem.linkageExportForAS = (xml.att.linkageExportForAS == "true");
		bitmapItem.sourceExternalFilepath = xml.att.sourceExternalFilepath;
		bitmapItem.sourceLastImported = Std.parseInt (xml.att.sourceLastImported);
		bitmapItem.quality = Std.parseInt (xml.att.quality);
		bitmapItem.href = xml.att.href;
		bitmapItem.bitmapDataHRef = xml.att.bitmapDataHRef;
		//bitmapItem.frameRight = Std.parseInt (xml.att.frameRight);
		//bitmapItem.frameBottom = Std.parseInt (xml.att.frameBottom);
		if (xml.has.isJPEG) bitmapItem.isJPEG = (xml.att.isJPEG == "true");
		
		return bitmapItem;
		
	}
	
	
}