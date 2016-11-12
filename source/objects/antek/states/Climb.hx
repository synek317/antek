package objects.antek.states;

class Climb
{
    public static function climb(a: Antek, newY: Float) : Antek
    {
        a.destinations.add(new Point(a.x, newY));
        
        return climbToNextDestination(a);
    }
    
    public static function climbToNextDestination(a: Antek) : Antek
    {
        a.state = Antek.WALK;
        a.playClimbAnim();
        
        return a;
    }
    
    public static inline function climbBy(a: Antek, deltaY: Float) return a.climb(a.y + deltaY);
}