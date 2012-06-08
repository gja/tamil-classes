ko.bindingHandlers.executeOnEnter =
  init: (element, valueAccessor, allBindingsAccessor, viewModel) ->
    allBindings = allBindingsAccessor();
    $(element).keypress (event) ->
      keyCode = if event.which then event.which else event.keyCode
      if (keyCode == 13)
        allBindings.executeOnEnter.call(viewModel);
        false;
      else
        true;

class Phrase
  constructor: (editable, json = {}) ->
    @id = json.id
    @chapter_id = json.chapter_id
    @english = ko.observable(json.english)
    @tamil = ko.observable(json.tamil)
    @tamil_alt = ko.observable(json.tamil_alt)
    @kannada = ko.observable(json.kannada)
    @editable = ko.observable(editable)
    @readonly = ko.computed => ! this.editable()

  edit: ->
    @editable(true)

  url: ->
    if @id then Routes.phrase_path(@id, {format: 'json'}) else Routes.phrases_path({format: 'json'})

  toJson: ->
    chapter_id: @chapterId
    english: @english()
    tamil: @tamil()
    tamil_alt: @tamil_alt()
    kannada: @kannada()

  save: ->
    @editable(false)
    $.post this.url(), {phrase: this.toJson()}, (data) =>
      @id = data.id if data

class this.EditChapter
  constructor: (json) ->
    @chapterId = json.id
    @phrases = ko.observableArray()
    @phrases.push new Phrase(false, phrase) for phrase in json.phrases
    this.addNewLesson()

  addNewLesson: ->
    phrase = new Phrase(true, {chapter_id: @chapterId})
    @phrases.push phrase
