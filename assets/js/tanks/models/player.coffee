class @Player
  width: 13
  height: 13
  bodyWidth: 13 / 2
  bodyHeight: 13 / 2
  speed: 70

  constructor: (@x, @y, @way = 3) ->
    @keys = Keys.NONE

    window.addEventListener 'keydown', (e) =>
      key = KeyboardMapping[e.keyCode]
      if key?
        @keys2 = @keys | key
        if @keys2 != @keys
          @keys = @keys2

    window.addEventListener 'keyup', (e) =>
      key = KeyboardMapping[e.keyCode]
      if key?
        @keys2 = @keys & ~key
        if @keys2 != @keys
          @keys = @keys2

    @body = Physics.createPlayer(@bodyWidth, @bodyHeight, @x, @y)
    Physics.bodies[@body.GetUserData().id] = @
    @bullets = []

    @shoot_time = new Date().getTime()
    @shoot_delay = 500

  initialize: ->
    textures = [
      PIXI.Texture.fromFrame("yellow-tank-up.png"),
      PIXI.Texture.fromFrame("yellow-tank-bottom.png"),
      PIXI.Texture.fromFrame("yellow-tank-left.png"),
      PIXI.Texture.fromFrame("yellow-tank-right.png")
    ]
    @player_animation = new PIXI.MovieClip(textures)
    playerContainer.addChild(@player_animation)

  update: ->
    if (@keys & Keys.LEFT) is Keys.LEFT
      @body.SetLinearVelocity(new b2Vec2(-@speed, 0))
    if (@keys & Keys.UP) is Keys.UP
      @body.SetLinearVelocity(new b2Vec2(0, -@speed))
    if (@keys & Keys.RIGHT) is Keys.RIGHT
      @body.SetLinearVelocity(new b2Vec2(@speed, 0))
    if (@keys & Keys.BOTTOM) is Keys.BOTTOM
      @body.SetLinearVelocity(new b2Vec2(0, @speed))

    if (@keys & Keys.SPACE) is Keys.SPACE
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
    if (@keys & Keys.LEFT) is Keys.LEFT
      @way = 1
    if (@keys & Keys.UP) is Keys.UP
      @way = 3
    if (@keys & Keys.RIGHT) is Keys.RIGHT
      @way = 2
    if (@keys & Keys.BOTTOM) is Keys.BOTTOM
      @way = 0

    @player_animation.gotoAndPlay(@way)

