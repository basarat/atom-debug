DebugView = require './debug-view'
{CompositeDisposable} = require 'atom'

module.exports = Debug =
  debugView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @debugView = new DebugView(state.debugViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @debugView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'debug:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @debugView.destroy()

  serialize: ->
    debugViewState: @debugView.serialize()

  toggle: ->
    console.log 'Debug was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
