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
        if (Game.state != GameState.Idle) return;
        
        a.selected = !a.selected;
        Game.selected = a.selected ? a : null;
    }

    private static function onMouseOver(a: Antek, _: FlxObject)
    {
        if (Game.state != GameState.Idle) return;
        
        Textures.getGlowedAntek(a.type, a.subSprite.sprite).applyToSprite(a.subSprite.sprite, true);
        a.isMouseOver = true;
    }

    private static function onMouseOut(a: Antek, _: FlxObject)
    {
        if (!a.isMouseOver) return;
        
        a.subSprite.sprite.setFrames(a.orgFrames, true);
        a.isMouseOver = false;
    }
}