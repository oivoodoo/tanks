class @Game
  interactions: []
  sprites: ['/images/sprites/settings.json']
  constructor: ->
  initialize: ->
    @keyboard = new Keyboard()
    @gamepad  = new GamePad()
    @player   = new Player(600, 250)
    @map      = new Map(map1)
    @contacts = new Contact

    loader = new PIXI.AssetLoader(@sprites)
    loader.onComplete = =>
      # we are building the map at the first main layer and then we should
      # place all the players on the map. they could be in the random place in
      # the next builds to make game playable like in quake respawn.

      @player.initialize()
      @map.initialize()

      @contacts.addContactListener
        BeginContact: (object1, object2) =>
          if object1.type is 'bullet'
            if object2.type is 'brick'
              @interactions.push(new BrickInteraction(object1, object2))

            if object2.type is 'stone'
              @interactions.push(new StoneInteraction(object1, object2))

    loader.load()
  update: ->
    @gamepad.update()
    @player.update()

    for bullet in @player.bullets
      bullet.update()

    for interaction in @interactions
      interaction.update()

    @interactions = []

  draw: ->
    @player.draw()
    for bullet in @player.bullets
      bullet.draw()

