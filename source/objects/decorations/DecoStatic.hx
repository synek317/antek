package objects.decorations;

class DecoStatic
{
    public static function create(type: String, obj: TiledObject)
    {
        var sprite = Textures.decorations.createSprite(type);
        
        sprite.x = obj.x;
        sprite.y = obj.y - sprite.height;
        sprite.cameras = [FlxG.camera];

        PlayState.addChildZ(sprite, ZOrder.Deco);
    }
}