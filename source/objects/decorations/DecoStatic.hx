package objects.decorations;

class DecoStatic
{
    public static function create(type: String, obj: TiledObject)
    {
        var sprite = Textures.decorations.createSprite(type);
        
        sprite.cameras = [FlxG.camera];
        sprite.x = obj.x;
        sprite.y = obj.y - obj.height;

        PlayState.addChildZ(sprite, ZOrder.Deco);
    }
