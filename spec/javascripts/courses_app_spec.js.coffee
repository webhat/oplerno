describe 'Directives', ->
  scope = null
  $compile = null
  element = null
  $controller = {}

  beforeEach ->
    module 'coursesApp'

  beforeEach ->
    inject ($rootScope, _$compile_, _$controller_)->
      scope = $rootScope
      $compile = _$compile_
      $controller = _$controller_

      element = angular.element('<a back-img="/testimg"/>')

  describe 'backImg', ->
    it 'should render a course image', ->
      $compile(element)(scope)
      scope.$digest()

      expect(element.css('background-image')).toEqual("url(#{ window.location.origin }/testimg)")
