package engine;

class SubSprite
{
    public var shiftX: Float;     
    public var shiftY: Float;     
    public var shiftZ: Int;       
    public var sprite: FlxSprite; 

    public function new(sprite: FlxSprite, shiftX: Float, shiftY: Float, shiftZ: Int)
    {
        this.sprite = sprite;
        this.shiftX = shiftX;
        this.shiftY = shiftY;
        this.shiftZ = shiftZ;
    }
}