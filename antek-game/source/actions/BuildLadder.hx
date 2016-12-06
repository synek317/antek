package actions;

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
        antek.busy = true;
        antek.moveTo(ladder.position.cellX - 2, ladder.position.cellY)
            .then(antek.turnRight)
            .then(build);
    }
    
    public static function start(antek: Antek, pos: Position, height: Int)
    {
        var ladder = Ladder.createReal(pos, height);

        new BuildLadder(antek, ladder).action();
    }
    
    private function buildLadder()
    {
        if (!ladder.step())
        {
            if(antek.position.tileY < ladder.position.tileY)
            {
                antek.climb((ladder.position.tileY - ladder.currentHeightInTiles).htiles())
                    .then(moveRight)
                    .then(stopBuilding);
            }
            else
            {
                stopBuilding();
            }
        }
        else if (ladder.position.tileY - ladder.currentHeightInTiles < antek.position.tileY - 2)
        {
            climbStep().then(build);
        }
    }
    

    private function build()        antek.build(buildLadder);
    private function climbStep()    return antek.climbBy(-2.htiles());
    private function moveRight()   antek.moveTo(antek.position.cellX + 2, antek.position.cellY);
    private function stopBuilding() { antek.busy = false; antek.idle(); }
}