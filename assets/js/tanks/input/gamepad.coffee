class @GamePad
  BUTTONS:
    BUTTON_0              : 0
    BUTTON_1              : 1
    BUTTON_2              : 2
    BUTTON_3              : 3
    BUTTON_LEFT_BUMPER    : 4
    BUTTON_RIGHT_BUMPER   : 5
    BUTTON_LEFT_TRIGGER   : 6
    BUTTON_RIGHT_TRIGGER  : 7
    BUTTON_LEFT_JOYSTICK  : 10
    BUTTON_RIGHT_JOYSTICK : 11
    BUTTON_DPAD_UP        : 12
    BUTTON_DPAD_DOWN      : 13
    BUTTON_DPAD_LEFT      : 14
    BUTTON_DPAD_RIGHT     : 15
    BUTTON_MENU           : 16
    AXIS_LEFT_JOYSTICK_X  : 0
    AXIS_LEFT_JOYSTICK_Y  : 1
    AXIS_RIGHT_JOYSTICK_X : 2
    AXIS_RIGHT_JOYSTICK_Y : 3

  constructor: ->
    @GAME_PAD_MAPPING = {}
    @GAME_PAD_MAPPING[@BUTTONS.BUTTON_DPAD_LEFT]  = Keys.LEFT
    @GAME_PAD_MAPPING[@BUTTONS.BUTTON_DPAD_RIGHT] = Keys.RIGHT
    @GAME_PAD_MAPPING[@BUTTONS.BUTTON_DPAD_UP]    = Keys.UP
    @GAME_PAD_MAPPING[@BUTTONS.BUTTON_DPAD_DOWN]  = Keys.BOTTOM
    @GAME_PAD_MAPPING[@BUTTONS.BUTTON_0]          = Keys.SPACE

    gamepads = navigator.getGamepads || navigator.webkitGetGamepads
    unless navigator.getGamepads?
      navigator.getGamepads = navigator.webkitGetGamepads

  update: ->
    gamepad = navigator.getGamepads()?[0]
    if gamepad
      for key in [@BUTTONS.BUTTON_DPAD_LEFT, @BUTTONS.BUTTON_DPAD_RIGHT, @BUTTONS.BUTTON_DPAD_UP, @BUTTONS.BUTTON_DPAD_DOWN, @BUTTONS.BUTTON_0]
        if gamepad.buttons[key] is 1
          Player.keys = Player.keys | @GAME_PAD_MAPPING[key]
        else
          Player.keys = Player.keys & ~@GAME_PAD_MAPPING[key]

