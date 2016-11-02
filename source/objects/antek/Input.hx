package objects.antek;

class Input
{
    public static function initInput(a: Antek)
    {
        flixel.input.mouse.FlxMouseEventManager.add(
            a.subSprite.sprite,
            onMouseDown, a.onMouseUp, a.onMouseOver, a.onMouseOut,
            true,
            true
        );
    }

    private static function onMouseDown(_: FlxObject)
    {
    }

    public static function onMouseUp(a: Antek, o: FlxObject)
    {
        a.selected = !a.selected;
    }

    private static function onMouseOver(a: Antek, _: FlxObject)
    {
        Textures.getGlowedAntek(a.type, a.subSprite.sprite).applyToSprite(a.subSprite.sprite, true);
    }

    private static function onMouseOut(a: Antek, _: FlxObject)
    {
        a.subSprite.sprite.setFrames(a.orgFrames, true);
    }
}