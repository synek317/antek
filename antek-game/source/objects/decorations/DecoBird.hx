package objects.decorations;

class DecoBird implements IUpdateable
{
    private var deco:      DecoInfo;
    private var sprite:    FlxSprite;
    private var obj:       TiledObject;
    private var moving:    Bool;
    private var startingY: Float;
    private var movingUp:  Bool;
    
    public function new(deco: DecoInfo, obj: TiledObject, flipX: Bool, flipY: Bool)
    {
        this.sprite       = Textures.decorations.createSprite(deco.name + "/01");
        this.deco         = deco;
        this.obj          = obj;
        this.sprite.x     = obj.x;
        this.sprite.y     = obj.y - obj.height;
        this.sprite.ID    = deco.z;
        this.sprite.flipX = flipX;
        this.sprite.flipY = flipY;
        this.moving       = false;
        this.startingY    = this.sprite.y;
        
        this.sprite.animation.addByPrefix("anim", deco.name + "/", deco.frameRate, true);
    }
    
    public static function create(info: DecoInfo, obj: TiledObject, flipX: Bool, flipY: Bool)
    {
        var deco = new DecoBird(info, obj, flipX, flipY);
        
        PlayState.addChild(deco.sprite);
        Objects.register(deco);
    }
    
    public function update(elapsed: Float)
    {
        if (moving)
        {
            moveABit(elapsed);
        }
        else if (Math.random() < deco.animChance)
        {
            moving = true;
            sprite.animation.play("anim");
        }
    }
    
    private function moveABit(elapsed: Float)
    { 
        if (sprite.flipX) sprite.x -= deco.speed * elapsed;
        else              sprite.x += deco.speed * elapsed;
        
        if (movingUp)
        {
            if (sprite.y > startingY - 10) sprite.y -= deco.speed * 0.4 * elapsed;
            else                           movingUp = false;
        }
        else
        {
            if (sprite.y < startingY + 10) sprite.y += deco.speed * 0.16 * elapsed;
            else                           movingUp = true; 
        }
        
        if ((!sprite.flipX && sprite.x > LevelMap.widthInPixels) || (sprite.flipX && sprite.x + obj.width < 0))
        {
            moving       = false;
            sprite.flipX = !sprite.flipX;
            this.sprite.animation.stop();
        }
    }
}