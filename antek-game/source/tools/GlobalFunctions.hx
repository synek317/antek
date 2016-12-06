package tools;

class GlobalFunctions
{
    private static var random = new FlxRandom();  

    public static inline function random_int(min: Int, max: Int) return random.int(min, max);
    public static inline function mini(a: Int, b: Int)           return if (a < b) { a; } else { b; }
    public static inline function maxi(a: Int, b: Int)           return if (a > b) { a; } else { b; }
    public static inline function min(a: Float, b: Float)        return if (a < b) { a; } else { b; }
    public static inline function max(a: Float, b: Float)        return if (a > b) { a; } else { b; }
}