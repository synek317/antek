package objects.antek;

class Graphics
{
    public static function initGraphics(a: Antek, type: String)
    {
        a.subSprite  = new SubSprite(a, new FlxSprite(), 0, 0, 0);
        a.starSprite = new SubSprite(a, Textures.others.createSprite("star"), -10, -115, 9999999);

        a.subSprite.sprite.frames = Textures.characters;
        a.idleAnim  = addAnim(a, type, "idle");
        a.buildAnim = addAnim(a, type, "build");
        a.walkAnim  = addAnim(a, type, "walk");
        a.climbAnim = addAnim(a, type, "climb");
        
        recalculateAnimationsSpeed(a);
        a.addSubSprite(a.subSprite);
        a.addSubSprite(a.starSprite);
        
        a.starSprite.visible = false;
        a.orgFrames = a.subSprite.sprite.frames;
        a.z = ZOrder.Antek;
        a.turnLeft();
    }
    
    public static inline function isTurnedLeft(a: Antek)  return a.subSprite.sprite.flipX;
    public static inline function isTurnedRight(a: Antek) return !a.isTurnedLeft();

    public static function turnLeft(a: Antek)  : Antek return a.turn(true);
    public static function turnRight(a: Antek) : Antek return a.turn(false);

    public static inline function lookAt(a: Antek, x: Float)
    {
        if(x < a.position.x) a.turnLeft(); else a.turnRight();
    }

    public static function playBuildAnim(a: Antek) a.playAnim("build", -30, -87, -30, -87);
    public static function playWalkAnim(a: Antek)  a.playAnim("walk",  -30, -87, -28, -87);
    public static function playClimbAnim(a: Antek) a.playAnim("climb", -29, -87, -30, -87);

    private static inline function playAnim(a: Antek, name: String, faceLeftShiftX : Int, faceLeftShiftY: Int, faceRightShiftX: Int, faceRightShiftY: Int)
    {
        a.subSprite.sprite.animation.play(name);

        a.faceLeftShiftX  = faceLeftShiftX;
        a.faceLeftShiftY  = faceLeftShiftY;
        a.faceRightShiftX = faceRightShiftX;
        a.faceRightShiftY = faceRightShiftY;
        
        a.updateShift();
    }
    
    private static inline function turn(a: Antek, left: Bool)
    {
        if(a.subSprite.sprite.flipX == left) return a;

        a.subSprite.sprite.flipX = left;
        a.updateShift();

        return a;
    }

    private static function updateShift(a: Antek)
    {
        if(a.isTurnedLeft())
        {
            a.subSprite.shiftX  = a.faceLeftShiftX;
            a.subSprite.shiftY  = a.faceLeftShiftY;
            a.starSprite.shiftX = -12;
        }
        else
        {
            a.subSprite.shiftX  = a.faceRightShiftX;
            a.subSprite.shiftY  = a.faceRightShiftY;
            a.starSprite.shiftX = -6;
        }
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
}