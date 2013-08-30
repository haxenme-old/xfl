package format;


import format.xfl.dom.DOMBitmapItem;
import format.xfl.dom.DOMDocument;
import format.xfl.dom.DOMSymbolItem;
#if nme
import format.xfl.symbol.MovieClip;
import nme.display.BitmapData;
import nme.geom.Matrix;
import nme.Assets;
#end
import haxe.io.Path;



class XFL {
	
	
	public var document:DOMDocument;
	public var path:String;
	
	
	public function new (path:String) {
		
		this.path = path;
		
		document = DOMDocument.load (Path.directory (path) + "/DOMDocument.xml");
		
	}
	
	#if nme
	public function getBitmapData (name:String):BitmapData {
		
		for (medium in document.media) {
			
			if (medium.linkageClassName == name && medium.linkageExportForAS == true) {
				
				if (Std.is (medium, DOMBitmapItem)) {
					
					var bitmapItem = cast (medium, DOMBitmapItem);
					
					return Assets.getBitmapData (Path.directory (path) + "/bin/" + bitmapItem.bitmapDataHRef);
					
				}
				
			}
			
		}
		
		return null;
		
	}
	
	
	public function createMovieClip (name:String = ""):format.display.MovieClip {
		
		var timeline = null;
		
		if (name == "") {
			
			//timeline = document.timelines[document.currentTImeline];
			timeline = document.timelines[0];
			
		} else {
			
			for (symbol in document.symbols) {
				
				if (symbol.linkageClassName == name && symbol.linkageExportForAS == true) {
					
					if (Std.is (symbol, DOMSymbolItem)) {
						
						timeline = symbol.timeline;
						
					}
					
				}
				
			}
			
		}
		
		if (timeline != null) {
			
			return new MovieClip (this, timeline);
			
		}
		
		return null;
		
	}
	#end
	
	
}