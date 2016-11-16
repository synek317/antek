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
        var deco = Consts.Deco[id];
        
        if (deco == null) { trace('Could not create decoration with id $id'); return; }
        
        deco.creator(deco, obj);
    }
}