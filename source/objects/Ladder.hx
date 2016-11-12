package objects;

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
    
    private var progress   : Int;
    private var state      : Int = Start;
    private var ladder     : FlxSprite;
    private var skeleton   : FlxSprite;
    private var bottom     : FlxSprite;
    private var realLadder : Bool = true;

    public var heightTiles: Int;
    
    public static function create(tileX: Int, tileY: Int, height: Int)
    {
        var l = new Ladder();

        l.init(height);
        l.tileX = tileX;
        l.tileY = tileY;

        return l;
    }

    public static function createDummy(tileX: Int, tileY: Int, height: Int)
    {
        var l = create(tileX, tileY, height);
        l.realLadder = false;
        return l;
    }

    public function new() { super(); }
    
    public function init(tiles_count: Int)
    {
        this.removeAllSubSprites();
        
        skeleton          = addPart(LadderSpriteFactory.createSkeleton(tiles_count), 0).sprite;
        ladder            = addPart(LadderSpriteFactory.create(tiles_count),         1).sprite;
        bottom            = addPart(LadderSpriteFactory.createBot(),                 2).sprite;
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
                PlayState.removeChild(bottom);
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
                PlayState.removeChild(skeleton);
                ladder.clipRect = null;
                skeleton        = null;
                state++;
                finish();
        }
        
        return state <= Done_Entered;
    }
    
    public function createImmediately()
    {
        PlayState.removeChild(skeleton);
        PlayState.removeChild(bottom);
        
        skeleton        = null;
        ladder.clipRect = null;
        state           = Done_Entered + 1;
        heightTiles     = Math.floor(ladder.height / LevelMap.TileHeight);

        finish();
    }
    
    private function finish()
    {
        if(!realLadder) return;

        var top_cell = ladder.y.to_vcell() +  Consts.CellsPerVTile;
        var bottom_cell = top_cell + ladder.height.to_vcell() - 2 * Consts.CellsPerVTile;
        var x = ladder.x.to_hcell() + int(Consts.CellsPerHTile / 2);
        
        for (y in top_cell...bottom_cell)
        {
            PathMap.setAt(x, y, 1);
        }
    }
    
    private function addPart(sprite: FlxSprite, shiftZ: Int): SubSprite
    {
        return addSubSprite(new SubSprite(
           this,
           sprite,
           -LevelMap.TileWidth / 2.0,
           -sprite.height + LevelMap.TileHeight,
           shiftZ
        ));
    }
    
    private function StretchLadderClip(step: Int)
    {
        ladder.clipRect.y      -= step;
        ladder.clipRect.height += step;
        ladder.updateClip();
    }
}