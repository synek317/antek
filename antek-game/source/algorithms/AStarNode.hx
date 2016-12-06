package algorithms;

class AStarNode
{
    public var parent:               AStarNode;
    public var x:                    Int;
    public var y:                    Int;
    public var estimatedCostToGoal:  Int = 0; //h
    public var costFromStart:        Int = 0; //g
    public var totalCost(get, null): Int = 0; //f
    
    public function new(x: Int, y: Int, parent: AStarNode)
    {
        this.x      = x;
        this.y      = y;
        this.parent = parent;
    }
    
    public function toString() return '($x, $y)';
    
    private inline function get_totalCost() return costFromStart + estimatedCostToGoal;
}