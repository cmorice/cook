'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'
  '$http'
  'Recipes'

($scope, $location, $resource, $rootScope, $http, Recipes) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
    
  request = $http.get 'data/themes.json'
  request.success (data) ->
    $scope.themes = data
        
  $scope.recettes = Recipes.query();

])

.controller('ListCtrl', [
  '$scope','$routeParams'

($scope, $routeParams) ->
      $scope.selectedTheme = $routeParams.themeId
        
      $scope.isActive = (recette) -> 
        recette.theme == $scope.selectedTheme;
])

.controller('DetailCtrl', [
  '$scope','$routeParams'

($scope, $routeParams) ->
  i = (item for item in $scope.recettes when item._id == $routeParams.recipeId)
  $scope.recipe = i[0]
])

.controller('HomeCtrl', [
  '$scope','$http'

($scope, $http) ->

  $scope.addTodo = ->
    $scope.todos.push
      text: $scope.todoText
      done: false

    $scope.todoText = ""

  $scope.remaining = ->
    count = 0
    angular.forEach $scope.todos, (todo) ->
      count += (if todo.done then 0 else 1)

    count

  $scope.archive = ->
    oldTodos = $scope.todos
    $scope.todos = []
    angular.forEach oldTodos, (todo) ->
      $scope.todos.push todo  unless todo.done

])

