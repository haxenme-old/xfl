package format.xfl.geom;


import haxe.xml.Fast;


class Point extends flash.geom.Point {
	
	
	public function new (x:Float = 0, y:Float = 0) {
		
		super (x, y);
		
	}
	
	
	public static function parse (xml:Fast):Point {
		
		var point = new Point ();
		
		point.x = Std.parseFloat (xml.att.x);
		point.y = Std.parseFloat (xml.att.y);
		
		return point;
		
	}
	
	
}