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
        antek.moveTo(350)
        .then(function() {
            antek.turnRight();
            antek.build(function() { 
                if (!ladder.step())
                {
                    antek.idle();
                }
            });
        });
    }
}