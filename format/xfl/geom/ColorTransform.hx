package format.xfl.geom;

class ColorTransform 
{

	public var alphaMultiplier : Float;
	public var alphaOffset : Float;
	public var blueMultiplier : Float;
	public var blueOffset : Float;
	public var color : Int;
	public var greenMultiplier : Float;
	public var greenOffset : Float;
	public var redMultiplier : Float;
	public var redOffset : Float;



	function new(redMultiplier:Float = 1, greenMultiplier:Float = 1, blueMultiplier:Float = 1, alphaMultiplier:Float = 1, redOffset:Float = 0, greenOffset:Float = 0, blueOffset:Float = 0, alphaOffset:Float = 0) : Void {

		this.redMultiplier = redMultiplier;
		this.greenMultiplier = greenMultiplier;
		this.blueMultiplier = blueMultiplier;
		this.alphaMultiplier = alphaMultiplier;
		this.redOffset = redOffset;
		this.greenOffset = greenOffset;
		this.blueOffset = blueOffset;
		this.alphaOffset = alphaOffset;
	}

}

