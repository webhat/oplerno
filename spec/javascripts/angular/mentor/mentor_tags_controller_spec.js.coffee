describe 'MentorTagsController', ->
  scope = null
  $compile = null
  element = null
  $httpBackend = null
  $controller = {}
  createController = null

  beforeEach ->
    module 'oplernoApp'

  beforeEach ->
    inject ($injector, $rootScope, _$compile_, _$controller_, $location)->
      scope = $rootScope
      spyOn($location, 'path').and.returnValue('/mentors/7')

      $compile = _$compile_
      $controller = _$controller_
      $httpBackend = $injector.get '$httpBackend'
      $httpBackend.when('PUT', '/mentors/7/tags/1.json').respond(200,{tag: {name:'blaat'}})
      $httpBackend.when('POST', '/mentors/7/tags.json').respond(200,{tag: {name:'newblaat'}})
      $httpBackend.when('GET', '/mentors/7/tags.json').respond(200,[])
      $httpBackend.when('DELETE', '/mentors/7/tags/1.json').respond(200,{tag: {name:'newblaat'}})
      element = angular.element('<div ng-controller="MentorTagsController"/>')

      createController = ->
        $controller('MentorTagsController', {'$scope' : $rootScope })

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'tags', ->
    it 'update()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectPUT('/mentors/7/tags/1.json')
      controller = createController()
      scope.new_tag = 'blaat'
      actual = scope.update(1)
      $httpBackend.flush()

      expect(actual.tag).toEqual({name:'blaat'})
    it 'create()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectPOST('/mentors/7/tags.json')
      controller = createController()
      scope.new_tag = 'newblaat'
      actual = scope.create()
      $httpBackend.flush()
      expect(actual.tag).toEqual({name:'newblaat'})
    it 'remove()', ->
      $compile(element)(scope)
      scope.$digest()

      $httpBackend.expectDELETE('/mentors/7/tags/1.json')
      controller = createController()
      scope.new_tag = 'newblaat'
      actual = scope.remove(1)
      $httpBackend.flush()
      expect(actual.tag).toEqual({name:'newblaat'})
    it 'make()', ->
      createController()
      actual = scope.make()

      expect(actual).toEqual(true)

