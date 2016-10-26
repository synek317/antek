package objects.antek.states;

class Idle
{
    public static function idle(a: Antek) : Antek
    {
        a.state = Antek.IDLE;
        a.subSprite.sprite.animation.play("idle");
        a.subSprite.shiftX = -30;
        a.subSprite.shiftY = -87;
        
        return a;
    }
}