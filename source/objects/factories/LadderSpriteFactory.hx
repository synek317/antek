package objects.factories;
import flash.display.BitmapData;
import flash.geom.Point;
import flixel.FlxSprite;
import flixel.math.FlxRandom;

/**
 * ...
 * @author ...
 */
class LadderSpriteFactory
{
    private static inline var PixelWidth         = 40;
    private static inline var PartIndex_Top      = 0;
    private static inline var PartIndex_Bot      = 12;
    private static inline var PartIndex_Skeleton = 13;
    private static inline var PartIndex_Mid_Min  = PartIndex_Top + 1;
    private static inline var PartIndex_Min_Max  = PartIndex_Bot - 1;
 
    private static var random = new FlxRandom();   
    private static var point  = new Point(0, 0);
    
    public static function createSkeleton(tiles_height: Int, x: Float, y: Float) : FlxSprite
    {
        return Level.addObject(function(s) {
            initSprite(s, tiles_height, x, y);
            
            for (i in 1...(tiles_height-1))
            {
                draw(s.pixels, PartIndex_Skeleton, i);
            }
            
        });
    }
    
    public static function create(tiles_height: Int, x: Float, y: Float) : FlxSprite
    {
        return Level.addObject(function(s) {
            initSprite(s, tiles_height, x, y);
            s.ID++;
            
            for (i in 1...(tiles_height-1))
            {
                draw(s.pixels, randomPartIndex(), i);
            }
        });
    }
    
    private static inline function randomPartIndex() { return random.int(PartIndex_Mid_Min, PartIndex_Min_Max); }
    
    private static function initSprite(s: FlxSprite, tiles_height: Int, x: Float, y: Float)
    {
        s.pixels = new BitmapData(PixelWidth, tiles_height * LevelMap.TileHeight);
        s.x      = x;
        s.y      = y - s.pixels.height;
        
        draw(s.pixels, PartIndex_Top, 0);
        draw(s.pixels, PartIndex_Bot, tiles_height - 1);
    }
    
    private static function draw(bmp: BitmapData, partIndex: Int, tile: Int)
    {
        point.y = tile * 40;
        Textures.objects.getByName("ladder" + partIndex).paint(bmp, point);
    }
}