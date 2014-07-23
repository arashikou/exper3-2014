package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;

class PuzzleState extends FlxSprite
{
  private var _outlet:Outlet;
  private var _cables:FlxTypedGroup<Cable>;

  static inline private var TEST_SPRITESHEET = "assets/images/TestCable.png";

  public function new(w:Int, h:Int)
  {
    super();
    makeGraphic(w, h, FlxColor.IVORY);
  }

  public function setOutlet(xPos:Int, yPos:Int)
  {
    _outlet = new Outlet(TEST_SPRITESHEET);
    _outlet.x = x + xPos * Constants.CELL_SIZE;
    _outlet.y = y + yPos * Constants.CELL_SIZE;
  }

  public function addCable(xPos:Int, yPos:Int, direction:Direction,
                           maxLength:Int, powered:Bool)
  {
    var cableBase = new CableSegment(TEST_SPRITESHEET);
    cableBase.x = x + xPos * Constants.CELL_SIZE;
    cableBase.y = y + yPos * Constants.CELL_SIZE;

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

    _cables.update();
    _outlet.update();

    if (_outlet.isPowered())
    {
      // Player wins!
      FlxG.switchState(new MenuState());
    }
  }

  override public function draw():Void
  {
    super.draw();
    _cables.draw();
    _outlet.draw();
  }
}