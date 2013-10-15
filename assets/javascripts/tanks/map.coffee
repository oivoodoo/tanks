class @Map
  constructor: (@map) ->
  initialize: ->
    # TODO: write parser
# TODO: 1. load map file using require methods in the sprockets
# 2. Parse the map file and create the collision borders based on the json
# 3. How to rerender only the visible screen for the PIXI.js?
# 4. lets use PIXI.image for placing things on the screen. I think we need to
#    migrate our 8 bit titles to 16 pixel size for less rendering things on the
#    screen.
# 5. It should be possible to render only partially screens for the hit area.