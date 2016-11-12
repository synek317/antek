package engine;

class ASprite
{
    private var subSprites: List<SubSprite> = new List<SubSprite>();
    
    public var x(default, set)       : Float;
    public var y(default, set)       : Float;
    public var z(default, set)       : Int;
    public var tileX(get, set)       : Int;
    public var tileY(get, set)       : Int;
    public var alpha(default, set)   : Float;
    public var visible(default, set) : Bool;

    public function new()
    {
        this.x       = 0;
        this.y       = 0;
        this.z       = 0;
        this.tileX   = 0;
        this.tileY   = 0;
        this.alpha   = 1;
        this.visible = true;
    }

    public function addSubSprite(subSprite: SubSprite): SubSprite
    {
        subSprite.sprite.x       = this.x + subSprite.shiftX;
        subSprite.sprite.y       = this.y + subSprite.shiftX;
        subSprite.sprite.y       = this.z + subSprite.shiftX;
        subSprite.sprite.alpha   = this.alpha;
        subSprite.sprite.visible = this.visible;

        this.subSprites.add(subSprite);

        subSprite.sprite.cameras = [FlxG.camera];
        PlayState.addChild(subSprite.sprite);
        return subSprite;
    }

    public function removeAllSubSprites()
    {
        for (subSprite in subSprites) PlayState.removeChild(subSprite.sprite);
        subSprites.clear();
    }
    
    public function updateSubSpritesX()
    {
        for (subSprite in subSprites) subSprite.sprite.x = x + subSprite.shiftX;
    }

    public function updateSubSpritesY()
    {
        for (subSprite in subSprites) subSprite.sprite.y = y + subSprite.shiftY;    
    }

    public function updateSubSpritesZ()
    {
        for (subSprite in subSprites) subSprite.sprite.ID = z + subSprite.shiftZ;
        PlayState.scheduleZReorder();
    }

    function set_x(newX)
    {
        x = newX;
        updateSubSpritesX();
        return x;
    }
    
    function set_y(newY)
    {
        y = newY;
        updateSubSpritesY();
        return y;
    }
    
    function set_z(newZ)
    {
        z = newZ;
        updateSubSpritesZ();
        return z;
    }

    function set_alpha(newAlpha)
    {
        alpha = newAlpha;
        for (subSprite in subSprites) subSprite.sprite.alpha = newAlpha;
        return alpha;
    }

    function set_visible(newVisible)
    {
        visible = newVisible;
        for (subSprite in subSprites) subSprite.sprite.visible = newVisible;
        return visible;
    }
    
    function get_tileX()        return x.to_htile();
    function set_tileX(tx: Int) return Std.int(x = tx.htile() + LevelMap.HalfTileWidth);
    
    function get_tileY()        return y.to_htile();
    function set_tileY(ty: Int) return Std.int(y = ty.vtile());
}