package tools;

class FlxMouseExtenders
{
    public static inline function justDblClicked(_: FlxMouse) return FlxG.mouse.justPressed && Mouse.isDblClick;
}