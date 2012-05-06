class SetupMeetup.Views.EventsNew extends Backbone.View

  template: JST['events/new']

  render: =>
    $(@el).html(@template())
    this
