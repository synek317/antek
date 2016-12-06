package objects;

class InvalidLadder extends ASprite
{
    public function new()
    {
        super();

        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createTop(),
           0,
           -Consts.TileHeight,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createBroken(),
           0,
           0,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createBot(),
           0,
           Consts.TileHeight,
           0
        ));

        this.alpha = 0.33;
    }
}