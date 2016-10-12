package objects;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
import framework.ASprite;
import framework.SubSprite;
import objects.factories.LadderSpriteFactory;
import openfl.display.BitmapData;
using FlxSpriteExtender;

/**
 * ...
 * @author ...
 */
class Ladder extends ASprite
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
    
    private var progress: Int;
    private var state:    Int = Start;
    private var ladder:   FlxSprite;
    private var skeleton: FlxSprite;
    
    public var heightTiles: Int;
    
    public function new() {}
    
    public function init(tiles_count: Int)
    {
        skeleton          = addPart(LadderSpriteFactory.createSkeleton(tiles_count), 0).sprite;
        ladder            = addPart(LadderSpriteFactory.create(tiles_count),         1).sprite;
        ladder.clipRect   = new FlxRect(0, ladder.height, ladder.width, 0);
        skeleton.clipRect = new FlxRect(0, 0, 0, skeleton.height);
        heightTiles       = 0;
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
                heightTiles = Math.floor(ladder.clipRect.height / LevelMap.TileHeight);
                if (ladder.clipRect.y <= 1.5 * LevelMap.TileHeight)
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
    
    public function createImmediately()
    {
        PlayState.obj.remove(skeleton);
        skeleton        = null;
        ladder.clipRect = null;
        state           = Done_Entered + 1;
    }
    
    private function addPart(sprite: FlxSprite, shiftZ: Int): SubSprite
    {
        return addSubSprite({
           sprite: sprite,
           shiftX: -LevelMap.TileWidth / 2.0,
           shiftY: -sprite.height,
           shiftZ: shiftZ
        });
    }
    
    private function StretchLadderClip(step: Int)
    {
        ladder.clipRect.y      -= step;
        ladder.clipRect.height += step;
        ladder.updateClip();
    }
}