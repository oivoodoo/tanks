class Game
  sprites: ['/images/sprites/settings.json']
  constructor: ->
  initialize: ->
    @player = new Player()

    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      @player.initialize()
    loader.load()
  update: ->
    @player.update()
  draw: ->
    @player.draw()

