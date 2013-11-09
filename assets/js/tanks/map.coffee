class @Map
  constructor: (@map) ->

  initialize: ->
    generator = new MapGenerator()
    map = generator.generate()

    TILE_SIZE = 16
    for row, y in map
      local_y = y * TILE_SIZE
      for key, x in row
        local_x = x * TILE_SIZE
        if key is MapGenerator.Types.Stone
          new Stone(local_x, local_y)
        if key is MapGenerator.Types.Brick
          new Brick(local_x, local_y)
        if key is MapGenerator.Types.Tree
          new Tree(local_x, local_y)
        if key is MapGenerator.Types.Water
          new Water(local_x, local_y)

