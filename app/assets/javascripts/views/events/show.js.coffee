class SetupMeetup.Views.EventsShow extends Backbone.View

  template: JST['events/show']

  render: =>
    @.$el.html(@template())
    this
