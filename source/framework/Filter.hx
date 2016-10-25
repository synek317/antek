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
    private static var i = 0;
    private var ii =  0;
    
    public function new(filter: FlxFilterFrames, sprite: FlxSprite)
    {
        this.filter = filter;
        this.sprite = sprite;
        i = i + 1;
        ii = i;
    }

    public function attach()
    {
        trace("exec attach", ii);
        if(attached) return;
        trace("ATTACH", ii);
        
        attached  = true;
        orgFrames = sprite.frames;
        orgWidth  = sprite.width;
        orgHeight = sprite.height;

        orgOffset.copyFrom(sprite.offset);
        this.filter.applyToSprite(sprite, true);
    }

    public function dettach()
    {
        trace("exec dettach", ii);
        if(!attached) return;
        trace("DETTACH", ii);
        
        attached = false;
        
		sprite.setFrames(filter.sourceFrames, true);
		sprite.offset.copyFrom(orgOffset);
		sprite.setSize(orgWidth, orgHeight);
    }
}