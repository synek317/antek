package engine;

class ASprite implements IObject
{
    private var subSprites: List<SubSprite> = new List<SubSprite>();

    public var position               : Position;
    public var size                   : Size;
    public var objectType(get, never) : Int;   
    public var z(default, set)        : Int;
    public var alpha(default, set)    : Float;
    public var visible(default, set)  : Bool;

    public function new()
    {
        this.position            = new Position(0, 0, updateSubSpritesX, updateSubSpritesY);
        this.size                = new Size(0, 0);
        this.z                   = 0;
        this.alpha               = 1;
        this.visible             = true;
    }

    public function addSubSprite(subSprite: SubSprite): SubSprite
    {
        subSprite.sprite.x       = position.x + subSprite.shiftX;
        subSprite.sprite.y       = position.y + subSprite.shiftY;
        subSprite.sprite.ID      = this.z + subSprite.shiftZ;
        subSprite.sprite.alpha   = this.alpha;
        subSprite.sprite.visible = this.visible;

        this.subSprites.add(subSprite);

        subSprite.sprite.cameras = [FlxG.camera];
        PlayState.addChild(subSprite.sprite);
        return subSprite;
    }

    public function removeAllSubSprites()
    {
        for (subSprite in subSprites) PlayState.removeChild(subSprite.sprite);
        subSprites.clear();
    }
    
    public function updateSubSpritesX(_: Float)
    {
        for (subSprite in subSprites) subSprite.sprite.x = position.x + subSprite.shiftX;
    }

    public function updateSubSpritesY(_: Float)
    {
        for (subSprite in subSprites) subSprite.sprite.y = position.y + subSprite.shiftY;    
    }

    public function updateSubSpritesZ()
    {
        for (subSprite in subSprites) subSprite.sprite.ID = z + subSprite.shiftZ;
        PlayState.scheduleZReorder();
    }
    
    public inline function show()          { visible = true; }
    public inline function hide()          { visible = false; }
    public inline function toggleVisible() { visible = !visible; }

    private function set_z(newZ)
    {
        z = newZ;
        updateSubSpritesZ();
        return z;
    }

    private function set_alpha(newAlpha)
    {
        alpha = newAlpha;
        for (subSprite in subSprites) subSprite.sprite.alpha = newAlpha;
        return alpha;
    }

    private function set_visible(newVisible)
    {
        visible = newVisible;
        for (subSprite in subSprites) subSprite.sprite.visible = newVisible;
        return visible;
    }

    private function get_objectType() return 0;
}