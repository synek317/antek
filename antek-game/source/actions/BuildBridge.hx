package actions;

class BuildBridge
{
    private var antek:  Antek;
    private var bridge: Bridge;
 
    public function new(antek: Antek, bridge: Bridge)
    {
        this.antek  = antek;
        this.bridge = bridge;
    }
    
    public function action()
    {
        trace(bridge.position.cellX - 1, bridge.position.cellY - Consts.CellsPerVTile + 2);
        antek.busy = true;
        antek.moveTo(bridge.position.cellX - 1, bridge.position.cellY - Consts.CellsPerVTile + 2)
            .then(build);
    }
    
    public static function start(antek: Antek, pos: Position, width: Int)
    {
        var bridge = Bridge.createReal(pos, width);

        new BuildBridge(antek, bridge).action();
    }
    
    private function buildBridge()
    {
        if (!bridge.step())
        {
            stopBuilding();
        }
    }
    

    private function build()        antek.build(buildBridge);
    private function stopBuilding() { antek.busy = false; antek.idle(); }
}