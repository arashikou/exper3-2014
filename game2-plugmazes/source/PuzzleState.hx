package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

import haxe.ds.Vector;

class PuzzleState extends FlxState
{
  private var _puzzleNumber:Int;
  private var _width:Int;
  private var _height:Int;
  private var _bg:PuzzleBG;
  private var _outlet:Outlet;
  private var _grid:Vector<Vector<ConductiveSprite>>;
  private var _mouse:MouseAttendant;

  public function new(puzzleNumber:Int)
  {
    super();
    _puzzleNumber = puzzleNumber;
  }

  override public function create():Void
  {
    super.create();
    PuzzleParser.parse(_puzzleNumber, this);
    BackgroundMusic.play();
  }

  public function setDimensions(w:Int, h:Int):Void
  {
    _width = w;
    _height = h;

    _bg = new PuzzleBG(_width * Constants.CELL_SIZE,
                       _height * Constants.CELL_SIZE,
                       FlxColor.IVORY);
    _bg.x = (FlxG.width - _bg.width) / 2;
    _bg.y = (FlxG.height - _bg.height) / 2;
    add(_bg);

    _grid = new Vector<Vector<ConductiveSprite>>(_width);
    for (index in 0..._width)
    {
      _grid[index] = new Vector<ConductiveSprite>(_height);
    }
    _mouse = new MouseAttendant(_grid);
  }

  public function setOutlet(x:Int, y:Int):Void
  {
    _outlet = new Outlet(Constants.TEST_SPRITESHEET);
    _outlet.x = _bg.x + x * Constants.CELL_SIZE;
    _outlet.y = _bg.y + y * Constants.CELL_SIZE;
    _grid[x][y] = _outlet;
  }

  public function addCable(x:Int, y:Int, direction:Direction,
                           maxLength:Int, powered:Bool):Void
  {
    var cableBase = new CableSegment(Constants.TEST_SPRITESHEET, null, maxLength);
    cableBase.x = _bg.x + x * Constants.CELL_SIZE;
    cableBase.y = _bg.y + y * Constants.CELL_SIZE;
    _grid[x][y] = cableBase;

    var cablePlug = new CableSegment(Constants.TEST_SPRITESHEET, cableBase);
    var offset = direction.offset;
    cablePlug.x = cableBase.x + offset.x * Constants.CELL_SIZE;
    cablePlug.y = cableBase.y + offset.y * Constants.CELL_SIZE;
    _grid[Std.int(x + offset.x)][Std.int(y + offset.y)] = cablePlug;

    if (powered)
    {
      cableBase.connectTo(new PowerSource());
    }
  }

  override public function update():Void
  {
    super.update();

    _mouse.update(_bg.x, _bg.y);

    // Exfoliate. i.e. Remove dead cells.
    for (x in 0..._grid.length)
    {
      var column = _grid[x];
      for (y in 0...column.length)
      {
        var cell = column[y];
        if (cell != null && !cell.alive)
          _grid[x][y] = null;
      }
    }

    if (_outlet.isPowered())
    {
      // Player wins!
      FlxG.switchState(new MenuState());
    }
  }

  override public function draw():Void
  {
    super.draw();

    for (column in _grid)
      for (cell in column)
        if (cell != null)
          cell.draw();
  }
}

private class MouseAttendant
{
  private var _grid:Vector<Vector<ConductiveSprite>>;
  private var _segmentInHand:CableSegment;

  public function new(grid:Vector<Vector<ConductiveSprite>>)
  {
    _grid = grid;
    FlxG.watch.add(this, "_segmentInHand", "Segment");
  }

  public function update(offsetX:Float, offsetY:Float):Void
  {
    var x = Std.int((FlxG.mouse.x - offsetX) / Constants.CELL_SIZE);
    var y = Std.int((FlxG.mouse.y - offsetY) / Constants.CELL_SIZE);
    if (x < 0 || x >= _grid.length || y < 0 || y >= _grid[0].length) return;

    if (FlxG.mouse.justPressed)
    {
      var target = _grid[x][y];
      if (target != null)
      {
        // It is apparently idiomatic Haxe to try the cast and catch the
        // exception rather than pre-checking.
        try
        {
          var segment = cast(target, CableSegment);
          if (segment.length() > 1)
          {
            // If the length is greater than 1, it is not a base and therefore
            // is safe to grab.
            _segmentInHand = segment;
            _segmentInHand.cutOffHere();
          }
        }
        catch (ignored:String) {}
      }
    }
    else if (FlxG.mouse.justReleased)
    {
      _segmentInHand = null;
    }
    else if (_segmentInHand != null)
    {
      if (_grid[x][y] != _segmentInHand)
      {
        // Disconnect
        var segmentX = Std.int((_segmentInHand.x - offsetX) / Constants.CELL_SIZE);
        var segmentY = Std.int((_segmentInHand.y - offsetY) / Constants.CELL_SIZE);
        connectAround(segmentX, segmentY, _segmentInHand, null);

        // Check if we are backtracking or growing
        if (_grid[x][y] == _segmentInHand.previous)
        {
          // Don't allow cutting off if we're down to the minimum length.
          if (_segmentInHand.length() > 2)
          {
            _segmentInHand = _segmentInHand.previous;
            _segmentInHand.cutOffHere();
          }
        }
        else if (_segmentInHand.lengthRemaining() > 0)
        {
          // Prevent adding in non-adjacent squares;
          var diff = Math.abs(x - segmentX) + Math.abs(y - segmentY);
          if (diff == 1)
          {
            // Add a new segment
            _segmentInHand = new CableSegment(Constants.TEST_SPRITESHEET, _segmentInHand);
            _segmentInHand.x = offsetX + x * Constants.CELL_SIZE;
            _segmentInHand.y = offsetY + y * Constants.CELL_SIZE;
            _grid[x][y] = _segmentInHand;
          }
        }

        // Reconnect
        segmentX = Std.int((_segmentInHand.x - offsetX) / Constants.CELL_SIZE);
        segmentY = Std.int((_segmentInHand.y - offsetY) / Constants.CELL_SIZE);
        connectAround(segmentX, segmentY, _segmentInHand, _segmentInHand);
      }
    }
  }

  private function connectAround(x:Int, y:Int, who:CableSegment, what:Powerable)
  {
    var targets = [];
    if (x - 1 >= 0)
      targets.push(_grid[x - 1][y]);
    if (x + 1 < _grid.length)
      targets.push(_grid[x + 1][y]);
    if (y - 1 >= 0)
      targets.push(_grid[x][y - 1]);
    if (y + 1 < _grid[x].length)
      targets.push(_grid[x][y + 1]);

    for (target in targets)
    {
      if (target != null)
      {
        var isDescendant =
          try
          {
            var segment = cast(target, CableSegment);
            segment.inDescendants(who);
          }
          catch (error:String)
          {
            false;
          }
       if (!isDescendant)
        target.connectTo(what);
      }
    }
  }
}
