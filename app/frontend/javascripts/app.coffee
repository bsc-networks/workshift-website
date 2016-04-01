_ = require('lodash')

module.exports = class App
  start: ->
    _.times 3, (i) -> console.log(i + "Coffee")