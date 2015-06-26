describe 'CartsContentController', ->
  scope = null
  $compile = null
  element = null
  $httpBackend = null
  $controller = {}
  createController = null

  beforeEach ->
    module 'oplernoApp'

  beforeEach ->
    inject ($injector, $rootScope, _$compile_, _$controller_)->
      scope = $rootScope

      item1 = 
        price: 3

      item2 = 
        price: 7

      $compile = _$compile_
      $controller = _$controller_
      $httpBackend = $injector.get '$httpBackend'
      $httpBackend.when('GET', '/carts/mycart.json').respond(200,[item1, item2])
      element = angular.element('<div ng-controller="CartsContentController"/>')

      createController = ->
        $controller('CartsContentController', {'$scope' : $rootScope })

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'content', ->
    it 'carts 0', ->
      $compile(element)(scope)
      controller = createController()
      expect(scope.items).toEqual(0)
      $httpBackend.flush()
    it 'cart 2', ->
      $compile(element)(scope)
      $httpBackend.expectGET('/carts/mycart.json')
      controller = createController()

      $httpBackend.flush()
      expect(scope.items).toEqual(2)

    it 'total 0', ->
      $compile(element)(scope)      
      controller = createController()
      expect(scope.total).toEqual(0)
      $httpBackend.flush()

    it 'total 10', ->
      $compile(element)(scope)
      $httpBackend.expectGET('/carts/mycart.json')
      controller = createController()

      $httpBackend.flush()
      expect(scope.total).toEqual(10)








