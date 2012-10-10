$ ->
  # login button handler
  $(".login").click (e) ->
    e.preventDefault()
    navigator.id.request()

  # logout button handler
  $(".logout").click (e) ->
    e.preventDefault()
    navigator.id.logout()

  # current user login verification
  currentUserEmail = $("meta[name='currentUserEmail']").attr('content')
  navigator.id.watch
    loggedInUser: currentUserEmail || null

    # login callback as the result of navigator.id.request() if
    # loggedInUser either expired or never logged at the moment of the call.
    onlogin: (a) ->
      $.post '/login',
        { assertion: a },
        (res, status, xhr) ->
          window.location.reload()

    # logout callback as the result of navigator.id.logout()
    onlogout: ->
      $.post '/logout',
        {},
        (res, status, xhr) ->
          window.location.reload()
