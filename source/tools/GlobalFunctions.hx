package tools;

class GlobalFunctions
{
    private static var random = new FlxRandom();  

    public static inline function random_int(min: Int, max: Int) return random.int(min, max);
}