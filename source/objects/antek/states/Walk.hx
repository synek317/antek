package objects.antek.states;

class Walk
{
    public static function updateWalkState(a: Antek, elapsed: Float)
    {
        var destination = a.destinations.first(); 
        
        if (destination == null)    a.finishState();
        else if (a.at(destination)) a.destinations.pop();
        else                        a.stepTowards(destination, elapsed);
    }
    
    public static function moveToX(a: Antek, newX: Float) : Antek
    {
        a.state = Antek.WALK;
        a.subSprite.sprite.flipX = newX < a.x;
        
        a.destinations.clear();
        a.destinations.push(new Point(newX, a.y));
        a.subSprite.sprite.animation.play("walk");
        a.subSprite.shiftX = -30;
        a.subSprite.shiftY = -87;
        
        return a;
    }
    
    public static function moveToTileX(a: Antek, newX: Int) : Antek
    {
        return a.moveToX(LevelMap.TileWidth * newX + LevelMap.HalfTileWidth);
    }
    
    public static function teleportTo(a: Antek, ?newX: Float, ?newY: Float) : Antek
    {
        if (newX != null) a.x = newX;
        if (newY != null) a.y = newY;
        return a;
    }
    
    public static function stepTowards(a: Antek, p: Point, elapsed: Float)
    {
        if (a.x < p.x)      a.x = Math.min(a.x + a.HorizontalSpeed * elapsed, p.x);
        else if (a.x > p.x) a.x = Math.max(a.x - a.HorizontalSpeed * elapsed, p.x);
        
        if (a.y < p.y)     a.y = Math.min(a.y + a.VerticalSpeed * elapsed, p.y);
        else if(a.y > p.y) a.y = Math.max(a.y - a.VerticalSpeed * elapsed, p.y);
    }
    
    public static function at(a: Antek, p: Point) : Bool
    {
        return p.x == a.x && p.y == a.y;
    }
}