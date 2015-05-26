describe 'Carts', ->
  scope = null
  $compile = null
  element = null
  $httpBackend = null
  $controller = {}
  createController = null

  beforeEach ->
    module 'cartsApp'

  beforeEach ->
    inject ($injector, $rootScope, _$compile_, _$controller_)->
      scope = $rootScope
      $compile = _$compile_
      $controller = _$controller_
      $httpBackend = $injector.get '$httpBackend'
      $httpBackend.when('GET', '/carts/mycart.json')
        .respond([{name:'Name 1',price:20},{name:'Name 2',price:30}])
      element = angular.element('<div ng-controller="CartsList"/>')

      createController = ->
        $controller('CartsList', {'$scope' : $rootScope })

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'App', ->
    it 'should fetch carts', ->
      $httpBackend.expectGET('/carts/mycart.json')
      controller = createController()
      $httpBackend.flush()
      expect(scope.status).toBe(undefined)
    it 'cart()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectGET('/carts/mycart.json')
      controller = createController()
      $httpBackend.flush()

      expect(scope.carts().length).toEqual(2)
    it 'getTotal()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectGET('/carts/mycart.json')
      controller = createController()
      $httpBackend.flush()

      expect(scope.getTotal()).toEqual(50)

