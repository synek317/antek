package objects.antek;

class Selectable
{
    public static function setSelected(a: Antek, selected: Bool): Bool
    {
        a._selected = a.starSprite.sprite.visible = selected;
        
        if(selected && Game.selected != null) Game.selected.selected = false;
        
        return a.selected;
    }
}