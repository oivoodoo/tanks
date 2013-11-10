class @Keyboard
  CODES:
    LEFT   : 37
    UP     : 38
    RIGHT  : 39
    BOTTOM : 40
    SPACE  : 32

  constructor: ->
    @KEYBOARD_MAPPING = {}
    @KEYBOARD_MAPPING[@CODES.LEFT]   = Keys.LEFT
    @KEYBOARD_MAPPING[@CODES.UP]     = Keys.UP
    @KEYBOARD_MAPPING[@CODES.RIGHT]  = Keys.RIGHT
    @KEYBOARD_MAPPING[@CODES.BOTTOM] = Keys.BOTTOM
    @KEYBOARD_MAPPING[@CODES.SPACE]  = Keys.SPACE

    window.addEventListener 'keydown', (e) =>
      key = @KEYBOARD_MAPPING[e.keyCode]
      if key?
        @keys2 = Player.keys | key
        if @keys2 != Player.keys
          Player.keys = @keys2

    window.addEventListener 'keyup', (e) =>
      key = @KEYBOARD_MAPPING[e.keyCode]
      if key?
        @keys2 = Player.keys & ~key
        if @keys2 != Player.keys
          Player.keys = @keys2

