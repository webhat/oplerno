'use strict'

window.oplernoApp.controller 'CartFormController', [ '$rootScope', '$scope', '$http', 'ngDialog', ($rootScope, $scope, $http, ngDialog) ->
  $scope.formData =
    course : '',
    authenticity_token : ''

  $scope.clickToOpen = ->
    request =
      method  : 'POST',
      url     : '/carts/',
      data    : $.param($scope.formData)
      headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
    $http(request).success (data) ->
      $scope.message = ''
      $rootScope.$broadcast("cartContentUpdated", {})
      ngDialog.open({ template: 'putInCartDialog', scope: $scope })
    .error ->
      $scope.message = 'NOT'
      ngDialog.open({ template: 'putInCartDialog', scope: $scope })
]
