package objects.decorations;

class DecoStatic
{
    public static function create(deco: DecoInfo, obj: TiledObject, flipX: Bool, flipY: Bool)
    {
        var sprite = Textures.decorations.createSprite(deco.name);
        
        sprite.cameras = [FlxG.camera];
        sprite.x       = obj.x;
        sprite.y       = obj.y - obj.height;
        sprite.flipX   = flipX;
        sprite.flipY   = flipY;

        PlayState.addChildZ(sprite, deco.z);
    }
}