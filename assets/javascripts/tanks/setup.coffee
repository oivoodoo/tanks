Setup = =>
  # create an new instance of a PIXI stage
  @stage = new PIXI.Stage(0x97c56e, true)

  # create a renderer instance
  @renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight, null)

  # add the renderer view element to the dom
  @document.body.appendChild(renderer.view)
  @renderer.view.style.position = "absolute"
  @renderer.view.style.top      = "0px"
  @renderer.view.style.left     = "0px"

# setup global objects here and create the global variables like world or
# renderer
Setup()

# our entry point to the game
@game = new Game()
@game.initialize()

animate = =>
  requestAnimFrame(animate)
  @game.update()
  @game.draw()
  renderer.render(stage)

requestAnimFrame(animate)

@b2Vec2         = Box2D.Common.Math.b2Vec2,
@b2BodyDef      = Box2D.Dynamics.b2BodyDef,
@b2Body         = Box2D.Dynamics.b2Body,
@b2FixtureDef   = Box2D.Dynamics.b2FixtureDef,
@b2Fixture      = Box2D.Dynamics.b2Fixture,
@b2World        = Box2D.Dynamics.b2World,
@b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape,
@b2CircleShape  = Box2D.Collision.Shapes.b2CircleShape,
@b2Shape        = Box2D.Collision.Shapes.b2Shape,
@b2DebugDraw    = Box2D.Dynamics.b2DebugDraw;

