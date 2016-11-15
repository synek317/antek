package tools;

class FlxAtlasFramesExtenders
{
    public static function createSprite(frames: FlxAtlasFrames, frameName: String): FlxSprite
    {
        var sprite = new FlxSprite();
        
        sprite.frames = frames;
        sprite.frame  = frames.getByName(frameName);
        sprite.centerOrigin(); //ugly fix to recalculate sprite width and height (otherwise it has the size taken from first sprite in atlas)
        
        return sprite;
    }
}