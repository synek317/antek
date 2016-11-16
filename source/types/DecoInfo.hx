package types;

typedef DecoInfo =
{
    name:       String,
	creator:    DecoInfo -> TiledObject -> Void,
    z:          Int,
    frameRate:  Int,
    animChance: Float
}