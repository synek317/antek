package;
import flixel.FlxBasic;
import objects.Ladder;

class PlayState extends FlxState
{
	private static var obj : PlayState;
	private var shouldReorderZ: Bool;
    
    private static var e: FlxSprite;
    
    override public function create():Void
    {
        FlxG.log.redirectTraces = true;
        
		obj = this;

        Engine.init("assets/data/levels/l0.tmx");
        Fog.obj.visible = false;
        FlxG.camera.bgColor = 0xff80c8f8;
        
        var antek1 = new Antek(Antek.A3);
        
        antek2 = new Antek(Antek.A1);

        antek1.tileX = 10;
        antek1.tileY = 29;
        antek2.tileX = 4;
        antek2.tileY = 29;
		Camera.updatePosition(5.htile(), 29.vtile());
        
        
        ladder = new Ladder();
        ladder.init(11);
        ladder.tileX = 12;
        ladder.tileY = 30;
        ladder.createImmediately();
        
        antek2.moveByPath(AStar.obj.findPath(17, 116, 54, 80));
    }
    
    private function cmp(a: Int, b: Int) return a - b;
    
    private var fps1: FlxText;
    private var act: BuildLadder;
    private var act2: BuildLadder;
    private var ladder: Ladder;
    private var ladder2: Ladder;
    private var antek: Antek;
    private var antek2: Antek;
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        Engine.update();
		Fog.update();
        Objects.update(elapsed);

        if (shouldReorderZ)
        {
            shouldReorderZ = false;
            obj.members.sort(zOrderComparer);
        }
		if (FlxG.keys.justPressed.SPACE)
		{
			Game.state = GameStates.Idle;
		}
		if (FlxG.keys.justPressed.F)
		{
			Fog.obj.visible = !Fog.obj.visible;
		}
        if (FlxG.keys.justPressed.Q)
        {
            antek2.moveToTileX(random_int(1, 20));
        }
        if (FlxG.keys.justPressed.W)
        {
            antek2.idle();
        }
    }
    
    public static function scheduleZReorder() { obj.shouldReorderZ = true; }
    
    public static function addChildZ(sprite: FlxBasic, zOrder: Int)
    {
        sprite.ID = zOrder;
        addChild(sprite);
    }
    
    public static function addChild(sprite: FlxBasic)
    {
        if (sprite == null)    return;
        if (sprite.ID == null) sprite.ID = 0;
        
        PlayState.obj.add(sprite);
        PlayState.scheduleZReorder();
    }
    
    public static function removeChild(sprite: FlxBasic)
    {
        PlayState.obj.members.remove(sprite);
        PlayState.obj.remove(sprite);
    }
    
    private static function zOrderComparer(a: FlxBasic, b: FlxBasic) : Int
    {
        return a.ID - b.ID;
    }
}