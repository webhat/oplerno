'use strict'
bootstrapCartsAngular = ->
  angular.bootstrap(document.getElementById('angular_cart_list'), ['cartsApp'])

window.cartsApp =
  angular
    .module 'cartsApp', ['ngResource', 'ngSanitize', 'ngDialog'], ->
      console.log 'Angular Carts'
    .factory 'CartsIO', [ '$resource', '$location', ($resource, $location) ->
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
    .service 'CartsModel', [ 'CartsIO', (CartsIO) ->
      CartsSession = ->
        this.data = {}
        this.created = Date.NOW

      CartsSession.prototype.fetch = (query) ->
        self = this

        CartsIO.query query, (result) ->
          self.data = result
          console.log result.result

      new CartsSession()
    ]
    .controller 'CartsList', [ '$scope', 'CartsIO', 'CartsModel', ($scope, CartsIO, CartsModel) ->
      $scope.cart = CartsModel.fetch()

      $scope.carts = ->
        if $scope.cart.length > 0
          $scope.cart

      $scope.getTotal = ->
        total = 0
        total = (total = total + product.price for product in $scope.cart)
        total = total[total.length-1]
        console.log 'TOTAL:' + total
        total

      0 # DON'T REMOVE
    ]

$(document).on('ready', bootstrapCartsAngular)
$(document).on('page:change', bootstrapCartsAngular)
