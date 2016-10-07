package;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class FlxSpriteExtender
{
    public static inline function setClipWidth(s: FlxSprite, w: Float)
    {
        s.clipRect.width = w;
        updateClip(s);
    }
    
    public static inline function updateClip(s: FlxSprite)
    {
        s.clipRect = s.clipRect;
    }
}