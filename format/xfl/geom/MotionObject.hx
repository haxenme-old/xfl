package format.xfl.geom;


import haxe.xml.Fast;


class MotionObject {
	
	
	public var duration:Int;
	public var timeScale:Int;	
	
	
	public function new () {
		
	}
	
	
	public static function parse (xml:Fast):MotionObject {
		
		var motionObject = new MotionObject ();
		
		for (element in xml.elements) {
			
			switch (element.name) {
				
				case "AnimationCore":
					
					if (xml.has.TimeScale) motionObject.timeScale = Std.parseInt (xml.att.TimeScale);
					if (xml.has.duration) motionObject.duration = Std.parseInt (xml.att.duration);
					
					for (childElement in element.elements) {
						
						switch (childElement.name) {
							
							case "TimeMap":
								
								//<TimeMap strength="0" type="Quadratic"/>
							
							//case "metadata":
								
								//<metadata><names><name langID="en_US" value=""/></names><Settings orientToPath="0" xformPtXOffsetPct="0.5" xformPtYOffsetPct="0.5" xformPtZOffsetPixels="0"/></metadata>
							
							case "PropertyContainer":
							
										
						}
						
						
					}
				
			}
			
		}
		
		/*<PropertyContainer id="headContainer">
			<PropertyContainer id="Basic_Motion">
				<Property enabled="1" id="Motion_X" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,0" next="0,0" previous="0,0" roving="0" timevalue="0"/>
					<Keyframe anchor="0,148.95" next="0,148.95" previous="0,148.95" roving="0" timevalue="29000"/>
				</Property>
				<Property enabled="1" id="Motion_Y" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,0" next="0,0" previous="0,0" roving="0" timevalue="0"/>
					<Keyframe anchor="0,9" next="0,9" previous="0,9" roving="0" timevalue="29000"/>
				</Property>
				<Property enabled="1" id="Rotation_Z" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,0" next="0,0" previous="0,0" roving="0" timevalue="0"/>
					<Keyframe anchor="0,44.9991" next="0,44.9991" previous="0,44.9991" roving="0" timevalue="29000"/>
				</Property>
			</PropertyContainer>
			<PropertyContainer id="Transformation">
				<Property enabled="1" id="Skew_X" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,0" next="0,0" previous="0,0" roving="0" timevalue="0"/>
				</Property>
				<Property enabled="1" id="Skew_Y" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,0" next="0,0" previous="0,0" roving="0" timevalue="0"/>
				</Property>
				<Property enabled="1" id="Scale_X" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,100" next="0,100" previous="0,100" roving="0" timevalue="0"/>
				</Property>
				<Property enabled="1" id="Scale_Y" ignoreTimeMap="0" readonly="0" visible="1">
					<Keyframe anchor="0,100" next="0,100" previous="0,100" roving="0" timevalue="0"/>
				</Property>
			</PropertyContainer>
			<PropertyContainer id="Colors">
				<PropertyContainer id="Tint_ColorXform">
					<Property enabled="1" id="Tint_Color" ignoreTimeMap="0" readonly="0" visible="1">
						<Keyframe roving="0" timevalue="0" value="0xff0000ff"/>
						<Keyframe roving="0" timevalue="29000" value="0x00ffffff"/>
					</Property>
					<Property enabled="1" id="Tint_Amount" ignoreTimeMap="0" readonly="0" visible="1">
						<Keyframe anchor="0,0" next="0,0" previous="0,0" roving="0" timevalue="0"/>
						<Keyframe anchor="0,79" next="0,79" previous="0,79" roving="0" timevalue="29000"/>
					</Property>
				</PropertyContainer>
			</PropertyContainer>
			<PropertyContainer id="Filters"/>
		</PropertyContainer>
	</AnimationCore></motionObjectXML>*/
		
		return motionObject;
		
	}
	
	
}