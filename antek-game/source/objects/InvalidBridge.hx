package objects;

class InvalidBridge extends ASprite
{
    public function new()
    {
        super();

        /*addSubSprite(new SubSprite(
           this,
           BridgeSpriteFactory.createLeft(),
           -Consts.TileWidth,
           0,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           BridgeSpriteFactory.createBroken(),
           0,
           0,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           BridgeSpriteFactory.createBot(),
           Consts.TileWidth,
           0,
           0
        ));*/

        this.alpha = 0.33;
    }
}