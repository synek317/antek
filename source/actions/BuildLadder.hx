package actions;
import objects.Antek;
import objects.Ladder;

/**
 * ...
 * @author ...
 */
class BuildLadder
{
    private var antek: Antek;
    private var ladder: Ladder;
 
    public function new(antek: Antek, ladder: Ladder)
    {
        this.antek  = antek;
        this.ladder = ladder;
    }
    
    public function action()
    {
        antek.moveToTileX(ladder.tileX - 1)
             .then(startBuilding);
    }
    
    private function startBuilding()
    {
        antek.turnRight();
        antek.build(buildLadder);
    }
    
    private function buildLadder()
    {
        if (!ladder.step())
        {
            antek.idle();
        }
    }
}