package objects;

class Ladder extends ASprite implements IObject
{
    private static inline var Nothing          = 0;
    private static inline var Start            = 1;
    private static inline var PartialSkeleton  = 2;
    private static inline var Building_Entered = 3;
    private static inline var Building         = 4;
    private static inline var Done_Entered     = 5;
    
    private static inline var SmallStep       = 13;
    private static inline var BigStep         = 14;
    
    private var progress            : Int;
    private var state               : Int = Start;
    private var ladder              : FlxSprite;
    private var skeleton            : FlxSprite;
    private var bottom              : FlxSprite;
    private var realLadder          : Bool = true;

    public var currentHeightInTiles : Int;

    override public function get_objectType() return Consts.Ladder;

    public function new()
    {
        super();
        this.z = ZOrder.Ladder;
    }
    
    public static inline function createReal(pos: Position, height: Int)  return create(pos, height, true);
    public static inline function createDummy(pos: Position, height: Int) return create(pos, height, false);
    
    private static function create(pos: Position, height: Int, real: Bool)
    {
        var l = new Ladder();

        l.init(height);
        l.position.tileShiftX = Consts.HalfTileWidth;
        l.position.set(pos);
        l.size.widthInTiles    = 1;
        l.currentHeightInTiles = 0;
        l.realLadder = real;

        if(real) ObjectsMap.placeXYTiles(pos.tileX, pos.tileY - height + 2, pos.tileX + 1, pos.tileY + 1, l.objectType);

        return l;
    }

    public function init(tiles_count: Int)
    {
        this.removeAllSubSprites();
        size.heightInTiles = tiles_count;
        
        skeleton            = addPart(LadderSpriteFactory.createSkeleton(tiles_count), 0).sprite;
        ladder              = addPart(LadderSpriteFactory.create(tiles_count),         1).sprite;
        var botSubSprite    = addPart(LadderSpriteFactory.createBot(),                 -1);
        bottom              = botSubSprite.sprite;
        
        botSubSprite.shiftY = 0;
        ladder.clipRect     = new FlxRect(0, ladder.height, ladder.width, 0);
        skeleton.clipRect   = new FlxRect(0, 0, 0, skeleton.height);
    }
    
    public function step() : Bool
    {
        if (FlxG.keys.pressed.S) { bottom.visible = !bottom.visible; }
        switch(state)
        {
            case Start:
                skeleton.setClipWidth(skeleton.width / 2);
                state++;
            case PartialSkeleton:
                skeleton.clipRect = null;
                //PlayState.removeChild(bottom);
                state++;
            case Building_Entered:
                progress = 1;
                StretchLadderClip(Consts.TileHeight + SmallStep);
                state++;
            case Building:
                StretchLadderClip(progress % 3 < 2 ? SmallStep : BigStep);
                currentHeightInTiles = Math.floor(ladder.clipRect.height / Consts.TileHeight);
                if (ladder.clipRect.y <= 1.5 * Consts.TileHeight)
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
        
        skeleton              = null;
        ladder.clipRect       = null;
        state                 = Done_Entered + 1;
        currentHeightInTiles  = Math.floor(ladder.height / Consts.TileHeight);

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
           -Consts.HalfTileWidth,
           -Consts.TileHeight * (size.heightInTiles-1),
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