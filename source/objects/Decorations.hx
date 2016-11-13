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
            case Consts.DecoBird:        DecoBird.create("bird", obj);
            case Consts.DecoBush1:       DecoStatic.create("bush1", obj);
            case Consts.DecoBush2:       DecoStatic.create("bush2", obj);
            case Consts.DecoBushFlowers: DecoStatic.create("bush_flowers", obj);
            case Consts.DecoBushRabbit:  DecoAnim.create("bush_rabbit", obj);
            case Consts.DecoRabbit:      DecoStatic.create("rabbit", obj);
            case Consts.DecoRock1:       DecoStatic.create("rocks1", obj);
            case Consts.DecoRock2:       DecoStatic.create("rocks2", obj);
            case Consts.DecoRock3:       DecoStatic.create("rocks3", obj);
            case Consts.DecoRock4:       DecoStatic.create("rocks4", obj);
            case Consts.DecoShroom:      DecoStatic.create("shroom", obj);
        }
    }
}