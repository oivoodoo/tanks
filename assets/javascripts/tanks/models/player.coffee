class @Player
  width: 13
  height: 13
  bodyWidth: 13 / 2
  bodyHeight: 13 / 2

  constructor: (@x, @y, @player_position = Keys.UP, @way = Keys.UP, @is_moving = false) ->
    window.addEventListener 'keydown', (e) =>
      if [Keys.LEFT, Keys.UP, Keys.RIGHT, Keys.BOTTOM, Keys.SPACE].indexOf(e.keyCode) isnt -1
        @player_position = e.keyCode
        @is_moving = true

      if [Keys.LEFT, Keys.UP, Keys.RIGHT, Keys.BOTTOM].indexOf(e.keyCode) isnt -1
        @way = e.keyCode

    window.addEventListener 'keyup', (e) =>
      @is_moving = false

    @body = Physics.createBody(@bodyWidth, @bodyHeight, @x, @y)
    @bullets = []

    @shoot_time = new Date().getTime()
    @shoot_delay = 2000

  initialize: ->
    textures = [
      PIXI.Texture.fromFrame("yellow-tank-up.png"),
      PIXI.Texture.fromFrame("yellow-tank-bottom.png"),
      PIXI.Texture.fromFrame("yellow-tank-left.png"),
      PIXI.Texture.fromFrame("yellow-tank-right.png")
    ]
    @player_animation = new PIXI.MovieClip(textures)
    stage.addChild(@player_animation)

  update: ->
    return unless @is_moving

    if @player_position is Keys.LEFT
      @body.SetLinearVelocity(new b2Vec2(-1000, 0))
    if @player_position is Keys.UP
      @body.SetLinearVelocity(new b2Vec2(0, -1000))
    if @player_position is Keys.RIGHT
      @body.SetLinearVelocity(new b2Vec2(1000, 0))
    if @player_position is Keys.BOTTOM
      @body.SetLinearVelocity(new b2Vec2(0, 1000))

    if @player_position is Keys.SPACE
      if @shoot_time < new Date().getTime()
        position = @body.GetPosition()
        @shoot_time = new Date().getTime() + @shoot_delay
        @bullets.push new Bullet(position.x, position.y, @way)

  draw: ->
    return unless @player_animation?

    position = @body.GetPosition()
    @player_animation.position.x = position.x - @bodyWidth
    @player_animation.position.y = position.y - @bodyHeight

    # play frame
    if @way is Keys.LEFT
      @player_animation.gotoAndPlay(1)
    if @way is Keys.UP
      @player_animation.gotoAndPlay(3)
    if @way is Keys.RIGHT
      @player_animation.gotoAndPlay(2)
    if @way is Keys.BOTTOM
      @player_animation.gotoAndPlay(0)
