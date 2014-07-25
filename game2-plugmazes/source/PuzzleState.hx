package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;

class PuzzleState extends FlxState
{
  private var _puzzleNumber:Int;
  private var _width:Int;
  private var _height:Int;
  private var _bg:PuzzleBG;
  private var _outlet:Outlet;
  private var _cables:FlxTypedGroup<Cable>;

  static inline private var TEST_SPRITESHEET = "assets/images/TestCable.png";

  public function new(puzzleNumber:Int)
  {
    super();
    _puzzleNumber = puzzleNumber;
  }

  override public function create():Void
  {
    super.create();

    _cables = new FlxTypedGroup<Cable>();

    PuzzleParser.parse(_puzzleNumber, this);

    add(_cables);

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
  }

  public function setOutlet(xPos:Int, yPos:Int):Void
  {
    _outlet = new Outlet(TEST_SPRITESHEET);
    _outlet.x = _bg.x + xPos * Constants.CELL_SIZE;
    _outlet.y = _bg.y + yPos * Constants.CELL_SIZE;
    add(_outlet);
  }

  public function addCable(xPos:Int, yPos:Int, direction:Direction,
                           maxLength:Int, powered:Bool):Void
  {
    var cableBase = new CableSegment(TEST_SPRITESHEET);
    cableBase.x = _bg.x + xPos * Constants.CELL_SIZE;
    cableBase.y = _bg.y + yPos * Constants.CELL_SIZE;

    var cablePlug = new CableSegment(TEST_SPRITESHEET);
    var offset = direction.offset;
    cablePlug.x = cableBase.x + offset.x * Constants.CELL_SIZE;
    cablePlug.y = cableBase.y + offset.y * Constants.CELL_SIZE;

    var startingSegments = [ cableBase, cablePlug ];
    var newCable = new Cable(maxLength, startingSegments);
    _cables.add(newCable);

    if (powered)
    {
      newCable.connectTo(new PowerSource());
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
    _cables.forEach(function(cable:Cable):Void
    {
      cable.updateAppearance();
    });

    super.draw();
  }
}