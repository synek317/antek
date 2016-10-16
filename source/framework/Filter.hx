package framework;

class Filter
{
    private var filter:    FlxFilterFrames;
    private var sprite:    FlxSprite;
    private var orgFrames: FlxFramesCollection;
    private var orgWidth:  Float;
    private var orgHeight: Float;
    private var orgOffset = new FlxPoint();
    private var attached  = false;

    public function new(filter: FlxFilterFrames, sprite: FlxSprite)
    {
        this.filter = filter;
        this.sprite = sprite;
    }

    public function attach()
    {
        if(attached) return;

        attached  = true;
        orgFrames = sprite.frames;
        orgWidth  = sprite.width;
        orgHeight = sprite.height;

        orgOffset.copyFrom(sprite.offset);
        this.filter.applyToSprite(sprite, true, true);
    }

    public function dettach()
    {
        if(!attached) return;

        attached = false;

		sprite.setFrames(orgFrames, true);
		sprite.offset.copyFrom(orgOffset);
		sprite.setSize(orgWidth, orgHeight);
    }
}