class SetupMeetup.Views.EventsEdit extends Backbone.View

  template: JST['events/edit']

  render: =>
    @.$el.html(@template())
    this
