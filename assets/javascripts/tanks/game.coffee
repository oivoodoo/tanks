Setup = =>
  # create an new instance of a PIXI stage
  @stage = new PIXI.Stage(0x97c56e, true)

  # create a renderer instance
  @renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight, null)

  # add the renderer view element to the dom
  @document.body.appendChild(renderer.view)
  @renderer.view.style.position = "absolute"
  @renderer.view.style.top = "0px"
  @renderer.view.style.left = "0px"

class Player
  frame_name: 'tank.png'
  constructor: ->
    @image = PIXI.Sprite.fromFrame(@frame_name)
    stage.addChild(@image)
  update: ->
    @image.position.x += 1
    # TODO: move to somewhere.
  draw: ->
    # TODO: draw somewhere on the page.

class Game
  sprites: ['/images/sprites/sprites.json']
  constructor: ->
  initialize: ->
    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      @player = new Player()
    loader.load()
  update: ->
    @player.update()
  draw: ->
    @player.draw()

# setup global objects here and create the global variables like world or
# renderer
Setup()

# our entry point to the game
@game = new Game()
@game.initialize()

animate = =>
  requestAnimFrame(animate)
  @game.update()
  @game.draw()
  renderer.render(stage)

requestAnimFrame(animate)

