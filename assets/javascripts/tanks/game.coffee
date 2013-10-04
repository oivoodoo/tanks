class @Game
  sprites: ['/images/sprites/settings.json']
  constructor: ->
  initialize: ->
    @player = new Player(window.innerWidth / 2, window.innerHeight / 2)

    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      @player.initialize()
    loader.load()
  update: ->
    @player.update()
  draw: ->
    @player.draw()

