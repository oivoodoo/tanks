class @Bullet
  WIDTH: 2
  HEIGHT: 2
  ROTATE: 90 * Math.PI / 180
  SPEED: 5000
  bodyWidth: 2 / 2
  bodyHeight: 2 / 2

  constructor: (@x, @y, @bullet_position) ->
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
    stage.addChild(@bullet_animation)

    if [Keys.RIGHT, Keys.LEFT].indexOf(@bullet_position) isnt -1
      @body.SetAngle(@ROTATE)

  update: ->
    if @bullet_position is Keyboard.LEFT
      @body.ApplyImpulse(new b2Vec2(-@SPEED, 0), new b2Vec2(@x, @y))
    if @bullet_position is Keyboard.UP
      @body.ApplyImpulse(new b2Vec2(0, -@SPEED), new b2Vec2(@x, @y))
    if @bullet_position is Keyboard.RIGHT
      @body.ApplyImpulse(new b2Vec2(@SPEED, 0), new b2Vec2(@x, @y))
    if @bullet_position is Keyboard.BOTTOM
      @body.ApplyImpulse(new b2Vec2(0, @SPEED), new b2Vec2(@x, @y))

  draw: ->
    position = @body.GetPosition()
    @bullet_animation.position.x = position.x - @bodyWidth
    @bullet_animation.position.y = position.y - @bodyHeight

    if @bullet_position is Keyboard.LEFT
      @bullet_animation.gotoAndPlay(1)
    if @bullet_position is Keyboard.RIGHT
      @bullet_animation.gotoAndPlay(2)
    if @bullet_position is Keyboard.UP
      @bullet_animation.gotoAndPlay(10)
    if @bullet_position is Keyboard.BOTTOM
      @bullet_animation.gotoAndPlay(4)

  kill: ->
    world.DestroyBody(@body)
    index = game.player.bullets.indexOf(@)
    game.player.bullets.splice(index, 1)
    delete Physics.bodies[@id]
    stage.removeChild(@bullet_animation)

