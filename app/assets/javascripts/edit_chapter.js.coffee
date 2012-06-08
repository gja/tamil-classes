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
  constructor: (editable, chapter, json = {}) ->
    @id = json.id
    @chapter = chapter
    for property in ['english', 'tamil', 'tamil_alt', 'kannada']
      do (property) =>
        this[property] = ko.observable(json[property])
        this[property + "Focused"] = ko.observable(false)
        this[property + "Clicked"] = -> this.edit(); this[property + "Focused"](true)
    @editable = ko.observable(editable)
    @readonly = ko.computed => ! this.editable()

  edit: ->
    @editable(true)

  url: ->
    if @id then Routes.phrase_path(@id, {format: 'json'}) else Routes.phrases_path({format: 'json'})

  toJson: ->
    chapter_id: @chapter.id
    english: @english()
    tamil: @tamil()
    tamil_alt: @tamil_alt()
    kannada: @kannada()

  save: ->
    @editable(false)
    $.post this.url(), {phrase: this.toJson()}, (data) =>
      unless @id
        @id = data.id
        @chapter.addNewLesson()

class this.EditChapter
  constructor: (json) ->
    @id = json.id
    @phrases = ko.observableArray()
    @phrases.push new Phrase(false, this, phrase) for phrase in json.phrases
    this.addNewLesson()

  addNewLesson: ->
    phrase = new Phrase(true, this)
    @phrases.push phrase
    phrase.englishFocused(true)