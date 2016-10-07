package objects;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import objects.factories.LadderSpriteFactory;
import openfl.display.BitmapData;
using FlxSpriteExtender;

/**
 * ...
 * @author ...
 */
class Ladder
{
    private static inline var Nothing          = 0;
    private static inline var Start            = 1;
    private static inline var PartialSkeleton  = 2;
    private static inline var Building_Entered = 3;
    private static inline var Building         = 4;
    private static inline var Done_Entered     = 5;
    
    private static inline var SmallStep       = 13;
    private static inline var BigStep         = 14;
    
    private static var random = new FlxRandom();
    
    private var skeleton: FlxSprite;
    private var ladder:   FlxSprite;
    private var progress: Int;
    private var state:     Int = Start;
    
    public function new() {}
    
    public function init(x: Int, y: Int, tiles_count: Int)
    {
        skeleton          = LadderSpriteFactory.createSkeleton(tiles_count, x, y);
        ladder            = LadderSpriteFactory.create(tiles_count, x, y);
        ladder.clipRect   = new FlxRect(0, ladder.height, ladder.width, 0);
        skeleton.clipRect = new FlxRect(0, 0, 0, skeleton.height);
    }
    
    public function step() : Bool
    {
        switch(state)
        {
            case Start:
                skeleton.setClipWidth(skeleton.width / 2);
                state++;
            case PartialSkeleton:
                skeleton.clipRect = null;
                state++;
            case Building_Entered:
                progress = 1;
                StretchLadderClip(LevelMap.TileHeight + SmallStep);
                state++;
            case Building:
                StretchLadderClip(progress % 3 < 2 ? SmallStep : BigStep);
                if (ladder.clipRect.y <= 0)
                {
                    state++;
                }
                progress++;
            case Done_Entered:
                PlayState.obj.remove(skeleton);
                ladder.clipRect = null;
                skeleton        = null;
                state++;
        }
        
        return state <= Done_Entered;
    }
    
    private function StretchLadderClip(step: Int)
    {
        ladder.clipRect.y      -= step;
        ladder.clipRect.height += step;
        ladder.updateClip();
    }
}