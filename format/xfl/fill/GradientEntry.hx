package format.xfl.fill;


import haxe.xml.Fast;


class GradientEntry {
	
	
	public var color:Int;
	public var ratio:Float;
	

	public function new () {
		
		
		
	}
	
	
	public static function parse (xml:Fast):GradientEntry {
		
		var gradientEntry = new GradientEntry ();
		
		gradientEntry.color = Std.parseInt ("0x" + xml.att.color.substr (1));
		gradientEntry.ratio = Std.parseFloat (xml.att.ratio);
		
		return gradientEntry;
		
	}
	
	
}