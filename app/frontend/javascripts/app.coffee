_ = require('lodash')

module.exports = class App
  start: ->
    _.times 5, (i) -> console.log(i + "Coffee")