package framework;
import flixel.FlxG;
import flixel.FlxSprite;
import framework.SubSprite;

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
    
    function get_tileX()   return Std.int(x / LevelMap.TileWidth);
    function set_tileX(tx) return Std.int(x = tx * LevelMap.TileWidth + LevelMap.HalfTileWidth);
    
    function get_tileY()   return Std.int(y / LevelMap.TileHeight);
    function set_tileY(ty) return Std.int(y = ty * LevelMap.TileHeight);
}