PreviewTabsEventHandler = require "./preview-tabs-event-handler"

# PreviewTabsPreview represents a 'preview' tab, and is responsible for making
# itself permanent or closing itself.
module.exports =
class PreviewTabsPreview
  constructor: (@editor, @tab, @destroyNotifier) ->
    @tab.addClass("preview-tabs-preview")
    @subscriptions =
      itemSaved: @editor.onDidSave => @keep()
      itemChanged: @editor.onDidChangeModified => @keep()
      tabDoubleClicked: new PreviewTabsEventHandler(@tab, "dblclick", null, => @keep())

  destroy: ->
    subscription.dispose() for own name, subscription of @subscriptions
    @destroyNotifier?()

  close: ->
    @editor.destroy()
    @destroy()

  keep: ->
    @tab.removeClass("preview-tabs-preview")
    @destroy()

  keepIf: (path) ->
    @keep() if path is @editor.getPath()
