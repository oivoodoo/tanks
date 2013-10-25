class @Map
  constructor: (@map) ->

  initialize: ->
    for layer in @map.layers
      continue unless layer.data?

      for item, index in layer.data
        continue if item is 0
        position = @getTileSet(item)
        for key, value of PIXI.TextureCache
          if position.x is value.frame.x && position.y is value.frame.y
            if key is "stone.png"
              new Stone(item, index)
              break
            if key is "brick.png"
              new Brick(item, index)
              break
            if key is "tree.png"
              new Tree(item, index)
              break
            if key is "water.png"
              new Water(item, index)
              break


  getTileSet: (tileIndex) ->
    @TILE_SIZE = 16
    for tileset, index in @map.tilesets by -1
      break if tileset.firstgid <= tileIndex

    localIdx = tileIndex - tileset.firstgid
    lTileX = Math.floor(localIdx % Math.floor(tileset.imagewidth / 16))
    lTileY = Math.floor(localIdx / Math.floor(tileset.imageheight / 16))

    x = lTileX * @TILE_SIZE
    y = lTileY * @TILE_SIZE

    { x: x, y: y }


# TODO: 1. load map file using require methods in the sprockets
# 2. Parse the map file and create the collision borders based on the json
# 3. How to rerender only the visible screen for the PIXI.js?
# 4. lets use PIXI.image for placing things on the screen. I think we need to
#    migrate our 8 bit titles to 16 pixel size for less rendering things on the
#    screen.
# 5. It should be possible to render only partially screens for the hit area.

