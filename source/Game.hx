package;

class Game
{
    public static var state           : GameState = GameState.Idle;
    public static var selected        : Antek;
    public static var ladder          : Ladder;
    public static var invalidLadder   : InvalidLadder;
    public static var maxLadderHeight : Int       = 10;
    public static var mouseTileX      : Int;
    public static var mouseTileY      : Int;

    public static function update()
    {
        switch(state)
        {
            case GameState.Idle:        game.states.Idle.update();
            case GameState.BuildLadder: game.states.BuildLadder.update();
            default:                    return;
        }
    }

    public static inline function buildLadder() game.states.BuildLadder.enter();
}