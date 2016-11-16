package objects.decorations;

class DecoStatic
{
    public static function create(deco: DecoInfo, obj: TiledObject)
    {
        var sprite = Textures.decorations.createSprite(deco.name);
        
        sprite.cameras = [FlxG.camera];
        sprite.x = obj.x;
        sprite.y = obj.y - obj.height;

        PlayState.addChildZ(sprite, deco.z);
    }
}