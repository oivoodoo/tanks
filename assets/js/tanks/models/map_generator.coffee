class @MapGenerator
  @Types =
    Ground: 0
    Tree:   1
    Brick:  2
    Stone:  3
    Water:  4

  constructor: (@height = Math.floor(window.innerWidth / 16), @width = Math.floor(window.innerHeight / 16)) ->
    @Percentages =
      [
        [MapGenerator.Types.Tree,   7.5, 0]
        [MapGenerator.Types.Brick,  7.5, 0]
        [MapGenerator.Types.Stone,  7.5, 0]
        [MapGenerator.Types.Water,  7.5, 0]
        [MapGenerator.Types.Ground, 70,   0]
      ]

    for row, index in @Percentages
      if index > 0
        row[2] += row[1] + @Percentages[index - 1][2]
      else
        row[2] = row[1]

  generate: ->
    @map = []
    for i in [0...@width]
      row = []
      for j in [0...@height]
        random = Math.floor((Math.random()*100)+1)
        for percentage in @Percentages
          if random <= percentage[2]
            row[j] = percentage[0]
            break
      @map.push(row)
    @map
