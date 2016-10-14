package actions;
import flixel.FlxG;
import objects.Antek;
import objects.Ladder;

/**
 * ...
 * @author ...
 */
class BuildLadder
{
    private var antek:  Antek;
    private var ladder: Ladder;
 
    public function new(antek: Antek, ladder: Ladder)
    {
        this.antek  = antek;
        this.ladder = ladder;
    }
    
    public function action()
    {
        antek.moveToX(ladder.x - LevelMap.HalfTileWidth)
            .then(antek.turnRight)
            .then(build);
    }
    
    private function build()
    {
        antek.build(buildLadder);
    }
    
    private function buildLadder()
    {
        if (!ladder.step())
        {
            antek.climb((ladder.tileY - 1).htiles())
                .then(antek.idle);
        }
        else if (ladder.tileY - ladder.heightTiles < antek.tileY - 2)
        {
            climb().then(build);
        }
    }
    
    private function climb()
    {
        return antek.climbBy(-2.htiles());
    }
}