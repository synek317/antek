package structures;

class BinaryHeap<T>
{
    private var items            : Array<T>;
    private var comparer         : T -> T -> Int;
    private var lastItemIndex    : Int;
    private var currIndex        : Int;
    private var parentIndex      : Int;
    private var smallerChildIndex: Int;
    private var tmp              : T;
    private var result           : T;
    
    public function new(comparer: T -> T -> Int)
    {
        this.items         = new Array<T>();
        this.comparer      = comparer;
        this.lastItemIndex = 0;
    }
    
    public function insert(item: T)
    {
        if (lastItemIndex == 0)
        {
            items[1] = item;
            lastItemIndex = 1;
        }
        else
        {
            ++lastItemIndex;
            items[lastItemIndex] = item;
            
            currIndex = lastItemIndex;
            parentIndex = currIndex >> 1;
            
            while (currIndex > 1 && isSmaller(currIndex, parentIndex))
            {
                swap(currIndex, parentIndex);
                currIndex = parentIndex;
                parentIndex = currIndex >> 1;
            }
        }
    }
    
    public function pop(): T
    {
        if (lastItemIndex == 1)
        {
            lastItemIndex = 0;
            result = items[1];
            items[1] = null;
            return result;
        }
        
        result = items[1];
        items[1] = items[lastItemIndex];
        items[lastItemIndex] = null;
        --lastItemIndex;
        
        currIndex = 1;
        while (isBiggerThanChildren())
        {
            swap(currIndex, smallerChildIndex);
            currIndex = smallerChildIndex;
        }
        
        return result;
    }
    
    public inline function isEmpty() return lastItemIndex == 0;
    
    private inline function isBiggerThanChildren()
    {
        smallerChildIndex = currIndex << 1;
        
        if (items[smallerChildIndex] == null) return false;
        
        if (isBigger(currIndex, smallerChildIndex))
        {
            if (items[smallerChildIndex + 1] == null || isSmaller(smallerChildIndex, smallerChildIndex + 1)) return true;
            ++smallerChildIndex;
            return true;
        }
        
        if (items[smallerChildIndex + 1] == null || isBigger(smallerChildIndex + 1, currIndex)) return false;
        
        ++smallerChildIndex;
        return true;
    }
    
    private inline function isSmaller(a: Int, b: Int) return comparer(items[a], items[b]) < 0;
    private inline function isBigger(a: Int, b: Int) return comparer(items[a], items[b]) > 0;
    
    private inline function swap(a: Int, b: Int)
    {
        tmp = items[a];
        items[a] = items[b];
        items[b] = tmp;
    }
}