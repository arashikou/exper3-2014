package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;

import haxe.ds.Vector;

class PuzzleState extends FlxState
{
  private var _puzzleNumber:Int;
  private var _width:Int;
  private var _height:Int;
  private var _bg:PuzzleBG;
  private var _outlet:Outlet;
  private var _grid:Vector<Vector<ConductiveSprite>>;

  static inline private var TEST_SPRITESHEET = "assets/images/TestCable.png";

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
  }

  public function setOutlet(x:Int, y:Int):Void
  {
    _outlet = new Outlet(TEST_SPRITESHEET);
    _outlet.x = _bg.x + x * Constants.CELL_SIZE;
    _outlet.y = _bg.y + y * Constants.CELL_SIZE;
    _grid[x][y] = _outlet;
  }

  public function addCable(x:Int, y:Int, direction:Direction,
                           maxLength:Int, powered:Bool):Void
  {
    var cableBase = new CableSegment(TEST_SPRITESHEET, null, maxLength);
    cableBase.x = _bg.x + x * Constants.CELL_SIZE;
    cableBase.y = _bg.y + y * Constants.CELL_SIZE;
    _grid[x][y] = cableBase;

    var cablePlug = new CableSegment(TEST_SPRITESHEET, cableBase);
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
