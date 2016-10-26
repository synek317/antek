package objects;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import framework.SubSprite;

class Antek extends ASprite implements IUpdateable
{
    public static inline var A1 = "c01";
    public static inline var A2 = "c02";
    public static inline var A3 = "c03";
    public static inline var A4 = "c04";
    
    public static inline var IDLE   = 1;
    public static inline var WALK   = 2;
    public static inline var ATTACK = 3;
    public static inline var BUILD  = 4;
    public static inline var CLIMB  = 5;
    public static inline var GATHER = 6;
    
    public var HorizontalSpeed = 60;
    public var VerticalSpeed   = 40;
    public var BuildsPerSecond = 2;
    
    public var state            : Int;
    public var scheduledActions = new List<Void->Void>();
    
    public var destinations = new List<Point>();

	public function new(type: String)
	{
        initGraphics(type);
        initInput();
        idle();

        Objects.register(this);
    }
    
    public function update(elapsed:Float):Void 
    {
        updateState(elapsed);
    }
    
    
    public var onBuild   : Void -> Void;
    public var buildTime : Float;

    public static inline var IdleAnimFps    = 20;
    public static inline var WalkAnimSpeed = 19.0 / 40.0; //frames per pixels
    
    public var subSprite  = new SubSprite(new FlxSprite(), 0, 0, 0);

    public var idleAnim   : FlxAnimation;
    public var buildAnim  : FlxAnimation;
    public var walkAnim   : FlxAnimation;
    public var climbAnim  : FlxAnimation;
}