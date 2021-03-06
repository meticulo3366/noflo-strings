noflo = require 'noflo'

class ConCat extends noflo.Component
  description: "combine two strings using the string.concat method:\n output = input.concat(delimiter,addString)"
  constructor: ->
    @addstring = ""
    @delimiter = "/"

    @inPorts = new noflo.InPorts
      delimiter:
        datatype: 'string'
        description: 'String used to concatenate input strings'
      addstring:
        datatype: 'string'
        description: 'first string'
      in:
        datatype: 'string'
        description: 'String to extract a sub part from'
    @outPorts = new noflo.OutPorts
      out:
        datatype: 'string'

    @inPorts.delimiter.on 'data', (data) =>
      @delimiter = data
    @inPorts.addstring.on 'data', (data) =>
      @addstring = data
    @inPorts.in.on 'data', (data) =>
      @outPorts.out.send data.concat @delimiter, @addstring
    @inPorts.in.on 'disconnect', =>
      @outPorts.out.disconnect()

exports.getComponent = -> new ConCat