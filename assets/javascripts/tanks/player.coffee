class @Player
  constructor: (@way = 38, @is_moving = false) ->
    window.addEventListener 'keydown', (e) =>
      if [37, 38, 39, 40].indexOf(e.keyCode) isnt -1
        @way = e.keyCode
        @is_moving = true

    window.addEventListener 'keyup', (e) =>
      @is_moving = false

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
      @movie.position.x -= 1
    if @way is 38 # UP
      @movie.position.y -= 1
    if @way is 39 # RIGHT
      @movie.position.x += 1
    if @way is 40 # BOTTOM
      @movie.position.y += 1

  draw: ->
    return unless @movie?

    if @way is 37 # LEFT
      @movie.gotoAndPlay(1)
    if @way is 38 # UP
      @movie.gotoAndPlay(3)
    if @way is 39 # RIGHT
      @movie.gotoAndPlay(2)
    if @way is 40 # BOTTOM
      @movie.gotoAndPlay(0)
