@Setup = =>
  # create an new instance of a PIXI stage
  @stage = new PIXI.Stage(0x97c56e, true)

  # create a renderer instance
  @renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight, null)

  # add the renderer view element to the dom
  @document.body.appendChild(renderer.view)
  @renderer.view.style.position = "absolute"
  @renderer.view.style.top      = "0px"
  @renderer.view.style.left     = "0px"

  @b2Vec2         = Box2D.Common.Math.b2Vec2
  @b2BodyDef      = Box2D.Dynamics.b2BodyDef
  @b2Body         = Box2D.Dynamics.b2Body
  @b2FixtureDef   = Box2D.Dynamics.b2FixtureDef
  @b2Fixture      = Box2D.Dynamics.b2Fixture
  @b2World        = Box2D.Dynamics.b2World
  @b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
  @b2CircleShape  = Box2D.Collision.Shapes.b2CircleShape
  @b2Shape        = Box2D.Collision.Shapes.b2Shape
  @b2DebugDraw    = Box2D.Dynamics.b2DebugDraw

  gravity = new b2Vec2(1, 0)
  doSleep = true
  @world = new b2World(gravity, doSleep)

  debugDraw = new b2DebugDraw()
  debugDraw.SetSprite(@renderer.view)
  debugDraw.SetDrawScale(1)
  debugDraw.SetFillAlpha(0.3)
  debugDraw.SetLineThickness(1.0)
  debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit)
  @world.SetDebugDraw(debugDraw)

  @bodyDef = new b2BodyDef
  @fixDef = new b2FixtureDef
  @bodyDef.type = b2Body.b2_staticBody
  @fixDef.shape = new b2PolygonShape

  # bottom border
  @fixDef.shape.SetAsEdge({x: 0, y: stage.hitArea.width}, {x: stage.hitArea.width, y: stage.hitArea.width})
  @world.CreateBody(bodyDef).CreateFixture(fixDef)

  # top border
  @fixDef.shape.SetAsEdge({x: 0, y: 0}, {x: stage.hitArea.width, y: 0})
  @world.CreateBody(bodyDef).CreateFixture(fixDef);

  # left border
  @fixDef.shape.SetAsEdge({x: 0, y: 0}, {x: 0, y: stage.hitArea.width})
  @world.CreateBody(bodyDef).CreateFixture(fixDef)

  # right border
  @fixDef.shape.SetAsEdge({x: stage.hitArea.width, y: stage.hitArea.width}, {x: stage.hitArea.width, y: 0})
  @world.CreateBody(bodyDef).CreateFixture(fixDef)
