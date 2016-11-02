package tools;

class FlxAtlasFramesExtenders
{
    public static function createSprite(frames: FlxAtlasFrames, frameName: String): FlxSprite
    {
        var sprite = new FlxSprite();
        
        sprite.frames = frames;
        sprite.frame  = frames.getByName(frameName);
        
        return sprite;
    }
}