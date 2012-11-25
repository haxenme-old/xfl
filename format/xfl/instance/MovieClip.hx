package format.xfl.instance;


import format.xfl.dom.DOMBitmapInstance;
import format.xfl.dom.DOMShape;
import format.xfl.dom.DOMSymbolInstance;
import format.xfl.dom.DOMTimeline;
import format.XFL;
import haxe.io.Path;
import haxe.macro.Format;
import nme.display.Bitmap;
import nme.display.DisplayObject;
import nme.geom.Matrix;
import nme.Assets;


class MovieClip extends format.display.MovieClip {
	
	
	public function new (xfl:XFL, timeline:DOMTimeline) {
		
		super ();
		
		// need to implement playing past the first frame, borrow from the SWF library
		
		var layers = timeline.layers.copy ();
		layers.reverse ();
		
		for (layer in layers) {
			
			if (layer.layerType != "guide" && layer.frames.length > 0) {
				
				var frame = layer.frames[0];
				
				for (element in frame.elements) {
					
					if (Std.is (element, DOMSymbolInstance)) {
						
						var movieClip = createSymbol (xfl, cast element);
						
						if (movieClip != null) {
							
							addChild (movieClip);
							
						}
						
					} else if (Std.is (element, DOMBitmapInstance)) {
						
						var bitmap = createBitmap (xfl, cast element);
						
						if (bitmap != null) {
							
							addChild (bitmap);
							
						}
						
					} else if (Std.is (element, DOMShape)) {
						
						var shape = new Shape (cast element);
						addChild (shape);
						
					}
					
				}
				
			}
			
		}
		
	}
	
	
	private function createBitmap (xfl:XFL, instance:DOMBitmapInstance):Bitmap {
		
		var bitmap = null;
		var bitmapData = null;
		
		if (xfl.document.media.exists (instance.libraryItemName)) {
			
			var bitmapItem = xfl.document.media.get (instance.libraryItemName);
			bitmapData = Assets.getBitmapData (Path.directory (xfl.path) + "/bin/" + bitmapItem.bitmapDataHRef);
			
		}
		
		if (bitmapData != null) {
			
			bitmap = new Bitmap (bitmapData);
			bitmap.transform.matrix = instance.matrix;
			
		}
		
		return bitmap;
		
	}
	
	
	private function createSymbol (xfl:XFL, instance:DOMSymbolInstance):MovieClip {
		
		var movieClip = null;
		
		if (xfl.document.symbols.exists (instance.libraryItemName)) {
			
			var symbolItem = xfl.document.symbols.get (instance.libraryItemName);
			movieClip = new MovieClip (xfl, symbolItem.timeline);
			
		}

		if (movieClip != null) {
			
			movieClip.transform.matrix = instance.matrix;
			
		}
		
		return movieClip;
		
	}
	
	
}