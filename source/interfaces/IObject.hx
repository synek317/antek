package interfaces;

interface IObject
{
    var position               : Position;
    var size                   : Size;
    var objectType(get, never) : Int;
}