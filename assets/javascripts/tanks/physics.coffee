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

@COLLISION_GROUP =
  none:    0x0000
  player:  0x0001
  static:  0x0001 << 1
  bullet:  0x0001 << 2
  enemy:   0x0001 << 3
  all:     0xFFFF

class @Physics
  @bodies: {}
  
  @createBorder: (point1, point2) ->
    bodyDef = new b2BodyDef
    bodyDef.type = b2Body.b2_staticBody

    fixDef = new b2FixtureDef
    fixDef.shape = new b2PolygonShape

    # bottom border
    fixDef.shape.SetAsEdge(point1, point2)
    world.CreateBody(bodyDef).CreateFixture(fixDef)

  @defaultPlayerProperties:
    linearDamping:    10
    angularDamping:   10
    density:          1.0
    friction:         0.4
    restitution:      0.2
    gravityScale:     1.0
    type:             b2Body.b2_dynamicBody

  @createPlayer: (width, height, x, y) ->
    options = @defaultPlayerProperties
    options = @defaultPlayerProperties
    fixDef = new b2FixtureDef
    fixDef.density             = options.density
    fixDef.friction            = options.friction
    fixDef.restitution         = options.restitution
    fixDef.filter.categoryBits = COLLISION_GROUP.player

    fixDef.shape = new b2PolygonShape()
    fixDef.shape.SetAsBox(width, height)

    bodyDef = new b2BodyDef()
    bodyDef.linearDamping  = options.linearDamping
    bodyDef.angularDamping = options.angularDamping
    bodyDef.type           = options.type
    bodyDef.fixedRotation  = true
    bodyDef.userData       = { id: "player-#{uuid.v4()}", type: 'player' }

    # we are using here cartesian coordinates the center half of the center
    # in the canvas container
    bodyDef.position.Set(x, y)

    body = world.CreateBody(bodyDef)
    body.CreateFixture(fixDef)

    body

  @defaultBulletProperties:
    linearDamping:    10
    angularDamping:   10
    density:          1.0
    friction:         0.4
    restitution:      0.2
    IsBullet:         true
    type:             b2Body.b2_dynamicBody

  @createBullet: (width, height, x, y) ->
    options = @defaultBulletProperties
    fixDef = new b2FixtureDef
    fixDef.density             = options.density
    fixDef.friction            = options.friction
    fixDef.restitution         = options.restitution
    fixDef.filter.categoryBits = COLLISION_GROUP.bullet
    fixDef.filter.maskBits     = COLLISION_GROUP.static | COLLISION_GROUP.enemy

    fixDef.shape = new b2PolygonShape()
    fixDef.shape.SetAsBox(width, height)

    bodyDef = new b2BodyDef()
    bodyDef.linearDamping   = options.linearDamping
    bodyDef.angularDamping  = options.angularDamping
    bodyDef.type            = options.type
    bodyDef.linearVelocity  = new b2Vec2(0, 0)
    bodyDef.active          = true
    bodyDef.allowSleep      = true
    bodyDef.angle           = 0
    bodyDef.angularVelocity = 0
    bodyDef.awake           = true
    bodyDef.bullet          = false
    bodyDef.fixedRotation   = true
    bodyDef.userData        = { id: "bullet-#{uuid.v4()}", type: "bullet" }

    bodyDef.position.Set(x, y)

    body = world.CreateBody(bodyDef)
    body.CreateFixture(fixDef)

    body

  @createBody: (entityDef) ->
    bodyDef = new b2BodyDef

    id = entityDef.id

    if entityDef.type is 'static'
      bodyDef.type = b2Body.b2_staticBody
    else
      bodyDef.type = b2Body.b2_dynamicBody

    bodyDef.position.x = entityDef.x
    bodyDef.position.y = entityDef.y

    if entityDef.userData
      bodyDef.userData = entityDef.userData
    if entityDef.angle
      bodyDef.angle = entityDef.angle
    if entityDef.damping
      bodyDef.linearDamping = entityDef.damping
    body = world.CreateBody(bodyDef)

    fixtureDefinition = new b2FixtureDef

    if entityDef.useBouncyFixture
      fixtureDefinition.density     = 1.0
      fixtureDefinition.friction    = 0
      fixtureDefinition.restitution = 1.0
    else
      fixtureDefinition.density     = 1.0
      fixtureDefinition.friction    = 0
      fixtureDefinition.restitution = 0

    if entityDef.categories && entityDef.categories.length
      fixtureDefinition.filter.categoryBits = COLLISION_GROUP.none
      for category in entityDef.categories
        fixtureDefinition.filter.categoryBits |= COLLISION_GROUP[category]
    else fixtureDefinition.filter.categoryBits = COLLISION_GROUP.all

    if entityDef.collidesWith && entityDef.collidesWith.length
      fixtureDefinition.filter.maskBits = COLLISION_GROUP.none
      for collide in entityDef.collidesWith
        fixtureDefinition.filter.maskBits |= COLLISION_GROUP[collide]
    else fixtureDefinition.filter.maskBits = COLLISION_GROUP.all

    if entityDef.radius
      fixtureDefinition.shape = new CircleShape(entityDef.radius)
      body.CreateFixture(fixtureDefinition)
    else if entityDef.polyPoints
      points = entityDef.polyPoints
      vecs = (new b2Vec2(point.x, point.y) for point in points)
      fixtureDefinition.shape = new b2PolygonShape
      fixtureDefinition.shape.SetAsArray(vecs, vecs.length)
      body.CreateFixture(fixtureDefinition)
    else
      fixtureDefinition.shape = new b2PolygonShape
      fixtureDefinition.shape.SetAsBox(entityDef.halfWidth, entityDef.halfHeight)
      body.CreateFixture(fixtureDefinition)

    body

