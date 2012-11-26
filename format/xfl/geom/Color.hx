package format.xfl.geom;


import haxe.xml.Fast;
import nme.geom.ColorTransform;


class Color extends ColorTransform {
	
	
	public function new () {
		
		super ();
		
	}
	
	
	public static function parse (xml:Fast):Color {
		
		var color = new Color ();
		
		if (xml.has.alphaMultiplier) color.alphaMultiplier = Std.parseFloat (xml.att.alphaMultiplier);
		if (xml.has.alphaOffset) color.alphaOffset = Std.parseFloat (xml.att.alphaOffset);
		if (xml.has.blueMultiplier) color.blueMultiplier = Std.parseFloat (xml.att.blueMultiplier);
		if (xml.has.blueOffset) color.blueOffset = Std.parseFloat (xml.att.blueOffset);
		if (xml.has.greenMultiplier) color.greenMultiplier = Std.parseFloat (xml.att.greenMultiplier);
		if (xml.has.greenOffset) color.greenOffset = Std.parseFloat (xml.att.greenOffset);
		if (xml.has.redMultiplier) color.redMultiplier = Std.parseFloat (xml.att.redMultiplier);
		if (xml.has.redOffset) color.redOffset = Std.parseFloat (xml.att.redOffset);
		
		return color;
		
	}
	
	
}