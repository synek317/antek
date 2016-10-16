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
        FlxG.camera.bgColor = 0xffCCE6E6;
		addChild(LevelMap.obj);
        
        var antek1 = new Antek(Antek.A3);
        
        antek2 = new Antek(Antek.A3);

        antek1.tileX = 10;
        antek1.tileY = 29;
        antek2.tileX = 4;
        antek2.tileY = 29;


//        sprFilter.applyToSprite(antek1.subSprite.sprite, true, true);
        //sprFilter.applyToSprite(antek2.subSprite.sprite, true, true);

        //flixel.input.mouse.FlxMouseEventManager.add(subSprite.sprite, null, null, function(_) {
        //    sprFilter.addFilter(filter);
        //}, function(_) {sprFilter.removeFilter(filter); }, false, true, true);

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
		Camera.updatePosition(5.htile(), 29.vtile());

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
        if  (FlxG.keys.justPressed.E)
        {
            antek2.glowFilter.attach();
        }
        if  (FlxG.keys.justPressed.R)
        {
            antek2.glowFilter.dettach();
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