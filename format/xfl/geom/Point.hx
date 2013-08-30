package format.xfl.geom;


import haxe.xml.Fast;



#if nme 
class Point extends flash.geom.Point {
#else
class Point {
	public var x:Float;
	public var y:Float;
#end	
	
	
	public function new (x:Float = 0, y:Float = 0) {
		
		#if nme
		super (x, y);
		#else
		this.x = x;
		this.y = y;
		#end
		
	}
	
	
	public static function parse (xml:Fast):Point {
		
		var point = new Point ();
		
		point.x = Std.parseFloat (xml.att.x);
		point.y = Std.parseFloat (xml.att.y);
		
		return point;
		
	}
	
	
}