@Keys =
  NONE: 0x0000
  UP: 0x0001
  BOTTOM: 0x0001 << 1
  LEFT: 0x0001 << 2
  RIGHT: 0x0001 << 3
  SPACE:  0x0001 << 4

@Keyboard =
  LEFT:   37
  UP:     38
  RIGHT:  39
  BOTTOM: 40
  SPACE:  32

@KeyboardMapping = {}
KeyboardMapping[Keyboard.LEFT] = Keys.LEFT
KeyboardMapping[Keyboard.UP] = Keys.UP
KeyboardMapping[Keyboard.RIGHT] = Keys.RIGHT
KeyboardMapping[Keyboard.BOTTOM] = Keys.BOTTOM
KeyboardMapping[Keyboard.SPACE] = Keys.SPACE