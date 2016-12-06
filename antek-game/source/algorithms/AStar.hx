package algorithms;

class AStar
{
    private static var EmptyPath = new List<AStarNode>();

    public static var obj = new AStar();

    #if flash
    private static var xplus = [ -1, 1,  0, 0];
    private static var yplus = [ 0,  0, -1, 1];
    #else
    private static var xplus = Vector.fromArrayCopy([ -1, 1,  0, 0]);
    private static var yplus = Vector.fromArrayCopy([ 0,  0, -1, 1]);
    #end

    private var openedList       = new BinaryHeap<AStarNode>(compareNodes);
    private var closedSet       : IntMap<Bool>;
    private var openedSet       : IntMap<AStarNode>;
    private var node            : AStarNode;
    private var neighboor       : AStarNode;
    private var openedNeighboor : AStarNode;
    private var x               : Int;
    private var y               : Int;

    public function new() {}

    public function findPath(from: Position, toX: Int, toY: Int) : List<AStarNode>
    {
        if(isAchievable(from, toX, toY)) return createPath(); else return EmptyPath;
    }

    public function isAchievable(from: Position, toX: Int, toY: Int) : Bool
    {
        init();
        open(new AStarNode(from.cellX, from.cellY, null));

        while (!openedList.isEmpty())
        {
            pop();
            for (i in 0...4)
            {
                if (!generateNeighboor(i) || isCLosed(neighboor)) continue;
                if (neighboor.x == toX && neighboor.y == toY)     return true;
                neighboor.costFromStart = node.costFromStart + 1;
                estimateNeighboorCost(toX, toY);

                checkIsNeighboorOpened();
                if (openedNeighboor != null && openedNeighboor.totalCost < neighboor.totalCost) continue;

                open(neighboor);
            }
            close(node);
        }

        return false;
    }

    private function createPath() : List<AStarNode>
    {
        var path = new List<AStarNode>();

        node = neighboor;
        neighboor = node.parent;
        path.push(node);

        if (neighboor.parent == null) return path;

        while(neighboor != null)
        {
            while (neighboor.parent != null && (node.x == neighboor.parent.x || node.y == neighboor.parent.y))
            {
                neighboor = neighboor.parent;
            }

            if (neighboor.parent == null) break;

            path.push(neighboor);
            node = neighboor;
            neighboor = neighboor.parent;

        }

        return path;
    }

    private inline function checkIsNeighboorOpened()
    {
        openedNeighboor = openedSet.get(neighboor.y * PathMap.width + neighboor.x);
    }

    private inline function estimateNeighboorCost(toX: Int, toY: Int)
    {
        neighboor.estimatedCostToGoal =
            (neighboor.x - toX).abs()
          + (neighboor.y - toY).abs();
    }

    private inline function generateNeighboor(i: Int): Bool
    {
        x = node.x + xplus[i];
        y = node.y + yplus[i];

        if (isValid(x, y))
        {
            neighboor = new AStarNode(x, y, node);
            return true;
        }

        return false;
    }

    private inline function isValid(x: Int, y: Int)
    {
        return x >= 0
            && y >= 0
            && x < PathMap.width
            && y < PathMap.height
            && PathMap.at(x, y) > 0;
    }

    private inline function open(n: AStarNode)
    {
        openedList.insert(n);
        openedSet.set(n.y * PathMap.width + n.x, n);
    }

    private inline function close(n: AStarNode)
    {
        closedSet.set(n.y * PathMap.width + n.x, true);
    }

    private inline function isOpened(n: AStarNode) return openedSet.exists(n.y * PathMap.width + n.x);
    private inline function isCLosed(n: AStarNode) return closedSet.exists(n.y * PathMap.width + n.x);

    private inline function pop()
    {
        node = openedList.pop();
        openedSet.remove(node.y * PathMap.width + node.x);
        closedSet.set(node.y * PathMap.width + node.x, true);
    }

    private inline function init()
    {
        this.openedList.clear();
        this.openedSet = new IntMap<AStarNode>();
        this.closedSet = new IntMap<Bool>();
    }

    private static function compareNodes(a: AStarNode, b: AStarNode) return a.totalCost - b.totalCost;
}