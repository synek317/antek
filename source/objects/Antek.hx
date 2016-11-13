package objects;

class Antek extends ASprite implements IUpdateable
{
    public static inline var A1     = "c01";
    public static inline var A2     = "c02";
    public static inline var A3     = "c03";
    public static inline var A4     = "c04";
    
    public static inline var IDLE   = 1;
    public static inline var WALK   = 2;
    public static inline var ATTACK = 3;
    public static inline var BUILD  = 4;
    public static inline var CLIMB  = 5;
    public static inline var GATHER = 6;
    
    public var HorizontalSpeed      = 50;
    public var VerticalSpeed        = 40;
    public var BuildsPerSecond      = 3;
    
    public var state                : Int;
    public var scheduledActions     = new List<Void->Void>();
    public var busy                 = false;
    public var isMouseOver          = false;

    public var destinations = new List<Point>();
    public var type: String;
    
	public function new(type: String)
	{
        super();
        this.position.tileShiftX = Consts.HalfTileWidth;
        
        this.type = type;
        
        initGraphics(type);
        initInput();
        idle();

        Objects.register(this);
        subSprite.sprite.graphic.persist = true;
        Fog.register(subSprite.sprite);
    }
    
    public function update(elapsed:Float):Void 
    {
        updateState(elapsed);
    }
    
    
    public var onBuild   : Void -> Void;
    public var buildTime : Float;

    public static inline var IdleAnimFps   = 20;
    public static inline var WalkAnimSpeed = 19.0 / 40.0; //frames per pixels
    
    public var subSprite       : SubSprite; 
    public var starSprite      : SubSprite;
    
    public var idleAnim        : FlxAnimation;
    public var buildAnim       : FlxAnimation;
    public var walkAnim        : FlxAnimation;
    public var climbAnim       : FlxAnimation;
    
    public var faceLeftShiftX  : Int = 0;
    public var faceLeftShiftY  : Int = 0;
    public var faceRightShiftX : Int = 0;
    public var faceRightShiftY : Int = 0;


    public var orgFrames: FlxFramesCollection;
    
    public var _selected = false;
    public var selected(get, set): Bool;
    public function get_selected() return _selected;
    public function set_selected(val) return this.setSelected(val);
}