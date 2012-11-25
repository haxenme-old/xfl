package format.xfl.edge;


import haxe.xml.Fast;


class Edge {
	
	
	public var cubics:String;
	public var edges:String;
	public var fillStyle0:Int;
	public var fillStyle1:Int;
	public var strokeStyle:Int;
	

	public function new () {
		
		
		
	}
	
	
	public static function parse (xml:Fast):Edge {
		
		var edge = new Edge ();
		
		if (xml.has.fillStyle0) edge.fillStyle0 = Std.parseInt (xml.att.fillStyle0);
		if (xml.has.fillStyle1) edge.fillStyle1 = Std.parseInt (xml.att.fillStyle1);
		if (xml.has.strokeStyle) edge.strokeStyle = Std.parseInt (xml.att.strokeStyle);
		if (xml.has.cubics) edge.cubics = xml.att.cubics;
		if (xml.has.edges) edge.edges = xml.att.edges;
		
		return edge;
		
	}
	
	
}