class SetupMeetup.Views.EventForm extends Backbone.View

  render: =>
    event = new SetupMeetup.Models.Event()

    form = new Backbone.Form
      model: event

    $(@el).append(form.render().el)

    this
