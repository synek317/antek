package;

class MenuState extends FlxState
{
    override public function create():Void
    {
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        FlxG.switchState(new PlayState());
    }
}
