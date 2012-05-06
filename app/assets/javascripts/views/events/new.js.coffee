class SetupMeetup.Views.EventsNew extends Backbone.View

  template: JST['events/new']
  formTemplate: JST['events/_form']

  render: =>
    form = new SetupMeetup.Views.EventForm()
    formTag = form.render().el
    $(@el).html(@template({formTemplate: @formTemplate, form: formTag }))
    this
