package objects.antek;
import flash.geom.Point;
import objects.Antek;

class Movement
{
    public static function moveToCell(a: Antek, x: Int, y: Int) : Antek
    {
        if (a.position.cellX != x) return a.moveToX(x.hcell());
        if (a.position.cellY != y) return a.climb(y.vcell());
        
        return a;
    }
    
    public static function moveToNextDestination(a: Antek) : Antek
    {
        var next = a.destinations.first();
        
        if (next == null) return a;
        
        if (a.position.cellX != next.x.to_hcell()) return a.walkToNextDestination();
        if (a.position.cellY != next.y.to_vcell()) return a.climbToNextDestination();
        
        return a;
    }
    
    public static function moveByPath(a: Antek, path: List<AStarNode>) : Antek
    {
        if (path.isEmpty()) return a;
        
        a.destinations.clear();
        
        for (node in path)
        {
            a.destinations.add(new Point(node.x.hcell(), node.y.vcell()));
        }
        
        return moveToNextDestination(a);
    }

    public static function moveTo(a: Antek, cellX: Int, cellY: Int)
    {
        return a.moveByPath(AStar.obj.findPath(a.position, cellX, cellY));
    }
}