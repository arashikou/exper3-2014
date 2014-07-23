package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;

class PuzzleState extends FlxState
{
  private var _bg:PuzzleBG;
  private var _outlet:Outlet;
  private var _cables:FlxTypedGroup<Cable>;

  static inline private var TEST_SPRITESHEET = "assets/images/TestCable.png";

  public function new(w:Int, h:Int)
  {
    super();

    _bg = new PuzzleBG(w, h, FlxColor.IVORY);
    _bg.x = (FlxG.width - _bg.width) / 2;
    _bg.y = (FlxG.height - _bg.height) / 2;
    add(_bg);

    _cables = new FlxTypedGroup<Cable>();
    add(_cables);
  }

  public function setOutlet(xPos:Int, yPos:Int)
  {
    _outlet = new Outlet(TEST_SPRITESHEET);
    _outlet.x = _bg.x + xPos * Constants.CELL_SIZE;
    _outlet.y = _bg.y + yPos * Constants.CELL_SIZE;
    add(_outlet);
  }

  public function addCable(xPos:Int, yPos:Int, direction:Direction,
                           maxLength:Int, powered:Bool)
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
}