package framework;

class Game
{
    private static var selected: ISelectable;

    public static function select(s: ISelectable)
    {
        if(isSelected(s)) return;

        deselect();
        selected = s;
        s.onSelected();
    }

    public static function deselect()
    {
        if(selected == null) return;

        selected.onDeselected();
        selected = null;
    }

    public static function switchSelect(s: ISelectable)
    {
        if(isSelected(s)) deselect();
        else select(s);
    }

    public static function isSelected(s: ISelectable) return selected == s;
}