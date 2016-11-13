package engine;

class SubSprite
{
    public var shiftX(default, set) : Float;
    public var shiftY(default, set) : Float;
    public var shiftZ(default, set) : Int;
    public var visible(get, set)    : Bool;
    public var sprite               : FlxSprite;
    public var parent               : ASprite;

    public function new(parent: ASprite, sprite: FlxSprite, shiftX: Float, shiftY: Float, shiftZ: Int)
    {
        this.parent = parent;
        this.sprite = sprite;
        this.shiftX = shiftX;
        this.shiftY = shiftY;
        this.shiftZ = shiftZ;
    }

    private inline function set_shiftX(val)
    {
        this.shiftX = val;
        parent.updateSubSpritesX(parent.position.x);
        return this.shiftX;
    }

    private inline function set_shiftY(val)
    {
        this.shiftY = val;
        parent.updateSubSpritesY(parent.position.y);
        return this.shiftY;
    }

    private inline function set_shiftZ(val)
    {
        this.shiftZ = val;
        parent.updateSubSpritesZ();
        return this.shiftZ;
    }

    private inline function get_visible()    return this.sprite.visible;
    private inline function set_visible(val) return this.sprite.visible = val;
}