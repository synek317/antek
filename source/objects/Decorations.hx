package objects;

class Decorations
{
    public static function init(tiledMap: TiledMap)
    {
        for (layer in tiledMap.layers)
		{
            if (layer.type == TiledLayerType.OBJECT)
            {
                createLayer(tiledMap, cast(layer, TiledObjectLayer));
            }
        }
    }

    private static function createLayer(tiledMap: TiledMap, layer: TiledObjectLayer)
    {
        var gidShift = tiledMap.getTileSet("decorations").firstGID;

        for(o in layer.objects)
        {
            createDecoration(o.gid - gidShift, o);
        }
    }

    private static function createDecoration(id: Int, obj: TiledObject)
    {
        switch(id)
        {
            case Consts.DecoBird:        DecoBird.create(o);
            case Consts.DecoBush1:       DecoStatic.create("bush_1", o);
            case Consts.DecoBush2:       DecoStatic.create("bush_2", o);
            case Consts.DecoBushFlowers: DecoStatic.create("bush_flowers", o);
            case Consts.DecoBushRabbit:  DecoAnimated.create("bush_anima", o);
            case Consts.DecoRabbit:      DecoStatic.create("rabbit", o);
            case Consts.DecoRock1:       DecoStatic.create("rocks_1", o);
            case Consts.DecoRock2:       DecoStatic.create("rocks_2", o);
            case Consts.DecoRock3:       DecoStatic.create("rocks_3", o);
            case Consts.DecoRock4:       DecoStatic.create("rocks_4", o);
            case Consts.DecoShroom:      DecoStatic.create("deco_1", o);
        }
    }
}