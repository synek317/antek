package engine;

class ASprite
{
    private var subSprites: List<SubSprite> = new List<SubSprite>();
    
    public var x(default, set): Float;
    public var y(default, set): Float;
    public var z(default, set): Int;
    public var tileX(get, set): Int;
    public var tileY(get, set): Int;
    
    public function addSubSprite(subSprite: SubSprite): SubSprite
    {
        this.subSprites.add(subSprite);
        subSprite.sprite.cameras = [FlxG.camera];
        PlayState.obj.add(subSprite.sprite);
        return subSprite;
    }
    
    function set_x(newX)
    {
        x = newX;
        for (subSprite in subSprites) subSprite.sprite.x = x + subSprite.shiftX;
        return x;
    }
    
    function set_y(newY)
    {
        y = newY;
        for (subSprite in subSprites) subSprite.sprite.y = y + subSprite.shiftY;
        return y;
    }
    
    function set_z(newZ)
    {
        z = newZ;
        for (subSprite in subSprites) subSprite.sprite.ID = z + subSprite.shiftZ;
        PlayState.scheduleZReorder();
        return z;
    }
    
    function get_tileX()        return x.to_htile();
    function set_tileX(tx: Int) return Std.int(x = tx.htile() + LevelMap.HalfTileWidth);
    
    function get_tileY()        return y.to_htile();
    function set_tileY(ty: Int) return Std.int(y = ty.vtile());
}