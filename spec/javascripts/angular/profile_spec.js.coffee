describe 'ProfilesController', ->
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
      $compile = _$compile_
      $controller = _$controller_
      $httpBackend = $injector.get '$httpBackend'
      $httpBackend.when('PUT', '/teams/1.json')
        .respond({error: "ok"})
      element = angular.element('<div ng-controller="ProfilesController"/>')

      createController = ->
        $controller('ProfilesController', {'$scope' : $rootScope })

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'update', ->
    it 'submit()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectPUT('/teams/1.json')
      controller = createController()
      actual = scope.submit()
      $httpBackend.flush()

      expect(actual['error']).toEqual("ok")
