class @Game
  sprites: ['/images/sprites/settings.json']
  constructor: ->
  initialize: ->
    @player = new Player(window.innerWidth / 2, window.innerHeight / 2)
    @map = new Map(map1)

    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      @player.initialize()
      @map.initialize()
    loader.load()
  update: ->
    @player.update()
    for bullet in @player.bullets
      bullet.update()
  draw: ->
    @player.draw()
    for bullet in @player.bullets
      bullet.draw()
