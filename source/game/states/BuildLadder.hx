package game.states;

class BuildLadder
{
    public static function enter()
    {
        if (Game.state == GameState.BuildLadder)         return exit();
        if (Game.state != GameState.Idle)                return;
        if (Game.selected == null || Game.selected.busy) return;

        if (Game.ladder == null) initLadder();

        Game.state = GameState.BuildLadder;
    }

    public static function update()
    {
        if (FlxG.keys.justPressed.B || FlxG.keys.justPressed.ESCAPE) return exit();
        
        var mouseTileX = Mouse.x.to_htile();
        var mouseTileY = Mouse.y.to_vtile();

        if(mouseTileX != Game.mouseTileX || mouseTileY != Game.mouseTileY)
        {
            Game.mouseTileX = mouseTileX;
            Game.mouseTileY = mouseTileY;

            updateLadderPosition();
        }

        if(FlxG.mouse.justDblClicked() && Game.ladder.visible)
        {
            actions.BuildLadder.start(Game.selected, Game.ladder.tileX, Game.ladder.tileY, Game.ladder.heightTiles);
            exit();
        }
    }

    public static function exit()
    {
        Game.state                 = GameState.Idle;
        Game.ladder.visible        = false;
        Game.invalidLadder.visible = false;
    }

    private static function initLadder()
    {
        Game.ladder              = Ladder.createDummy(0, 0, 1);
        Game.invalidLadder       = new InvalidLadder();

        Game.ladder.alpha        = 0.5;
        Game.invalidLadder.alpha = 0.5;
    }

    private static function updateLadderPosition()
    {
        var top: Int = -1;
        var bot: Int = -1;

        if(LevelMap.isGroundAt(Game.mouseTileX, Game.mouseTileY))
        {
            top = Game.mouseTileY;
            bot = findBot(Game.maxLadderHeight);

            if(bot == -1)
            {
                bot = top;
                top = findTop(Game.maxLadderHeight);
            }
        }
        else
        {
            top = findTop(Game.maxLadderHeight);
            
            if(top != -1)
            {
                bot = findBot(Game.maxLadderHeight - (top - Game.mouseTileY).absi());
            }
        }

        if (top != -1 && bot != -1
            && AStar.obj.isAchievable(Game.selected.x.to_hcell(), Game.selected.y.to_vcell(), Game.mouseTileX * Consts.CellsPerHTile, bot * Consts.CellsPerVTile))
        {
            var height = (top-bot).abs()+2;
            if(height != Game.ladder.heightTiles)
            {
                Game.ladder.init(height);
                Game.ladder.createImmediately();
            }
            Game.ladder.tileX = Game.mouseTileX;
            Game.ladder.tileY = bot;
            Game.ladder.visible = true;
        }
        else
        {
            Game.ladder.visible = false;
            
            Game.invalidLadder.tileX = Game.mouseTileX;
            Game.invalidLadder.tileY = Game.mouseTileY - (if (LevelMap.isGroundAt(Game.mouseTileX, Game.mouseTileY)) { 1; } else { 0; });
        }

        Game.invalidLadder.visible = !Game.ladder.visible;
    }

    private static function findTop(maxHeight: Int)
    {
        var i : Int = Game.mouseTileY-1;
        while(i >= Game.mouseTileY-maxHeight)
        {
            if(LevelMap.isGroundAt(Game.mouseTileX, i)) return i;
            --i;
        }

        return -1;
    }

    private static function findBot(maxHeight: Int)
    {
        for(i in (Game.mouseTileY+1)...(Game.mouseTileY+maxHeight+1))
        {
            if(LevelMap.isGroundAt(Game.mouseTileX, i)) return i;
        }
        
        return -1;
    }
}