Setup = =>
  # create an new instance of a PIXI stage
  @stage = new PIXI.Stage(0x97c56e, true)

  # create a renderer instance
  @renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight, null)

  # add the renderer view element to the dom
  @document.body.appendChild(renderer.view)
  @renderer.view.style.position = "absolute"
  @renderer.view.style.top = "0px"
  @renderer.view.style.left = "0px"

