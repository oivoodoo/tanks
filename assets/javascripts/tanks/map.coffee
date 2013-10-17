class Brick
  NUM_TITLES: 32
  TILE_SIZE: 16

  constructor: (object, index) ->
    @lifes = 3
    @id = "brick-#{uuid.v4()}"

    texture = PIXI.Texture.fromFrame("brick.png");
    @sprite = new PIXI.Sprite(texture)
    @sprite.position.x = Math.floor(index % @NUM_TITLES) * @TILE_SIZE - @TILE_SIZE / 2
    @sprite.position.y = Math.floor(index / @NUM_TITLES) * @TILE_SIZE - @TILE_SIZE / 2
    stage.addChild(@sprite)

    settings =
      id: @id,
      x:  @sprite.position.x + @TILE_SIZE / 2
      y:  @sprite.position.y + @TILE_SIZE / 2
      halfHeight: @TILE_SIZE / 2
      halfWidth:  @TILE_SIZE / 2
      dampen: 0
      angle:  0
      type:   'static'
      userData:
        id: @id
        type: 'brick'

    @body = Physics.createBody(settings)
    Physics.bodies[@id] = @

  kill: ->
    world.DestroyBody(@body)
    delete Physics.bodies[@id]
    stage.removeChild(@sprite)

class @Map
  constructor: (@map) ->
  initialize: ->
    for layer in @map.layers
      continue unless layer.data?

      for item, index in layer.data
        continue if item is 0

        new Brick(item, index)

# TODO: 1. load map file using require methods in the sprockets
# 2. Parse the map file and create the collision borders based on the json
# 3. How to rerender only the visible screen for the PIXI.js?
# 4. lets use PIXI.image for placing things on the screen. I think we need to
#    migrate our 8 bit titles to 16 pixel size for less rendering things on the
#    screen.
# 5. It should be possible to render only partially screens for the hit area.

