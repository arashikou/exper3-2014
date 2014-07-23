package;

class Outlet extends ConductiveSprite
{
  public function new(spriteSheet:String)
  {
    super();
    loadGraphic(spriteSheet, true, Constants.CELL_SIZE, Constants.CELL_SIZE);
    animation.add("default", [14]);
    animation.play("default");
  }
}