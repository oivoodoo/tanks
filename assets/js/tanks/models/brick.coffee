class @Brick
  NUM_TITLES: 32
  TILE_SIZE: 16

  constructor: (x, y) ->
    @lifes = 1
    @id = "brick-#{uuid.v4()}"

    ## right vertical
    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 12
    # @sprite.position.y = y
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 12
    # @sprite.position.y = y + 4
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 12
    # @sprite.position.y = y + 8
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 12
    # @sprite.position.y = y + 12
    # container.addChild(@sprite)

    # ## middle vertical
    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 8
    # @sprite.position.y = y
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 8
    # @sprite.position.y = y + 4
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 8
    # @sprite.position.y = y + 8
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 8
    # @sprite.position.y = y + 12
    # container.addChild(@sprite)

    # ## left-middle vertical
    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 4
    # @sprite.position.y = y
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 4
    # @sprite.position.y = y + 4
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 4
    # @sprite.position.y = y + 8
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x + 4
    # @sprite.position.y = y + 12
    # container.addChild(@sprite)

    # ## left vertical
    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x
    # @sprite.position.y = y + 12
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x
    # @sprite.position.y = y + 8
    # container.addChild(@sprite)

    # texture = PIXI.Texture.fromFrame("little-brick.png");
    # @sprite = new PIXI.Sprite(texture)
    # @sprite.position.x = x
    # @sprite.position.y = y + 4
    # container.addChild(@sprite)

    texture = PIXI.Texture.fromFrame("brick.png");
    @sprite = new PIXI.Sprite(texture)
    @sprite.position.x = x
    @sprite.position.y = y
    collisionContainer.addChild(@sprite)

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
        type: 'brick'

    @body = Physics.createBody(settings)
    Physics.bodies[@id] = @

  kill: ->
    world.DestroyBody(@body)
    delete Physics.bodies[@id]
    collisionContainer.removeChild(@sprite)

class @BrickInteraction
  constructor: (@bullet_data, @object_data) ->
    @bullet = Physics.bodies[@bullet_data.id]
    @object = Physics.bodies[@object_data.id]
  update: ->
    @bullet.kill()
    @object.lifes -= 1
    @object.kill() if @object.lifes is 0
