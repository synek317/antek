package objects;
import flash.geom.Point;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.animation.FlxAnimation;
import flixel.util.FlxTimer;

/**
 * ...
 * @author ...
 */
class Antek extends FlxExtendedSprite
{
    public static inline var A1 = "c01";
    public static inline var A2 = "c02";
    public static inline var A3 = "c03";
    public static inline var A4 = "c04";
    
    private static inline var IDLE   = 1;
    private static inline var WALK   = 2;
    private static inline var ATTACK = 3;
    private static inline var BUILD  = 4;
    private static inline var CLIMB  = 5;
    private static inline var GATHER = 6;
    
    private static inline var IdleAnimFps    = 20;
    private static inline var WalkAnimSpeed = 19.0 / 40.0; //frames per pixels
    
    private var HorizontalSpeed        = 60;
    private var VerticalSpeed          = 40;
    private var BuildsPerSecond        = 2;
    
    private var destinations     : List<Point>;
    private var scheduledActions : List<Void->Void>;
    private var state            : Int;
    private var onBuild          : Void -> Void;
    private var buildTime        : Float;
    private var idleAnim         : FlxAnimation;
    private var buildAnim        : FlxAnimation;
    private var walkAnim         : FlxAnimation;
    private var climbAnim        : FlxAnimation;
    
	public function new(type: String, x: Float, y: Float)
	{
		super(x, y);
		
        clickable        = true;
        
        destinations     = new List<Point>();
        scheduledActions = new List<Void->Void>();
        
        frames    = Textures.anteks;
        idleAnim  = addAnim(type, "idle");
        buildAnim = addAnim(type, "build");
        walkAnim  = addAnim(type, "walk");
        climbAnim = addAnim(type, "climb");
        
        recalculateAnimationsSpeed();
        idle();
    }
    
    private function addAnim(type: String, name: String) : FlxAnimation
    {
        animation.addByPrefix(name, type + "/" + name + "/");
        return animation.getByName(name);
    }
    
    public function recalculateAnimationsSpeed()
    {
        walkAnim.frameRate = Std.int(HorizontalSpeed * WalkAnimSpeed);
        buildAnim.frameRate = Std.int(buildAnim.numFrames * BuildsPerSecond);
    }
    
    override public function update(elapsed:Float):Void 
    {
        super.update(elapsed);
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
                        }
                    }
                }
        }
    }
    
    public function then(action: Void -> Void) : Antek
    {
        scheduledActions.add(action);
        return this;
    }
    
    public function teleportTo(?newX: Float, ?newY: Float) : Antek
    {
        if (newX != null) x = newX;
        if (newY != null) y = newY;
        return this;
    }
    
    public function idle() : Antek
    {
        state = IDLE;
        animation.play("idle");
        
        return this;
    }
    
    public function moveTo(newX: Int) : Antek
    {
        state = WALK;
        flipX = newX < x;
        
        destinations.clear();
        destinations.push(new Point(newX, y));
        animation.play("walk");
        
        return this;
    }
    
    public function build(?onBuild: Void -> Void) : Antek
    {
        this.onBuild = onBuild;
        state        = BUILD;
        buildTime    = (buildAnim.numFrames / 2 - 2) / buildAnim.frameRate;
        
        animation.play("build");
        return this;
    }
    
    public function climb() : Antek
    {
        //if (fallAt == null) fallAt = y;
        destinations.add(new Point(x, y - 100));
        state = WALK;
        
        animation.play("climb");
        return this;
    }
    
    public function turnLeft()  { flipX = true; }
    public function turnRight() { flipX = false; }
    
    public function at(p: Point) : Bool
    {
        return p.x == x && p.y == y;
    }
    
    private function finishState()
    {
        var action = scheduledActions.pop();
        
        if (action != null) action();
        else                idle();
    }
    
    private function stepTowards(p: Point, elapsed: Float)
    {
        if (x < p.x)     x = Math.min(x + HorizontalSpeed * elapsed, p.x);
        else if (x > p.x) x = Math.max(x - HorizontalSpeed * elapsed, p.x);
        
        if (y < p.y)     y = Math.min(y + VerticalSpeed * elapsed, p.y);
        else if(y > p.y) y = Math.max(y - VerticalSpeed * elapsed, p.y);
    }
    
    private inline function oneBuildHitTime() return buildAnim.numFrames / buildAnim.frameRate;
}