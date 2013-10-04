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

