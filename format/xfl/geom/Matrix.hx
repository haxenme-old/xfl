package format.xfl.geom;


import haxe.xml.Fast;


class Matrix extends flash.geom.Matrix {
	
	
	public function new (a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0) {
		
		super (a, b, c, d, tx, ty);
		
	}
	
	
	public static function parse (xml:Fast):Matrix {
		
		var matrix = new Matrix ();
		
		if (xml.has.a) matrix.a = Std.parseFloat (xml.att.a);
		if (xml.has.b) matrix.b = Std.parseFloat (xml.att.b);
		if (xml.has.c) matrix.c = Std.parseFloat (xml.att.c);
		if (xml.has.d) matrix.d = Std.parseFloat (xml.att.d);
		if (xml.has.tx) matrix.tx = Std.parseFloat (xml.att.tx);
		if (xml.has.ty) matrix.ty = Std.parseFloat (xml.att.ty);
		
		return matrix;
		
	}
	
	
}