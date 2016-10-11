package;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import objects.Antek;

/**
 * ...
 * @author ...
 */
typedef Constructible = {
    public function new(): Void;
}

class Level
{
    /*private static inline var ZIndex_Object = 100;
    private static inline var ZIndex_Antek  = 200;
    
    public static function addAntek(antekType: String, ?initFunction: Antek -> Void): Antek
    {
        return addSprite(new Antek(antekType), ZIndex_Antek, initFunction);
    }
    
    @:generic public static function addObject<T:(FlxBasic,Constructible)>(?initFunction: T -> Void): T
    {
        return addSprite(new T(), ZIndex_Object, initFunction);
    }
    
    @:generic private static function addSprite<T:FlxBasic>(sprite: T, zIndex: Int, ?initFunction: T -> Void) : T
    {
        sprite.ID      = zIndex;
        sprite.cameras = [FlxG.camera];
        
        if(initFunction != null) initFunction(sprite);
        PlayState.addChild(sprite);
        
        return sprite;
    }*/
}