package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
    public function new()
    {
        #if (debug && cpp)
            new debugger.HaxeRemote(true, "localhost");
        #end
        
        super();
        addChild(new FlxGame(0, 0, PlayState));
    }
}
