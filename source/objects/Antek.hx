package objects;

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
    public var type: String;
    
	public function new(type: String)
	{
        this.type = type;
        
        initGraphics(type);
        initInput();
        idle();

        Objects.register(this);
        subSprite.sprite.graphic.persist = true;
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
    public var starSprite = new SubSprite(Textures.others.createSprite("star"), -10, -115, 1);
    
    public var idleAnim   : FlxAnimation;
    public var buildAnim  : FlxAnimation;
    public var walkAnim   : FlxAnimation;
    public var climbAnim  : FlxAnimation;
    
    public var orgFrames: FlxFramesCollection;
    
    public var _selected = false;
    public var selected(get, set): Bool;
    public function get_selected() return _selected;
    public function set_selected(val) return this.setSelected(val);
}