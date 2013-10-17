class BrickInteraction
  constructor: (@bullet_data, @object_data) ->
    @bullet = Physics.bodies[@bullet_data.id]
    @object = Physics.bodies[@object_data.id]
  update: ->
    @bullet.kill()
    @object.lifes -= 1
    @object.kill() if @object.lifes is 0

class @Game
  interactions: []
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
          if object1.type is 'bullet'
            if object2.type is 'brick'
              @interactions.push(new BrickInteraction(object1, object2))

            # if object2.type is 'stone'

    loader.load()
  update: ->
    @player.update()

    for bullet in @player.bullets
      bullet.update()

    for interaction in @interactions
      interaction.update()

    @interactions = []

    # for id in @dies
    #   Physics.bodies[id].kill()
    # @dies = []

  draw: ->
    @player.draw()
    for bullet in @player.bullets
      bullet.draw()

