package objects.antek.states;
import objects.Antek;

class Walk
{
    public static function updateWalkState(a: Antek, elapsed: Float)
    {
        var destination = a.destinations.first(); 
        
        if (destination == null)
        {
            a.finishState();
        }
        else if (a.at(destination))
        {
            a.destinations.pop();
            a.moveToNextDestination();
        }
        else
        {
            a.stepTowards(destination, elapsed);
        }
    }
    
    public static function moveToX(a: Antek, newX: Float) : Antek
    {
        a.destinations.clear();
        a.destinations.push(new Point(newX, a.position.y));
        
        return walkToNextDestination(a);
    }
    
    public static function walkToNextDestination(a: Antek) : Antek
    {
        a.state = Antek.WALK;
        a.playWalkAnim();
        a.lookAt(a.destinations.first().x);
    
        return a;   
    }
    
    public static function moveToTileX(a: Antek, newX: Int) : Antek
    {
        return a.moveToX(Consts.TileWidth * newX + Consts.HalfTileWidth);
    }
    
    public static function teleportTo(a: Antek, ?newX: Int, ?newY: Int) : Antek
    {
        if (newX != null) a.position.x = newX;
        if (newY != null) a.position.y = newY;
        return a;
    }
    
    public static function stepTowards(a: Antek, p: Point, elapsed: Float)
    {
        if (a.position.x < p.x)      a.position.x = min(a.position.x + a.HorizontalSpeed * elapsed, p.x);
        else if (a.position.x > p.x) a.position.x = max(a.position.x - a.HorizontalSpeed * elapsed, p.x);
        
        if (a.position.y < p.y)      a.position.y = min(a.position.y + a.VerticalSpeed * elapsed, p.y);
        else if(a.position.y > p.y)  a.position.y = max(a.position.y - a.VerticalSpeed * elapsed, p.y);
    }
    
    public static function at(a: Antek, p: Point) : Bool
    {
        return p.x == a.position.x && p.y == a.position.y;
    }
}