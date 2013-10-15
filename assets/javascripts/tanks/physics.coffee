class @Physics
  @createBorder: (point1, point2) ->
    bodyDef = new b2BodyDef
    bodyDef.type = b2Body.b2_staticBody

    fixDef = new b2FixtureDef
    fixDef.shape = new b2PolygonShape

    # bottom border
    fixDef.shape.SetAsEdge(point1, point2)
    world.CreateBody(bodyDef).CreateFixture(fixDef)

  @defaultBodyProperties:
    linearDamping:    10
    angularDamping:   10
    density:          1.0
    friction:         0.4
    restitution:      0.2
    gravityScale:     1.0
    type:             b2Body.b2_dynamicBody

  @createBody: (width, height, x, y) ->
    options = @defaultBodyProperties

    fixDef = new b2FixtureDef
    fixDef.density     = options.density
    fixDef.friction    = options.friction
    fixDef.restitution = options.restitution
    fixDef.filter.categoryBits = 0x0001
    fixDef.filter.maskBits = 0x0001

    fixDef.shape = new b2PolygonShape()
    fixDef.shape.SetAsBox(width, height)

    bodyDef = new b2BodyDef()
    bodyDef.linearDamping  = options.linearDamping
    bodyDef.angularDamping = options.angularDamping
    bodyDef.type           = options.type

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
    fixDef.density     = options.density
    fixDef.friction    = options.friction
    fixDef.restitution = options.restitution
    fixDef.filter.categoryBits = 0x0002
    fixDef.filter.maskBits = 0x0002

    fixDef.shape = new b2PolygonShape()
    fixDef.shape.SetAsBox(width, height)

    bodyDef = new b2BodyDef()
    bodyDef.linearDamping  = options.linearDamping
    bodyDef.angularDamping = options.angularDamping
    bodyDef.type           = options.type
    bodyDef.linearVelocity = new b2Vec2(0, 0)

    bodyDef.active = true
    bodyDef.allowSleep = true
    bodyDef.angle = 0
    bodyDef.angularVelocity = 0
    bodyDef.awake = true
    bodyDef.bullet = false
    bodyDef.fixedRotation = true

    bodyDef.position.Set(x, y)

    body = world.CreateBody(bodyDef)
    body.CreateFixture(fixDef)

    body