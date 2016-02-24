{BufferedProcess, CompositeDisposable} = require 'atom'
fs = require 'fs'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'xacro:check': => @check()
      'xacro:generate': => @generate()

  deactivate: ->
    subscriptions.dispose()

  # Checks the syntax of the file by running the `xacro command`.
  check: ->
    stderr = null
    editor = atom.workspace.getActivePaneItem()
    path = editor?.buffer.file?.path

    return unless path

    new BufferedProcess
      'command': 'xacro'
      'args': ['--inorder', path]
      'stderr': (output) -> stderr = output
      'exit': (status) ->
        if status is 0
          atom.notifications.addSuccess('Valid syntax')
        else
          atom.notifications.addError('Invalid syntax', 'detail': stderr)

  # Processes the contents of the file and writes it to another file.
  generate: ->
    atom.notifications.addError('Not yet implemented')
