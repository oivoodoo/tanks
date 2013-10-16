class @Contact
  @bodiesMap = []

  addContactListener: (callbacks) ->
    @listener = new Box2D.Dynamics.b2ContactListener

    if callbacks.BeginContact
      @listener.BeginContact = (contact) ->
        callbacks.BeginContact contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB().GetBody().GetUserData()
  
    if callbacks.EndContact
      @listener.EndContact = (contact) ->
        callbacks.EndContact contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB().GetBody().GetUserData()
    
    if callbacks.PostSolve
      @listener.PostSolve = (contact, impulse) ->
        callbacks.PostSolve contact.GetFixtureA().GetBody().GetUserData(), contact.GetFixtureB().GetBody().GetUserData(), impulse.normalImpulses[0]
  
    @world.SetContactListener(listener)
  
    removeBody: (id) ->
      @world.DestroyBody(@bodiesMap[id])