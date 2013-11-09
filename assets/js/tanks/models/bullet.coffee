class @Bullet
  WIDTH: 2
  HEIGHT: 2
  ROTATE: 90 * Math.PI / 180
  SPEED: 5000
  bodyWidth: 2 / 2
  bodyHeight: 2 / 2

  constructor: (@x, @y, @way, @current_position = 10) ->
    @keys = Keys.NONE
    @body = Physics.createBullet(@WIDTH, @HEIGHT, @x, @y)
    @id = @body.GetUserData().id
    Physics.bodies[@id] = @

    textures = [
      PIXI.Texture.fromFrame("bullet-top.png"),
      PIXI.Texture.fromFrame("bullet-bottom.png"),
      PIXI.Texture.fromFrame("bullet-left.png"),
      PIXI.Texture.fromFrame("bullet-right.png")
    ]
    @bullet_animation = new PIXI.MovieClip(textures)
    bulletContainer.addChild(@bullet_animation)
    if [Keys.RIGHT, Keys.LEFT, Keys.UP, Keys.BOTTOM].indexOf(@way) isnt -1
      @body.SetAngle(@ROTATE)

  update: ->
    if @way is 1
      @body.ApplyImpulse(new b2Vec2(-@SPEED, 0), new b2Vec2(@x, @y))
    if @way is 3
      @body.ApplyImpulse(new b2Vec2(0, -@SPEED), new b2Vec2(@x, @y))
    if @way is 2
      @body.ApplyImpulse(new b2Vec2(@SPEED, 0), new b2Vec2(@x, @y))
    if @way is 0
      @body.ApplyImpulse(new b2Vec2(0, @SPEED), new b2Vec2(@x, @y))

  draw: ->
    position = @body.GetPosition()
    @bullet_animation.position.x = position.x - @bodyWidth
    @bullet_animation.position.y = position.y - @bodyHeight

    if @way is Keys.LEFT
      @current_position = 1
    if @way is Keys.RIGHT
      @current_position = 2
    if @way is Keys.UP
      @current_position = 10
    if @way is Keys.BOTTOM
      @current_position = 4

    @bullet_animation.gotoAndPlay(@current_position)
    
  kill: ->
    world.DestroyBody(@body)
    index = game.player.bullets.indexOf(@)
    game.player.bullets.splice(index, 1)
    delete Physics.bodies[@id]
    bulletContainer.removeChild(@bullet_animation)

