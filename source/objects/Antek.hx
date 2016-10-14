package objects;
import flash.geom.Point;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import flixel.animation.FlxAnimation;
import flixel.util.FlxTimer;
import framework.ASprite;
import framework.SubSprite;

/**
 * ...
 * @author ...
 */
class Antek extends ASprite
{
    //{ Antek Types
    public static inline var A1 = "c01";
    public static inline var A2 = "c02";
    public static inline var A3 = "c03";
    public static inline var A4 = "c04";
    //}
    
    //{ Properties
    private var HorizontalSpeed        = 60;
    private var VerticalSpeed          = 40;
    private var BuildsPerSecond        = 2;
    //}
    
	public function new(type: String)
	{
        subSprite = { sprite: new FlxSprite(), shiftX: 0, shiftY: 0, shiftZ: 0 };
        
        destinations     = new List<Point>();
        scheduledActions = new List<Void->Void>();
        
        subSprite.sprite.frames = Textures.anteks;
        idleAnim  = addAnim(type, "idle");
        buildAnim = addAnim(type, "build");
        walkAnim  = addAnim(type, "walk");
        climbAnim = addAnim(type, "climb");
        
        recalculateAnimationsSpeed();
        idle();
        
        addSubSprite(subSprite);
    }
    
    //{ States
    
    private static inline var IDLE   = 1;
    private static inline var WALK   = 2;
    private static inline var ATTACK = 3;
    private static inline var BUILD  = 4;
    private static inline var CLIMB  = 5;
    private static inline var GATHER = 6;
    
    private var state            : Int;
    private var scheduledActions : List<Void->Void>;
    
    public function update(elapsed:Float):Void 
    {
        switch(state)
        {
            case WALK:
                var destination = destinations.first(); 
                
                if (destination == null)  finishState();
                else if (at(destination)) destinations.pop();
                else                      stepTowards(destination, elapsed);
                
            case BUILD:
                if (onBuild != null)
                {
                    buildTime += elapsed;
                    
                    var hits = Math.floor(buildTime * BuildsPerSecond);
                    if (hits > 0)
                    {
                        buildTime -= hits / BuildsPerSecond;
                        for (i in 0...hits)
                        {
                            onBuild();
                            FlxG.sound.play(AssetPaths.build__wav, 0.01);
                        }
                    }
                }
        }
    }
    
    private function finishState()
    {
        var action = scheduledActions.pop();
        
        if (action != null) action();
        else                idle();
    }
    
    public function then(action: Void -> Void) : Antek
    {
        scheduledActions.add(action);
        return this;
    }
    //}
    
    //{ States: Idle
    public function idle() : Antek
    {
        state = IDLE;
        subSprite.sprite.animation.play("idle");
        subSprite.shiftX = -30;
        subSprite.shiftY = -87;
        
        return this;
    }
    //}
    
    //{ States: Walk 
    private var destinations : List<Point>;
    
    public function moveToX(newX: Float) : Antek
    {
        state = WALK;
        subSprite.sprite.flipX = newX < x;
        
        destinations.clear();
        destinations.push(new Point(newX, y));
        subSprite.sprite.animation.play("walk");
        subSprite.shiftX = -30;
        subSprite.shiftY = -87;
        
        return this;
    }
    
    public function moveToTileX(newX: Int) : Antek
    {
        return moveToX(LevelMap.TileWidth * newX + LevelMap.HalfTileWidth);
    }
    
    public function teleportTo(?newX: Float, ?newY: Float) : Antek
    {
        if (newX != null) x = newX;
        if (newY != null) y = newY;
        return this;
    }
    
    private function stepTowards(p: Point, elapsed: Float)
    {
        if (x < p.x)     x = Math.min(x + HorizontalSpeed * elapsed, p.x);
        else if (x > p.x) x = Math.max(x - HorizontalSpeed * elapsed, p.x);
        
        if (y < p.y)     y = Math.min(y + VerticalSpeed * elapsed, p.y);
        else if(y > p.y) y = Math.max(y - VerticalSpeed * elapsed, p.y);
    }
    //}
    
    //{ States: Build
    private var onBuild   : Void -> Void;
    private var buildTime : Float;
    
    public function build(?onBuild: Void -> Void) : Antek
    {
        this.onBuild = onBuild;
        state        = BUILD;
        buildTime    = (buildAnim.numFrames / 2 - 2) / buildAnim.frameRate;
        
        subSprite.sprite.animation.play("build");
        subSprite.shiftX = -30;
        subSprite.shiftY = -87;
        
        return this;
    }
    //}
    
    //{ States: Climb
    public function climb(newY: Float) : Antek
    {
        destinations.add(new Point(x, newY));
        state = WALK;
        
        subSprite.sprite.animation.play("climb");
        subSprite.shiftX = -30;
        subSprite.shiftY = -87;
        
        return this;
    }
    
    public inline function climbBy(deltaY: Float) : Antek { return climb(y + deltaY); }
    
    //}
    
    //{ Others
    public function turnLeft()  { subSprite.sprite.flipX = true;  return this; }
    public function turnRight() { subSprite.sprite.flipX = false; return this; }
    
    public function at(p: Point) : Bool
    {
        return p.x == x && p.y == y;
    }
    //}
    
    //{ Graphics
    private static inline var IdleAnimFps    = 20;
    private static inline var WalkAnimSpeed = 19.0 / 40.0; //frames per pixels
    
    private var subSprite : SubSprite;
    private var idleAnim  : FlxAnimation;
    private var buildAnim : FlxAnimation;
    private var walkAnim  : FlxAnimation;
    private var climbAnim : FlxAnimation;
    
    private function addAnim(type: String, name: String) : FlxAnimation
    {
        subSprite.sprite.animation.addByPrefix(name, type + "/" + name + "/");
        return subSprite.sprite.animation.getByName(name);
    }
    
    public function recalculateAnimationsSpeed()
    {
        walkAnim.frameRate = Std.int(HorizontalSpeed * WalkAnimSpeed);
        buildAnim.frameRate = Std.int(buildAnim.numFrames * BuildsPerSecond);
    }
    //}
}