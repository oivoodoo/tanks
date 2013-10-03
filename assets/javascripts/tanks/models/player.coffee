class @Player
  constructor: (@x, @y, @way = 38, @is_moving = false) ->
    window.addEventListener 'keydown', (e) =>
      if [37, 38, 39, 40].indexOf(e.keyCode) isnt -1
        @way = e.keyCode
        @is_moving = true

    window.addEventListener 'keyup', (e) =>
      @is_moving = false

    @body = rectangle(@x, @y)

  initialize: ->
    textures = [
      PIXI.Texture.fromFrame("yellow-tank-up.png"),
      PIXI.Texture.fromFrame("yellow-tank-bottom.png"),
      PIXI.Texture.fromFrame("yellow-tank-left.png"),
      PIXI.Texture.fromFrame("yellow-tank-right.png")
    ]
    @movie = new PIXI.MovieClip(textures)
    stage.addChild(@movie)


  update: ->
    return unless @is_moving

    if @way is 37 # LEFT
      @body.SetLinearVelocity(new b2Vec2(-100, 0))
    if @way is 38 # UP
      @body.SetLinearVelocity(new b2Vec2(0, -100))
    if @way is 39 # RIGHT
      @body.SetLinearVelocity(new b2Vec2(100, 0))
    if @way is 40 # BOTTOM
      @body.SetLinearVelocity(new b2Vec2(0, 100))

  draw: ->
    return unless @movie?

    position = @body.GetPosition()
    @movie.position.x = position.x
    @movie.position.y = position.y

    # play frame
    if @way is 37 # LEFT
      @movie.gotoAndPlay(1)
    if @way is 38 # UP
      @movie.gotoAndPlay(3)
    if @way is 39 # RIGHT
      @movie.gotoAndPlay(2)
    if @way is 40 # BOTTOM
      @movie.gotoAndPlay(0)

  rectangle = (x, y) ->
    @width = 16
    @height = 16
    @options = 
      linearDamping: 10
      angularDamping: 10
      density: 1.0
      friction: 0.4
      restitution: 0.2
      gravityScale: 1.0
      type: b2Body.b2_dynamicBody

    @body_def = new b2BodyDef()
    @fix_def = new b2FixtureDef

    @fix_def.density = options.density
    @fix_def.friction = options.friction
    @fix_def.restitution = options.restitution

    @fix_def.shape = new b2PolygonShape()

    @fix_def.shape.SetAsBox(width , height)

    # we are using here cartesian coordinates the center half of the center
    # in the canvas container
    @body_def.position.Set(x, y)

    @body_def.linearDamping = options.linearDamping
    @body_def.angularDamping = options.angularDamping

    @body_def.type = options.type

    @b = world.CreateBody( body_def )
    @f = b.CreateFixture(fix_def)

    @b
