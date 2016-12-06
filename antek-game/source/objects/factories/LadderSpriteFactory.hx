package objects.factories;

class LadderSpriteFactory
{
    private static inline var PixelWidth         = 40;
    private static inline var PartIndex_Top      = 0;
    private static inline var PartIndex_Bot      = 12;
    private static inline var PartIndex_Skeleton = 13;
    private static inline var PartIndex_Mid_Min  = PartIndex_Top + 1;
    private static inline var PartIndex_Mid_Max  = PartIndex_Bot - 1;
    private static inline var PartIndex_Broken   = 14;
  
    private static var point  = new Point(0, 0);
    
    public static function createSkeleton(tiles_height: Int) : FlxSprite
    {
        var s = new FlxSprite();
        
        initSprite(s, tiles_height);

        for (i in 1...(tiles_height-1))
        {
            draw(s.pixels, PartIndex_Skeleton, i);
        }
        
        return s;
    }
    
    public static function create(tiles_height: Int) : FlxSprite
    {
        var s = new FlxSprite();
        
        initSprite(s, tiles_height);
        
        for (i in 1...(tiles_height-1))
        {
            draw(s.pixels, randomPartIndex(), i);
        }
        
        return s;
    }

    public static function createTop()    return Textures.objects.createSprite("ladder" + PartIndex_Top);
    public static function createBroken() return Textures.objects.createSprite("ladder" + PartIndex_Broken);
    public static function createBot()    return Textures.objects.createSprite("ladder" + PartIndex_Bot);
    
    private static inline function randomPartIndex() return random_int(PartIndex_Mid_Min, PartIndex_Mid_Max);
    
    private static function initSprite(s: FlxSprite, tiles_height: Int)
    {
        s.pixels = new BitmapData(PixelWidth, tiles_height * Consts.TileHeight);
        
        draw(s.pixels, PartIndex_Top, 0);
        draw(s.pixels, PartIndex_Bot, tiles_height - 1);
    }
    
    private static function draw(bmp: BitmapData, partIndex: Int, tile: Int)
    {
        point.y = tile * Consts.TileHeight;
        var name = partIndex >= 1 && partIndex <= 3 ? "bridge" : "ladder";
        Textures.objects.getByName(name + partIndex).paint(bmp, point);
    }
}