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
             //clear highest bits cause tiled use bit 32, 31 and 30 to describe flips (horizontal, vertical, diagonal)
            var originalGid = haxe.Int64.parseString(o.xmlData.att.resolve("gid"));
            var gid = originalGid.low & 0x3FFFFFFF;
            var flipX = (originalGid.low & 0x80000000) != 0;
            var flipY = (originalGid.low & 0x40000000) != 0;
            
            createDecoration(gid - gidShift, o, flipX, flipY);
        }
    }

    private static function createDecoration(id: Int, obj: TiledObject, flipX: Bool, flipY: Bool)
    {
        var deco = Consts.Deco[id];
        
        if (deco == null) { trace('Could not create decoration with id $id'); return; }
        
        deco.creator(deco, obj, flipX, flipY);
    }
}