package;

class Outlet extends ConductiveSprite
{
  public function new(spriteSheet:String, direction:Direction)
  {
    super();
    loadGraphic(spriteSheet, true, Constants.CELL_SIZE, Constants.CELL_SIZE);
    loadAnimations();
    animation.play(direction.shorthand);
  }

  private function loadAnimations():Void
  {
    animation.add("U", [16]);
    animation.add("D", [17]);
    animation.add("L", [18]);
    animation.add("R", [19]);
  }
}