package;

class PlayState extends FlxState
{
	public static var obj : PlayState;
	private var shouldReorderZ: Bool;
    
    private static var e: FlxSprite;
    
    override public function create():Void
    {
        FlxG.log.redirectTraces = true;
        
		obj = this;
		
        LevelMap.init("assets/data/levels/l0.tmx");

        Framework.init();
		Fog.init();
        Fog.obj.visible = false;
        FlxG.camera.bgColor = 0xff80c8f8;
		addChild(LevelMap.obj);
        
        var antek1 = new Antek(Antek.A3);
        
        antek2 = new Antek(Antek.A1);

        antek1.tileX = 10;
        antek1.tileY = 29;
        antek2.tileX = 4;
        antek2.tileY = 29;
		Camera.updatePosition(5.htile(), 29.vtile());

    }
    
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
        Framework.update();
		Fog.update();
        Objects.update(elapsed);

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
        PlayState.obj.add(sprite);
        obj.members.sort(zOrderComparer);
    }
    
    private static function zOrderComparer(a: FlxBasic, b: FlxBasic) : Int
    {
        return a.ID - b.ID;
    }
}