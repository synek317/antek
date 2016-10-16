package framework;

class Zoom
{
	private static inline var ZOOM_STEP     = 0.3;
	private static inline var ZOOM_DURATION = 0.2; //seconds
	
	public static var cameraShiftX : Float = 0;
	public static var cameraShiftY : Float = 0;
	
    public  static var zoomFactor    : Float = 1;
    private static var minZoomFactor : Float;
    private static var maxZoomFactor : Float;

    private static var destinationZoomFactor: Float;
    private static var zoomTween: FlxTween;
    private static var destinationCenter = new FlxPoint();

    public static function init()
    {
        var minXZoomFactory = FlxG.width  / LevelMap.obj.width;
        var minYZoomFactory = FlxG.height / LevelMap.obj.height;
        var maxXZoomFactory = 2;
        var maxYZoomFactory = 2;
		
        minZoomFactor = Math.max(minXZoomFactory, minYZoomFactory);
		maxZoomFactor = Math.max(maxXZoomFactory, maxYZoomFactory);
		
		zoomTo(1);
    }

    public static function update():Void
    {
        if(FlxG.keys.justPressed.PAGEUP || FlxG.mouse.wheel > 0)
        {
            zoomTo(zoomFactor + ZOOM_STEP);
        }
        else if(FlxG.keys.justPressed.PAGEDOWN || FlxG.mouse.wheel < 0)
        {
            zoomTo(zoomFactor - ZOOM_STEP);
        }
        else if(FlxG.keys.justPressed.ZERO)
        {
            zoomTo(1);
        }
    }

    private static var initialCenter = new FlxPoint();
    private static var initialZoom: Float;

    public static function zoomTo(newZoomFactor: Float): Void
    {
        if (zoomTween != null && !zoomTween.finished) return;
		
        destinationZoomFactor = FlxMath.bound(newZoomFactor, minZoomFactor, maxZoomFactor);

        if (destinationZoomFactor == zoomFactor) return;
        
        initialZoom         = zoomFactor;
        initialCenter.x     = Camera.obj.x;
        initialCenter.y     = Camera.obj.y;
        destinationCenter.x = Camera.boundX(Mouse.x, destinationZoomFactor);
        destinationCenter.y = Camera.boundY(Mouse.y, destinationZoomFactor);

        zoomTween = FlxTween.num(
          0,
          1,
          ZOOM_DURATION,
          null,
          updateZoom
        );
    }

    private static function updateZoom(progressPercentage: Float): Void
    {
        zoomFactor = initialZoom + (destinationZoomFactor - initialZoom) * progressPercentage;

        var newCameraWidth  = Math.max(FlxG.width, FlxG.width / zoomFactor);
        var newCameraHeight = Math.max(FlxG.height, FlxG.height / zoomFactor);
        var diffWidth       = FlxG.width  - newCameraWidth;
        var diffHeight      = FlxG.height - newCameraHeight;
    
        FlxG.camera.setSize(int(newCameraWidth), int(newCameraHeight));
        FlxG.camera.setScale(zoomFactor, zoomFactor);
        FlxG.camera.setPosition(diffWidth/2, diffHeight/2);
        
		cameraShiftX = -0.5 * (zoomFactor * FlxG.camera.width  - FlxG.camera.width);
		cameraShiftY = -0.5 * (zoomFactor * FlxG.camera.height - FlxG.camera.height);
		
        Camera.updatePosition(
            initialCenter.x + (destinationCenter.x - initialCenter.x) * progressPercentage,
            initialCenter.y + (destinationCenter.y - initialCenter.y) * progressPercentage
        );
        LevelMap.obj.updateBuffers();
    }
}