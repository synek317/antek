package engine;

class Fog
{
	private static var viewOwners:     List<FlxSprite>;
	private static var viewStamp:      FlxSprite;
	private static var pos:            FlxPoint;
	private static var fogRect:        Rectangle;
	private static var colorTransform: ColorTransform;
	private static var cam:            FlxCamera;
	private static var oldGraphic: 	   FlxGraphic;
	private static var newFog:         FlxSprite;
	
	public  static var obj:            FlxSprite = new FlxSprite();
		
	public static function init()
	{
		/*pos              = new FlxPoint();
		obj              = makeFog();
		fogRect          = new Rectangle(0, 0, obj.width, obj.height);
		colorTransform   = new ColorTransform(0, 0, 0, -1, 0, 0, 0, 255);
		viewOwners       = new List<FlxSprite>();
		viewStamp        = Textures.others.createSprite("inverted_fog");
        
		PlayState.addChild(obj);
		
		cam = new FlxCamera(0, 0, Std.int(obj.width), Std.int(obj.height), 1);
		cam.bgColor = 0x00000000;
		obj.cameras = [cam];
		FlxG.cameras.add(cam);*/
	}
	
	public static function register(viewOwner: FlxSprite)
	{
		//viewOwners.add(viewOwner);
	}
	
	public static function update()
	{
		/*newFog = makeFog();
		
		viewStamp.scale.x =  Zoom.zoomFactor;
		viewStamp.scale.y =  Zoom.zoomFactor;
		
		for (viewOwner in viewOwners) updateViewPosition(newFog, viewOwner);
		
		newFog.pixels.colorTransform(fogRect, colorTransform);
		
		oldGraphic = obj.graphic;
		obj.pixels = newFog.pixels;
		FlxG.bitmap.remove(oldGraphic);*/
	}
	
	private static function updateViewPosition(newFog: FlxSprite, viewOwner: FlxSprite)
	{
		viewOwner.getPosition(pos);
		
		//pos.x * Z - scroll.x * Z - (camera.width - camera.width / Z) * 0.5 * Z + owner.width * Z * 0.5 - stamp.width * 0.5
		newFog.stamp(
			viewStamp,
			Std.int(
				Zoom.zoomFactor * (
					pos.x
					- FlxG.camera.scroll.x
					+ 0.5 * viewOwner.width
				)
				- 0.5 * viewStamp.width
				+ FlxG.camera.x
				+ Zoom.cameraShiftX
			),
			Std.int(
				Zoom.zoomFactor * (
					pos.y
					- FlxG.camera.scroll.y
					+ 0.5 * viewOwner.height
				)
				- 0.5 * viewStamp.height
				+ FlxG.camera.y
				+ Zoom.cameraShiftY
			)
		);
	}
	
	private static function makeFog(): FlxSprite
	{
		var f = new FlxSprite(0, 0);
		
		f.makeGraphic(FlxG.width, FlxG.height, 0x01000000, true); //should be 0x00000000, but there is some kind of bug in openfl/flixel
		f.scrollFactor.x = 0;
		f.scrollFactor.y = 0;
		
		return f;
	}
}