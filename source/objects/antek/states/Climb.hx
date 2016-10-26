package objects.antek.states;

class Climb
{
    public static function climb(a: Antek, newY: Float) : Antek
    {
        a.destinations.add(new Point(a.x, newY));
        a.state = Antek.WALK;
        
        a.subSprite.sprite.animation.play("climb");
        a.subSprite.shiftX = -30;
        a.subSprite.shiftY = -87;
        
        return a;
    }
    
    public static inline function climbBy(a: Antek, deltaY: Float) : Antek { return a.climb(a.y + deltaY); }
}