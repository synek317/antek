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
        antek.moveTo(ladder.x.to_hcell() - 2, ladder.y.to_vcell())
            .then(antek.turnRight)
            .then(build);
    }
    
    public static function start(antek: Antek, tileX: Int, tileY: Int, height: Int)
    {
        var ladder = Ladder.create(tileX, tileY, height);

        new BuildLadder(antek, ladder).action();
    }
    
    private function buildLadder()
    {
        if (!ladder.step())
        {
            if(antek.tileY < ladder.tileY)
            {
                antek.climb((ladder.tileY - ladder.heightTiles).htiles())
                    .then(climbOnTop)
                    .then(stopBuilding);
            }
            else
            {
                stopBuilding();
            }
        }
        else if (ladder.tileY - ladder.heightTiles < antek.tileY - 2)
        {
            climbStep().then(build);
        }
    }
    

    private function build()        antek.build(buildLadder);
    private function climbStep()    return antek.climbBy(-2.htiles());
    private function climbOnTop()   antek.moveTo(antek.x.to_hcell()+2, antek.y.to_vcell());
    private function stopBuilding() { antek.busy = false; antek.idle(); }
}