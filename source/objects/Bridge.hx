package objects;

class Bridge extends ASprite implements IObject
{
    private static inline var Nothing          = 0;
    private static inline var Start            = 1;
    private static inline var Building         = 2;
    private static inline var Done_Entered     = 3;
    
    private static inline var Step       = 10;
    
    private var progress            : Int;
    private var state               : Int = Start;
    private var bridge              : FlxSprite;
    private var realLadder          : Bool = true;

    public var currentWidthInTiles : Int;

    override public function get_objectType() return Consts.Bridge;

    public function new()
    {
        super();
        this.z = ZOrder.Bridge;
    }
    
    public static inline function createReal(pos: Position, width: Int)  return create(pos, width, true);
    public static inline function createDummy(pos: Position, width: Int) return create(pos, width, false);
    
    private static function create(pos: Position, width: Int, real: Bool)
    {
        var b = new Bridge();

        b.init(width);
        b.position.set(pos);
        b.size.heightInTiles  = 1;
        b.currentWidthInTiles = 0;
        b.realLadder = real;

        if(real) ObjectsMap.placeXYTiles(pos.tileX, pos.tileY, pos.tileX + width, pos.tileY + 1, b.objectType);

        return b;
    }

    public function init(tiles_count: Int)
    {
        this.removeAllSubSprites();
        size.widthInTiles = tiles_count;
        
        bridge            = addPart(BridgeSpriteFactory.create(tiles_count), 1).sprite;
        
        bridge.clipRect   = new FlxRect(0, 0, 0, bridge.height);
    }
    
    public function step() : Bool
    {
        switch(state)
        {
            case Start:
                progress = 1;
                StretchBridgeClip();
                state++;
            case Building:
                StretchBridgeClip();
                currentWidthInTiles = Math.floor(bridge.clipRect.width / Consts.TileHeight);
                if (bridge.clipRect.width > this.size.widthInTiles * Consts.TileWidth - 10)
                {
                    state++;
                }
                progress++;
            case Done_Entered:
                bridge.clipRect = null;
                state++;
                finish();
        }
        
        return state <= Done_Entered;
    }
    
    public function createImmediately()
    {
        bridge.clipRect       = null;
        state                 = Done_Entered + 1;
        currentWidthInTiles   = Math.floor(bridge.width / Consts.TileWidth);

        finish();
    }
    
    private function finish()
    {
        if(!realLadder) return;

        var y = bridge.y.to_hcell();
        var left_x = bridge.x.to_hcell();
        var right_x = left_x + size.widthInCells + 1;
        
        for (x in left_x...right_x)
        {
            PathMap.setAt(x, y, 1);
        }
    }
    
    private function addPart(sprite: FlxSprite, shiftZ: Int): SubSprite
    {
        return addSubSprite(new SubSprite(
           this,
           sprite,
           -0,
           -20,
           shiftZ
        ));
    }
    
    private function StretchBridgeClip()
    {
        bridge.clipRect.width  += Step;
        bridge.updateClip();
    }
}