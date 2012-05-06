window.SetupMeetup =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    window.router = new SetupMeetup.Routers.Events()
    Backbone.history.start()
    console.log('inited')


$(document).ready ->
  SetupMeetup.init()
