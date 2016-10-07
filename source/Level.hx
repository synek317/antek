package;
import flixel.FlxG;
import flixel.FlxSprite;
import objects.Antek;

/**
 * ...
 * @author ...
 */
class Level
{
    private static inline var ZIndex_Object = 100;
    private static inline var ZIndex_Antek  = 200;
    
    public static function addAntek(antekType: String, x: Float, y: Float, ?initFunction: Antek -> Void): Antek
    {
        return addSprite(new Antek(antekType, x, y), ZIndex_Antek, initFunction);
    }
    
    public static function addObject(?initFunction: FlxSprite -> Void): FlxSprite
    {
        return addSprite(new FlxSprite(), ZIndex_Object, initFunction);
    }
    
    private static function addSprite<T:FlxSprite>(sprite: T, zIndex: Int, ?initFunction: T -> Void) : T
    {
        sprite.ID      = zIndex;
        sprite.cameras = [FlxG.camera];
        
        if(initFunction != null) initFunction(sprite);
        PlayState.addChild(sprite);
        
        return sprite;
    }
}