@Setup = =>
  # create an new instance of a PIXI stage
  @stage = new PIXI.Stage(0x97c56e, true)
  @playerContainer = new PIXI.DisplayObjectContainer()
  @collisionContainer = new PIXI.DisplayObjectContainer()
  @treeContainer = new PIXI.DisplayObjectContainer()
  @waterContainer = new PIXI.DisplayObjectContainer()
  @bulletContainer = new PIXI.DisplayObjectContainer()

  # @container.scale.x = 2
  # @container.scale.y = 2

  # create a renderer instance
  @renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight, null)

  # Lets use 2d canvas renderer because of using debug things for physics
  # engine
  # @renderer = new PIXI.CanvasRenderer(window.innerWidth, window.innerHeight, null)

  window.onresize = =>
    @renderer.resize(window.innerWidth, window.innerHeight)

  # add the renderer view element to the dom
  @document.body.appendChild(renderer.view)
  @renderer.view.style.position = "absolute"
  @renderer.view.style.top      = "0px"
  @renderer.view.style.left     = "0px"

  gravity = new b2Vec2(1, 0)
  # box2d will sleep for object that's are not living in the hit area.
  doSleep = true
  @world = new b2World(gravity, doSleep)

  view = renderer.view

  # for the debug purporse lets use here 2d context only.
  # context = view.getContext('2d')
  # debugDraw = new b2DebugDraw()
  # debugDraw.SetSprite(context)
  # debugDraw.SetDrawScale(1)
  # debugDraw.SetFillAlpha(0.3)
  # debugDraw.SetLineThickness(1.0)
  # debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit)
  # @world.SetDebugDraw(debugDraw)

  Physics.createBorder({ x: 0, y: view.height }, { x: view.width, y: view.height })
  Physics.createBorder({ x: 0, y: 0 }, { x: view.width, y: 0 })
  Physics.createBorder({ x: 0, y: 0 }, { x: 0, y: view.height })
  Physics.createBorder({ x: view.width, y: 0 }, { x: view.width, y: view.height })

  @stats = new Stats()
  @stats.setMode(0)

  @stats.domElement.style.position = 'absolute'
  @stats.domElement.style.left     = '0px'
  @stats.domElement.style.top      = '0px'

  document.body.appendChild( @stats.domElement )

