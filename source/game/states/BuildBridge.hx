package game.states;

class BuildBridge
{
    public static function enter()
    {
        if (Game.state == GameState.BuildBridge)         return exit();
        if (Game.state != GameState.Idle)                return;
        if (Game.selected == null || Game.selected.busy) return;

        if (Game.bridge == null) initBridge();

        Game.state = GameState.BuildBridge;
    }

    public static function update()
    {
        if (FlxG.keys.justPressed.N || FlxG.keys.justPressed.ESCAPE) return exit();
        
        var mouseTileX = Mouse.x.to_htile();
        var mouseTileY = Mouse.y.to_vtile();

        if(mouseTileX != Game.mouseTileX || mouseTileY != Game.mouseTileY)
        {
            Game.mouseTileX = mouseTileX;
            Game.mouseTileY = mouseTileY;

            updateLadderPosition();
        }

        if(FlxG.mouse.justDblClicked() && Game.bridge.visible)
        {
            actions.BuildBridge.start(Game.selected, Game.bridge.position, Game.bridge.size.widthInTiles);
            exit();
        }
    }

    public static function exit()
    {
        Game.state                 = GameState.Idle;
        Game.bridge.visible        = false;
        Game.invalidBridge.visible = false;
    }

    private static function initBridge()
    {
        Game.ladder              = Bridge.createDummy(Position.fromTile(0, 0), 1);
        Game.invalidBridge       = new InvalidBridge();

        Game.bridge.alpha        = 0.5;
        Game.invalidBridge.alpha = 0.5;
    }

    private static function updateBridgePosition()
    {
        var left:  Int = -1;
        var right: Int = -1;

        if(LevelMap.isGroundAt(Game.mouseTileX, Game.mouseTileY))
        {
            left  = Game.mouseTileY;
            right = findRight(Game.maxBridgeWidth);

            if(right == -1)
            {
                right = top;
                left  = findLeft(Game.maxBridgeWidth);
            }
        }
        else
        {
            left = findLeft(Game.maxBridgeWidth);
            
            if(left != -1)
            {
                right = findRight(Game.maxBridgeWidth - (left - Game.mouseTileY).absi());
            }
        }

        if (left != -1 && right != -1
            && ObjectsMap.canPlaceXYTiles(left, Game.mouseTileY, right + 1, Game.mouseTileY + 1)
            && AStar.obj.isAchievable(Game.selected.position, left * Consts.CellsPerHTile, Game.mouseTileY * Consts.CellsPerVTile))
        {
            var width = (left - right).abs()+2;
            if(width != Game.bridge.size.widthInTiles)
            {
                Game.bridge.init(width);
                Game.bridge.createImmediately();
            }
            
            Game.bridge.position.tileX = left;
            Game.bridge.position.tileY = Game.mouseTileY;
            Game.bridge.show();
        }
        else
        {
            Game.bridge.visible = false;
            
            Game.invalidBridge.position.tileX = Game.mouseTileX - (if (LevelMap.isGroundAt(Game.mouseTileX, Game.mouseTileY)) { 1; } else { 0; });
            Game.invalidBridge.position.tileY = Game.mouseTileY;
        }

        Game.invalidBridge.visible = !Game.bridge.visible;
    }

    private static function findLeft(maxWidth: Int)
    {
        var i : Int = Game.mouseTileX - 1;
        while(i >= Game.mouseTileX-maxWidth)
        {
            if(LevelMap.isGroundAt(i, Game.mouseTileY)) return i;
            --i;
        }

        return -1;
    }

    private static function findRight(maxWidth: Int)
    {
        for(i in (Game.mouseTileX+1)...(Game.mouseTileX+maxWidth+1))
        {
            if(LevelMap.isGroundAt(i, Game.mouseTileY)) return i;
        }
        
        return -1;
    }
}