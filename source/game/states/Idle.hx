package game.states;

class Idle
{
    public static function update()
    {
        if (FlxG.mouse.justDblClicked() && Game.selected != null) moveSelectedAntek();
        if (FlxG.keys.justPressed.B)                              Game.buildLadder();
    }

    private static function moveSelectedAntek()
    {
        var mouseTileX = Mouse.x.to_htile();
        var mouseTileY = Mouse.y.to_vtile();

        if(LevelMap.isGroundAt(mouseTileX, mouseTileY))        Game.selected.moveTo(Mouse.x.to_hcell(), mouseTileY * Consts.CellsPerVTile);
        else if(LevelMap.isGroundAt(mouseTileX, mouseTileY+1)) Game.selected.moveTo(Mouse.x.to_hcell(), (mouseTileY+1) * Consts.CellsPerVTile);
    }
}