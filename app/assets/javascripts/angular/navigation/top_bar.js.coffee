'use strict'

window.oplernoApp.controller 'TopBarController', [ '$scope', '$http', '$compile', ($scope, $http, $compile) ->
  console.log 'Angular TopBar'
  $scope.scroll = 0
  $scope.menu_item = true
]

