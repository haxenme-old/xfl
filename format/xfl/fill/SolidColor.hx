package format.xfl.fill;


import haxe.xml.Fast;


class SolidColor {
	
	
	public var alpha:Float;
	public var color:Int;
	

	public function new () {
		
		alpha = 1;
		
	}
	
	
	public static function parse (xml:Fast):SolidColor {
		
		var solidColor = new SolidColor ();
		
		if (xml.has.color) solidColor.color = Std.parseInt ("0x" + xml.att.color.substr (1));
		if (xml.has.alpha) solidColor.alpha = Std.parseFloat (xml.att.alpha);
		
		return solidColor;
		
	}
	
	
}