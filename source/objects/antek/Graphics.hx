package objects.antek;

class Graphics
{
    public static function initGraphics(a: Antek, type: String)
    {
        a.subSprite.sprite.frames = Textures.characters;
        a.idleAnim  = addAnim(a, type, "idle");
        a.buildAnim = addAnim(a, type, "build");
        a.walkAnim  = addAnim(a, type, "walk");
        a.climbAnim = addAnim(a, type, "climb");
        
        recalculateAnimationsSpeed(a);
        a.addSubSprite(a.subSprite);
    }

    private static function addAnim(a: Antek, type: String, name: String) : FlxAnimation
    {
        a.subSprite.sprite.animation.addByPrefix(name, type + "/" + name + "/");
        return a.subSprite.sprite.animation.getByName(name);
    }
    
    private static function recalculateAnimationsSpeed(a: Antek)
    {
        a.walkAnim.frameRate  = Std.int(a.HorizontalSpeed * Antek.WalkAnimSpeed);
        a.buildAnim.frameRate = Std.int(a.buildAnim.numFrames * a.BuildsPerSecond);
    }
    
    public static function turnLeft(a: Antek)  { a.subSprite.sprite.flipX = true;  return a; }
    public static function turnRight(a: Antek) { a.subSprite.sprite.flipX = false; return a; }
}