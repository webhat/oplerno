describe 'Directives', ->
  $controller = {}

  beforeEach ->
    module 'coursesApp'
    inject ->
      $controller = _$controller_

  describe 'backImg', ->
    it 'should render a course image', ->
      a = $('<a back-img="testimg"/>')
      expect(a.css('background-image')).toEqual('url(testimg)')
