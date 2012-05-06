class SetupMeetup.Views.EventsIndex extends Backbone.View

  template: JST['events/index']

  initialize: =>
    @collection.on('reset', @render)

  render: =>
    @.$el.html(@template({events: @collection}))
    this
