package objects.decorations;

class DecoAnim implements IUpdateable
{
    private var deco: DecoInfo;
    private var sprite: FlxSprite;
    
    public function new(deco: DecoInfo, obj: TiledObject)
    {
        this.sprite   = new FlxSprite();
        this.deco     = deco;
        
        this.sprite.frames = Textures.decorations;
        this.sprite.animation.addByPrefix("anim", deco.name + "/", deco.frameRate, false, obj.flippedHorizontally, obj.flippedVertically);
        this.sprite.x = obj.x;
        this.sprite.y = obj.y - obj.height;
        this.sprite.ID = deco.z;
        //this.sprite.animation.finished = true;
        
        setDefaultFrame();
    }
    
    public static function create(deco: DecoInfo, obj: TiledObject)
    {
        var deco = new DecoAnim(deco, obj);
        
        PlayState.addChild(deco.sprite);
        Objects.register(deco);
    }
    
    public function update(elapsed: Float)
    {
        if (sprite.animation.finished && Math.random() < deco.animChance) sprite.animation.play("anim");
    }
    
    private function setDefaultFrame()
    {
        sprite.frame = sprite.frames.getByName(deco.name + "/01");
    }
}