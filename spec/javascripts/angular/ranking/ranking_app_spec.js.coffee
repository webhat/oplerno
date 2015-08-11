describe 'Ranking', ->
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
      $httpBackend.when('GET', '/ranking/courses/120.json')
        .respond([{rank: '160'}])
      element = angular.element('<div ng-controller="RankingList"/>')

      createController = ->
        $controller('RankingList', {'$scope' : $rootScope })

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'App', ->
    it 'should fetch ranking', ->
      $httpBackend.expectGET('/ranking/courses/120.json')
      controller = createController()
      $httpBackend.flush()
      expect(scope.status).toBe(undefined)
    it 'ranking()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectGET('/ranking/courses/120.json')
      controller = createController()
      $httpBackend.flush()

      expect(scope.ranking()).toEqual('160')

