package objects;

class InvalidLadder extends ASprite
{
    public function new()
    {
        super();

        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createTop(),
           -LevelMap.TileWidth / 2.0,
           -LevelMap.TileHeight,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createBroken(),
           -LevelMap.TileWidth / 2.0,
           0,
           0
        ));
        addSubSprite(new SubSprite(
           this,
           LadderSpriteFactory.createBot(),
           -LevelMap.TileWidth / 2.0,
           LevelMap.TileHeight,
           0
        ));

        this.alpha = 0.33;
    }
}