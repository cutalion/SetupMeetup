class SetupMeetup.Routers.Events extends Backbone.Router
  routes:
    ''                : 'index'
    'events'          : 'index'
    'events/new'      : 'new'
    'events/:id'      : 'show'
    'events/:id/edit' : 'edit'

  initialize: ->
    @collection = new SetupMeetup.Collections.Events()
    @collection.fetch()

  index: =>
    view = new SetupMeetup.Views.EventsIndex({collection: @collection})
    $('.main.container').html(view.render().el )

  new: ->
    view = new SetupMeetup.Views.EventsNew()
    $('.main.container').html(view.render().el )

  show: (id) ->
    console.log('show')
    view = new SetupMeetup.Views.EventsShow({id: id})
    $('.main.container').html(view.render().el)

  edit: (id) ->
    view = new SetupMeetup.Views.EventsEdit({id: id})
    $('.main.container').html(view.render().el)
