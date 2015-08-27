window.oplernoApp.controller 'CartButtonController', [
  '$scope',
  'CartModel',
  '$rootScope',
  ($scope, CartModel, $rootScope) ->
    $scope.cart = []

    $rootScope.$on "cartContentUpdated", (args) ->
      $scope.update()

    $scope.update = ->
      $scope.cart = CartModel.fetch()
      $scope.cart.$promise.then (cart) ->
        $scope.items = $scope.cart.length
        $scope.price = $scope.cart.sum (item) -> item.price

    $scope.update()
]
