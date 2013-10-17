class Brick
  constructor: (settings) ->
    @body = Physics.createBody(settings)
    @id = "brick-#{uuid.v4()}"
    @body.SetUserData({ id: @id, type: 'brick' })
    Physics.bodies[@id] = @
    @lifes = 3

  kill: ->
    world.DestroyBody(@body)
    delete Physics.bodies[@id]
    stage.removeChild(@image)

class @Map
  NUM_TITLES: 64
  TILE_SIZE: 8

  constructor: (@map) ->
  initialize: ->
    for layer in @map.layers
      continue unless layer.name is "collision"

      for object in layer.objects
        # collisions.push('mapobject')
        # collides.push('all')

        debugger
        settings =
          id: object.name,
          x:  object.x + object.width  * 0.5
          y:  object.y + object.height * 0.5
          halfHeight: object.height * 0.5
          halfWidth:  object.width  * 0.5
          dampen: 0
          angle:  0
          type:   'static'
          # categories: collisions
          # collidesWith: collides
          userData:
            id: object.name

        @brick = new Brick(settings)

    for layer in @map.layers
      continue unless layer.data?

      for item, index in layer.data
        continue if item is 0

        texture = PIXI.Texture.fromFrame("brick.png");
        sprite = new PIXI.Sprite(texture)
        sprite.position.x = Math.floor(index % @NUM_TITLES) * @TILE_SIZE - @TILE_SIZE / 2
        sprite.position.y = Math.floor(index / @NUM_TITLES) * @TILE_SIZE - @TILE_SIZE / 2
        stage.addChild(sprite)

        @brick.image = sprite


# TODO: 1. load map file using require methods in the sprockets
# 2. Parse the map file and create the collision borders based on the json
# 3. How to rerender only the visible screen for the PIXI.js?
# 4. lets use PIXI.image for placing things on the screen. I think we need to
#    migrate our 8 bit titles to 16 pixel size for less rendering things on the
#    screen.
# 5. It should be possible to render only partially screens for the hit area.

