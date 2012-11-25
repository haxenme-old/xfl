package format.xfl.dom;


import format.xfl.misc.PrinterSettings;
import format.xfl.misc.PublishItem;
import haxe.io.Path;
import haxe.xml.Fast;
import nme.Assets;

#if neko
import sys.io.File;
#end


class DOMDocument {
	
	
	public var buildNumber:Int;
	public var creatorInfo:String;
	public var currentTimeline:Int;
	public var folders:Array <DOMFolderItem>;
	public var height:Int;
	public var majorVersion:Int;
	public var media:Hash <Dynamic>;
	public var nextSceneIdentifier:String;
	public var platform:String;
	public var playOptionsPlayFrameActions:Bool;
	public var playOptionsPlayLoop:Bool;
	public var playOptionsPlayPages:Bool;
	public var printerSettings:PrinterSettings;
	public var publishHistory:Array <PublishItem>;
	public var symbols:Hash <DOMSymbolItem>;
	public var timelines:Array <DOMTimeline>;
	public var versionInfo:String;
	public var viewAngle3D:Float;
	public var width:Int;
	public var xflVersion:Float;
	
	
	public function new () {
		
		folders = new Array <DOMFolderItem> ();
		media = new Hash <Dynamic> ();
		symbols = new Hash <DOMSymbolItem> ();
		timelines = new Array <DOMTimeline> ();
		publishHistory = new Array <PublishItem> ();
		
	}
	
	
	public static function load (path:String):DOMDocument {
		
		var data = "";
		
		#if neko
		data = File.getContent (path);
		#else
		data = Assets.getText (path);
		#end
		
		var xml = new Fast (Xml.parse (data).firstElement ());
		var libraryPath = Path.directory (path) + "/LIBRARY/";
		
		return parse (xml, libraryPath);
		
	}
	
	
	public static function parse (xml:Fast, libraryPath:String = ""):DOMDocument {
		
		var document = new DOMDocument ();
		
		document.width = Std.parseInt (xml.att.width);
		document.height = Std.parseInt (xml.att.height);
		document.currentTimeline = Std.parseInt (xml.att.currentTimeline);
		document.xflVersion = Std.parseFloat (xml.att.xflVersion);
		document.creatorInfo = xml.att.creatorInfo;
		document.platform = xml.att.platform;
		document.versionInfo = xml.att.versionInfo;
		document.majorVersion = Std.parseInt (xml.att.majorVersion);
		document.buildNumber = Std.parseInt (xml.att.buildNumber);
		document.viewAngle3D = Std.parseFloat (xml.att.viewAngle3D);
		document.nextSceneIdentifier = xml.att.nextSceneIdentifier;
		document.playOptionsPlayLoop = (xml.att.playOptionsPlayLoop == "true");
		document.playOptionsPlayPages = (xml.att.playOptionsPlayPages == "true");
		document.playOptionsPlayFrameActions = (xml.att.playOptionsPlayFrameActions == "true");
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "folders":
					
					for (folder in element.elements) {
						
						document.folders.push (DOMFolderItem.parse (folder));
						
					}
				
				case "media":
					
					for (medium in element.elements) {
						
						switch (medium.name) {
							
							case "DOMBitmapItem":
								
								var bitmapItem = DOMBitmapItem.parse (medium);
								document.media.set (bitmapItem.name, bitmapItem);
							
						}
						
					}
				
				case "symbols":
					
					for (symbol in element.elements) {
						
						var symbolItem = DOMSymbolItem.load (libraryPath + symbol.att.href);
						document.symbols.set (symbolItem.name, symbolItem);
						
					}
				
				case "timelines":
					
					for (timeline in element.elements) {
						
						document.timelines.push (DOMTimeline.parse (timeline));
						
					}
				
				case "printerSettings":
					
					document.printerSettings = PrinterSettings.parse (element);
				
				case "publishHistory":
					
					for (item in element.elements) {
						
						document.publishHistory.push (PublishItem.parse (item));
						
					}
				
			}
			
		}
		
		return document;
		
	}
	
	
}