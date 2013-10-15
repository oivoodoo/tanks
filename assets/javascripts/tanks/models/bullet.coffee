class @Bullet
	WIDTH: 1
	HEIGHT: 5
	ROTATE: 90 * Math.PI / 180
	SPEED: 5000
	bodyWidth: 1 / 2
	bodyHeight: 5 / 2

	constructor: (@x, @y, @bullet_position) ->
		@body = Physics.createBullet(@WIDTH, @HEIGHT, @x, @y)
		textures = [
			PIXI.Texture.fromFrame("bullet-top.png"),
			PIXI.Texture.fromFrame("bullet-bottom.png"),
			PIXI.Texture.fromFrame("bullet-left.png"),
			PIXI.Texture.fromFrame("bullet-right.png")
		]
		@bullet_animation = new PIXI.MovieClip(textures)
		stage.addChild(@bullet_animation)

	update: ->
		if @bullet_position is Keys.UP
			@body.ApplyImpulse(new b2Vec2(0, -@SPEED), new b2Vec2(@x, @y))
		if @bullet_position is Keys.BOTTOM
			@body.ApplyImpulse(new b2Vec2(0, @SPEED), new b2Vec2(@x, @y))
		if @bullet_position is Keys.RIGHT
			@body.SetAngle(@ROTATE)
			@body.ApplyImpulse(new b2Vec2(@SPEED, 0), new b2Vec2(@x, @y))
		if @bullet_position is Keys.LEFT
			@body.SetAngle(@ROTATE)
			@body.ApplyImpulse(new b2Vec2(-@SPEED, 0), new b2Vec2(@x, @y))

	draw: ->
    position = @body.GetPosition()
    @bullet_animation.position.x = position.x - @bodyWidth
    @bullet_animation.position.y = position.y - @bodyHeight

   	if @bullet_position is Keys.LEFT
      @bullet_animation.gotoAndPlay(1)
    if @bullet_position is Keys.RIGHT
      @bullet_animation.gotoAndPlay(2)
    if @bullet_position is Keys.UP
      @bullet_animation.gotoAndPlay(10)
    if @bullet_position is Keys.BOTTOM
      @bullet_animation.gotoAndPlay(4)
    
	 # position = @body.GetPosition()
   # @image.position.x = position.x - @width
   # @image.position.y = position.y - @height
