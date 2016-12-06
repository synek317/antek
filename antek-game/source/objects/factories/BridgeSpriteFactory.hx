package objects.factories;
import openfl.geom.Rectangle;

class BridgeSpriteFactory
{
    private static inline var PixelHeight         = 40;
    private static inline var LeftTilePixelWidth  = 39;
    private static inline var MidTilePixelWidth   = 40;
    private static inline var RightTilePixelWidth = 42;
    private static inline var LeftYPosition       = 0;
    private static inline var MidYPosition        = 7;
    private static inline var RightYPosition      = 0;
    private static inline var PartIndex_Left      = 1;
    private static inline var PartIndex_Mid       = 2;
    private static inline var PartIndex_Right     = 3;
  
    private static var point = new Point(0, 0);
    
    public static function create(tiles_width: Int) : FlxSprite
    {
        var s = new FlxSprite();
        
        initSprite(s, tiles_width);
        
        for (i in 1...(tiles_width-1))
        {
            draw(s.pixels, PartIndex_Mid, LeftTilePixelWidth + (i-1) * MidTilePixelWidth, MidYPosition);
        }
        
        return s;
    }

    /*public static function createLeft()  return Textures.objects.createSprite("bridge" + PartIndex_Left);
    public static function createMid()   return Textures.objects.createSprite("bridge" + PartIndex_Mid);    
    public static function createRight() return Textures.objects.createSprite("bridge" + PartIndex_Right);*/
    
    private static function initSprite(s: FlxSprite, tiles_width: Int)
    {
        var pixelWidth = (tiles_width - 2) * Consts.TileWidth + LeftTilePixelWidth + RightTilePixelWidth;
        s.pixels = new BitmapData(pixelWidth, PixelHeight);
        s.pixels.fillRect(new Rectangle(0, 0, pixelWidth, PixelHeight), 0x00000000);
        
        draw(s.pixels, PartIndex_Left, 0, LeftYPosition);
        draw(s.pixels, PartIndex_Right, pixelWidth - RightTilePixelWidth, RightYPosition);
    }
    
    private static function draw(bmp: BitmapData, partIndex: Int, x: Float, y: Float)
    {
        point.x = x;
        point.y = y;
        Textures.objects.getByName("bridge" + partIndex).paint(bmp, point);
    }
}