class @Stone
  NUM_TITLES: 32
  TILE_SIZE: 16

  constructor: (x, y) ->
    @id = "stone-#{uuid.v4()}"

    texture = PIXI.Texture.fromFrame("stone.png");
    @sprite = new PIXI.Sprite(texture)
    @sprite.position.x = x
    @sprite.position.y = y
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
      categories: ['static']
      collidesWith: ['bullet', 'player']
      userData:
        id: @id
        type: 'stone'

    @body = Physics.createBody(settings)
    Physics.bodies[@id] = @

class @StoneInteraction
  constructor: (@bullet_data, @object_data) ->
    @bullet = Physics.bodies[@bullet_data.id]
  update: ->
    @bullet.kill()
