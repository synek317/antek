package;
import actions.BuildLadder;
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
import objects.Antek;
import objects.Ladder;
import openfl.display.FPS;
using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	public static var obj : PlayState;
	private var shouldReorderZ: Bool;
    
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
		//addChildZ(xxx, 15);
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
		//Fog.register(xxxx);
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
		
        
        /*ladder = Level.addObject(function(s: Ladder) {
            s.init(40 * 10, 40 * 15, 8);
            s.createImmediately();
        });*/
        ladder = new Ladder();
        ladder.init(8);
        ladder.tileX = 8;
        ladder.tileY = 15;
        
        var loop = new FlxTimer();
        //loop.start(0.5, function(_) { loop.time = 1; ladder.step(); } , 100);
        
		//FlxG.debugger.visible = true;
        antek = new Antek(Antek.A1);// , 450, 472);
        antek.tileX = 12;
        antek.tileY = 14;
        act = new BuildLadder(antek, ladder);
        act.action();
        
        //antek.climb();
        
        fps1 = new FlxText(10, 40);
        //fps1.color = 0xffffffff;
        addChild(fps1);
        //Fog.register(antek);
        //test();
    }

    private function test()
    {
        antek
        .teleportTo(650, 472)
        .moveTo(385);
    }
    
    private var fps1: FlxText;
    private var act: BuildLadder;
    private var ladder: Ladder;
    private var antek: Antek;
    
    override public function update(elapsed:Float):Void
    {
        fps1.text = "FPS: " + (1 / elapsed) + " (" + elapsed + ")";
        super.update(elapsed);
		ZoomController.update();
		FreeCameraController.update();
		Fog.update();
		
        if (shouldReorderZ)
        {
            shouldReorderZ = false;
            obj.members.sort(zOrderComparer);
        }
		if (FlxG.keys.justPressed.SPACE)
		{
			ladder.step();
		}
		if (FlxG.keys.justPressed.F)
		{
			Fog.obj.visible = !Fog.obj.visible;
		}
        if (FlxG.keys.justPressed.T)
        {
            test();
        }
		MouseHandler.update();
        
        antek.update(elapsed);
    }
    
    public static function scheduleZReorder() { obj.shouldReorderZ = true; }
    
    public static function addChildZ(sprite: FlxBasic, zOrder: Int)
    {
        sprite.ID = zOrder;
        addChild(sprite);
    }
    
    public static function addChild(sprite: FlxBasic)
    {
        PlayState.obj.add(sprite);
        obj.members.sort(zOrderComparer);
    }
    
    private static function zOrderComparer(a: FlxBasic, b: FlxBasic) : Int
    {
        return a.ID - b.ID;
    }
}