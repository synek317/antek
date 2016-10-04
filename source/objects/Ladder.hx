package objects;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import openfl.display.BitmapData;

/**
 * ...
 * @author ...
 */
class Ladder
{
    private static var random = new FlxRandom();
    
    private var skeleton: FlxSprite;
    private var ladder: FlxSprite;
    private var pixel_height: Int;
    private static inline var pixel_width: Int = 40;
    private var progress: Int = 0;
    private var current_height(get, never) : Float;
    private var tiles_count: Int;

    private function get_current_height() : Int
    {
        var h = (progress - 2) * 40;
        
        return h > 0 ? h : 0;
    }
    
    public function init(x: Int, y: Int, tiles_count: Int)
    {
        this.tiles_count = tiles_count;
        
        pixel_height = tiles_count * 40;
        var g = new BitmapData(pixel_width, pixel_height);
        skeleton = new FlxSprite();
        skeleton.cameras = [FlxG.camera];
        skeleton.pixels = g;
        
        g = new BitmapData(pixel_width, pixel_height);
        ladder = new FlxSprite();
        ladder.cameras = [FlxG.camera];
        ladder.pixels = g;
        
        skeleton.x = x;
        skeleton.y = y - pixel_height;
        ladder.x = skeleton.x;
        ladder.y = skeleton.y;
        
        draw(0, 0, ladder.pixels);
        for (i in 1...(tiles_count-1))
        {
            var r = random.int(1, 11);
            draw(r, i, ladder.pixels);
        }
        draw(12, tiles_count - 1, ladder.pixels);
        
        //PlayState.obj.add(skeleton);
        PlayState.obj.add(ladder);
    }
    
    public function step() : Bool
    {
        progress++;
        switch(progress)
        {
            case 1: draw_skeleton_left();
            case 2: draw_skeleton_full();
            default:
                draw_ladder();
                if (current_height >= pixel_height)
                {
                    PlayState.obj.remove(skeleton);
                    skeleton.pixels.dispose();
                    return true;
                }
        }
        
        return false;
    }
    
    private function draw_skeleton_left()
    {
        
    }
    
    private function draw_skeleton_full()
    {
        
    }
    
    private function draw_ladder()
    {
        
    }
    
    private static var point = new Point();
    private static var helperSprite = new FlxSprite();
    private function draw(partIndex: Int, tile: Int, bmp: BitmapData)
    {
        //ladder.stamp(parts[partIndex], 0, tile * 40);
        point.y = tile * 40;
        Textures.objects.getByName("ladder" + partIndex).paint(ladder.pixels, point);
    }
}