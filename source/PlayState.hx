package;
import flash.display.BitmapDataChannel;
import flash.display.BlendMode;
import flash.geom.*;
import flixel.FlxBasic;
import flixel.addons.util.FlxAsyncLoop;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.addons.editors.tiled.TiledImageTile;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxSort;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import haxe.io.Path;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.display.FlxZoomCamera;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;
import objects.Ladder;
using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	public static var obj : PlayState;
	
    private static var e: FlxSprite;
    
    override public function create():Void
    {
		obj = this;
		
        LevelMap.init("assets/data/levels/l0.tmx");
		
        ZoomController.init();
		FreeCameraController.init();
		Fog.init();
		
		FlxG.camera.follow(FreeCameraController.obj, FlxCameraFollowStyle.NO_DEAD_ZONE, 0);
		FlxG.camera.pixelPerfectRender = true;
        FlxG.camera.bgColor = 0xffCCE6E6;
		
        
        
        var x = new FlxSprite(50, 76);

        x.frames = Textures.anteks;
        x.animation.addByPrefix("walk", "c02/walk/", 19);
        x.animation.play("walk");

		var xx = new FlxSprite(300, 72);

        xx.frames = Textures.anteks;
        xx.animation.addByPrefix("walk", "c01/idle/", 18);
        xx.animation.play("walk");
		
		
		var xxx = new FlxSprite(350, 472);

        xxx.frames = Textures.anteks;
        xxx.animation.addByPrefix("walk", "c03/build/", 19);
        xxx.animation.play("walk");
		
        addChild(LevelMap.obj);
		//add(xx);
        //add(x);
		addChildZ(xxx, 15);
		x.cameras = [FlxG.camera];
		xx.cameras = [FlxG.camera];
		xxx.cameras = [FlxG.camera];
		
		//Fog.register(x);
		//Fog.register(xx);
		Fog.register(xxx);
		
		FlxTween.tween(x, {x: 730}, 15, { type: FlxTween.PINGPONG, onComplete: function(_) { x.flipX = !x.flipX; } } );
		
		var xxxx = new FlxSprite(780, 1076);
		xxxx.frames = Textures.anteks;
		xxxx.flipX = true;
		xxxx.animation.addByPrefix("walk", "c04/walk/", 19);
		xxxx.animation.play("walk");
		addChild(xxxx);
		Fog.register(xxxx);
		FlxTween.tween(xxxx, {x: 10}, 15, { type: FlxTween.PINGPONG, onComplete: function(_) { xxxx.flipX = !xxxx.flipX; } } );
		
        e = new FlxSprite(50, 24);
		
        e.frames = Textures.enemies;
        e.animation.addByPrefix("walk", "e01/walk/", 15);
        e.animation.play("walk");
		e.cameras = [FlxG.camera];
		Fog.register(e);
		addChild(e);
		FlxTween.tween(e, {x: 700}, 22, { type: FlxTween.PINGPONG, onComplete: function(_) { e.flipX = !e.flipX; } } );
		Fog.obj.visible = false;
		
        ladder = new Ladder();
        ladder.init(40 * 10, 40 * 15, 8);
        
        var loop = new FlxTimer();
        loop.start(0.5, function(_) { loop.time = 1; ladder.step(); } , 100);
        
		//FlxG.debugger.visible = true;
    }

    private var ladder: Ladder;
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
		ZoomController.update();
		FreeCameraController.update();
		Fog.update();
		
		if (FlxG.keys.justPressed.SPACE)
		{
			ladder.step();
		}
		if (FlxG.keys.justPressed.F)
		{
			Fog.obj.visible = !Fog.obj.visible;
		}
		MouseHandler.update();
    }
    
    public static function addChildZ(sprite: FlxBasic, zOrder: Int)
    {
        sprite.ID = zOrder;
        addChild(sprite);
    }
    
    public static function addChild(sprite: FlxBasic)
    {
        PlayState.obj.add(sprite);
        obj.members.sort(function(a, b) return a.ID - b.ID);
    }
}