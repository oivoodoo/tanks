class @Game
  dies: []
  sprites: ['/images/sprites/settings.json']
  constructor: ->
  initialize: ->

    @player = new Player(300/2, 300/2)
    @map = new Map(map1)
    @contacts = new Contact

    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      # we are building the map at the first main layer and then we should
      # place all the players on the map. they could be in the random place in
      # the next builds to make game playable like in quake respawn.
      @map.initialize()
      @player.initialize()

      @contacts.addContactListener
        BeginContact: (object1, object2) =>
          if object1.type == 'bullet' && object2.type == 'brick'
            @dies.push(object1.id)
            @dies.push(object2.id)

    loader.load()
  update: ->
    @player.update()

    for bullet in @player.bullets
      bullet.update()

    for id in @dies
      Physics.bodies[id].kill()
    @dies = []

  draw: ->
    @player.draw()
    for bullet in @player.bullets
      bullet.draw()

