'use strict'

### Sevices ###

angular.module('app.services', [])

.factory 'Recipes', [
  '$resource'
  ($resource) ->
    $resource 'http://localhost:3000/recipes/:id', null, 'update': method: 'PUT'
]
