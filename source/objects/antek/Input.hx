package objects.antek;

class Input
{
    public static function initInput(a: Antek)
    {
        flixel.input.mouse.FlxMouseEventManager.add(
            a.subSprite.sprite,
            onMouseDown, onMouseUp, onMouseOver, onMouseOut,
            true,
            true
        );
    }

    private static function onMouseDown(_: FlxObject)
    {
    }

    private static function onMouseUp(_: FlxObject)
    {
    }

    private static function onMouseOver(_: FlxObject)
    {
    }

    private static function onMouseOut(_: FlxObject)
    {
    }
}