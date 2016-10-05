package objects;
import flash.geom.Point;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.math.FlxRect;
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
    
    public function new() {}
    
    public function init(x: Int, y: Int, tiles_count: Int)
    {
        this.tiles_count = tiles_count;
        
        pixel_height = tiles_count * 40;
        skeleton = new FlxSprite();
        skeleton.cameras = [FlxG.camera];
        skeleton.pixels = new BitmapData(pixel_width, pixel_height);
        
        ladder = new FlxSprite();
        ladder.cameras = [FlxG.camera];
        ladder.pixels = new BitmapData(pixel_width, pixel_height);
        
        skeleton.x = x;
        skeleton.y = y - pixel_height;
        ladder.x = skeleton.x;
        ladder.y = skeleton.y;
        
        draw(0, 0, ladder.pixels);
        draw(0, 0, skeleton.pixels);
        draw(12, tiles_count - 1, ladder.pixels);
        draw(12, tiles_count - 1, skeleton.pixels);
        
        for (i in 1...(tiles_count-1))
        {
            var r = random.int(1, 11);
            draw(r, i, ladder.pixels);
            draw(13, i, skeleton.pixels);
        }
        
        PlayState.addChildZ(skeleton, 10);
        PlayState.addChildZ(ladder, 11);
        ladder.clipRect = new FlxRect(0, pixel_height, pixel_width, 0);
        skeleton.clipRect = new FlxRect(0, 0, 0, pixel_height);
    }
    
    private var finished = false;
    public function step()
    {
        if (finished) { return; }
        
        progress++;
        switch(progress)
        {
            case 1: skeleton.clipRect.width = pixel_width / 2; skeleton.clipRect = skeleton.clipRect;
            case 2: skeleton.clipRect = null;
        case 3:
            ladder.clipRect.y -= 53;
            ladder.clipRect.height += 53;
            ladder.clipRect = ladder.clipRect;
        default:
                var step = progress % 5 == 0 ? 14 : 13;
                
                ladder.clipRect.y -= step;
                ladder.clipRect.height += step;
                if (ladder.clipRect.y <= 0)
                {
                    ladder.clipRect = null;
                    PlayState.obj.remove(skeleton);
                    skeleton = null;
                    finished = true;
                }
                else
                {
                    ladder.clipRect = ladder.clipRect;
                }
        }
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
        point.y = tile * 40;
        Textures.objects.getByName("ladder" + partIndex).paint(bmp, point);
    }
}