package objects;

class InvalidLadder extends ASprite
{
    public function new()
    {
        super();

        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createTop(),
           -Consts.TileWidth / 2.0,
           -Consts.TileHeight,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createBroken(),
           -Consts.TileWidth / 2.0,
           0,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createBot(),
           -Consts.TileWidth / 2.0,
           Consts.TileHeight,
           0
        ));

        this.alpha = 0.33;
    }
}