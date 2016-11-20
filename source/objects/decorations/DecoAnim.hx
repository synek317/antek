package objects.decorations;

class DecoAnim implements IUpdateable
{
    private var deco: DecoInfo;
    private var sprite: FlxSprite;
    
    public function new(deco: DecoInfo, obj: TiledObject, flipX: Bool, flipY: Bool)
    {
        this.sprite   = Textures.decorations.createSprite(deco.name + "/01");
        this.deco     = deco;
        
        this.sprite.animation.addByPrefix("anim", deco.name + "/", deco.frameRate, false, flipX, flipY);
        this.sprite.x      = obj.x;
        this.sprite.y      = obj.y - obj.height;
        this.sprite.ID     = deco.z;
    }
    
    public static function create(info: DecoInfo, obj: TiledObject, flipX: Bool, flipY: Bool)
    {
        var deco = new DecoAnim(info, obj, flipX, flipY);
        
        PlayState.addChild(deco.sprite);
        Objects.register(deco);
    }
    
    public function update(elapsed: Float)
    {
        if (sprite.animation.finished && Math.random() < deco.animChance) sprite.animation.play("anim");
    }
}