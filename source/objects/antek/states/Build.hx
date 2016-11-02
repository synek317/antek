package objects.antek.states;
import objects.Antek;

class Build
{
    public static function updateBuildState(a: Antek, elapsed: Float)
    {
        if (a.onBuild == null) return;
        
        a.buildTime += elapsed;
        
        var hits = Math.floor(a.buildTime * a.BuildsPerSecond);
        if (hits > 0)
        {
            a.buildTime -= hits / a.BuildsPerSecond;
            for (i in 0...hits)
            {
                a.onBuild();
                FlxG.sound.play(AssetPaths.build__wav, 0.01);
            }
        }
    }
    
    public static function build(a: Antek, ?onBuild: Void -> Void) : Antek
    {
        a.onBuild = onBuild;
        a.state     = Antek.BUILD;
        a.buildTime = (a.buildAnim.numFrames / 2 - 2) / a.buildAnim.frameRate;
        
        a.playBuildAnim();
        
        return a;
    }
}