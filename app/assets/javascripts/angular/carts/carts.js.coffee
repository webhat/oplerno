'use strict'
window.oplernoApp.factory 'CartsIO', [ '$resource', '$location', ($resource, $location) ->
  path = $location.absUrl().split('/')
  # FIXME: hack to keep tests working
  args = {}
  methods =
    query:
      method: 'GET',
      isArray: true
    update:
      method: 'PUT'

  CartsIO = $resource '/carts/mycart.json', args, methods

  return CartsIO
]
window.oplernoApp.service 'CartsModel', [ 'CartsIO', (CartsIO) ->
  CartsSession = ->
    this.data = {}
    this.created = Date.NOW

  CartsSession.prototype.fetch = (query) ->
    self = this

    CartsIO.query query, (result) ->
      self.data = result

  new CartsSession()
]
window.oplernoApp.controller 'CartsList', [ '$scope', 'CartsIO', 'CartsModel', ($scope, CartsIO, CartsModel) ->
  $scope.cart = CartsModel.fetch()

  $scope.carts = ->
    if $scope.cart.length > 0
      $scope.cart

  $scope.getTotal = ->
    total = 0
    total = (total = total + product.price for product in $scope.cart)
    total = total[total.length-1]
    total

  0 # DON'T REMOVE
]
