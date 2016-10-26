package objects.antek;

class States
{
    public static function updateState(a: Antek, elapsed:Float):Void 
    {
        switch(a.state)
        {
            case Antek.WALK:  a.updateWalkState(elapsed);
            case Antek.BUILD: a.updateBuildState(elapsed);
        }
    }
    
    public static function finishState(a: Antek)
    {
        var action = a.scheduledActions.pop();
        
        if (action != null) action();
        else                a.idle();
    }
    
    public static function then(a: Antek, action: Void -> Void) : Antek
    {
        a.scheduledActions.add(action);
        return a;
    }
}