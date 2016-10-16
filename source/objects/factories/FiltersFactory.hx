package objects.factories;

class FiltersFactory
{
    private static var antekGlow = new GlowFilter(0xEEEEEE, 0.95, 5, 5, 50, 1);

    private static var antekGlowFilters = new Map<String, FlxFilterFrames>();

    public static function createAntekGlowFilter(antekType: String, sprite: FlxSprite)
    {
        var filter = antekGlowFilters.get(antekType);

        if(filter == null)
        {
            filter = FlxFilterFrames.fromFrames(sprite.frames);

            filter.addFilter(antekGlow);
            antekGlowFilters.set(antekType, filter);
        }

        return new Filter(filter, sprite);
    }
}