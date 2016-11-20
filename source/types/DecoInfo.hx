package types;

typedef DecoInfo =
{
    name:       String,
	creator:    DecoInfo -> TiledObject -> Bool -> Bool -> Void,
    z:          Int,
    frameRate:  Int,
    animChance: Float,
    speed:      Int
}