class @Game
  sprites: ['/images/sprites/settings.json']
  constructor: ->
  initialize: ->
    @player = new Player(window.innerWidth / 2, window.innerHeight / 2)
    @map = new Map(map1)

    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      # we are building the map at the first main layer and then we should
      # place all the players on the map. they could be in the random place in
      # the next builds to make game playable like in quake respawn.
      @map.initialize()
      @player.initialize()

    loader.load()
  update: ->
    @player.update()
    for bullet in @player.bullets
      bullet.update()
  draw: ->
    @player.draw()
    for bullet in @player.bullets
      bullet.draw()

