'use strict'

window.oplernoApp.factory 'CoursesIO', [ '$resource', ($resource) ->
  args = {}
  methods =
    query:
      method: 'GET',
      isArray: true
    update:
      method: 'PUT'

  CoursesIO = $resource '/courses.json', args, methods

  return CoursesIO
]

window.oplernoApp.service 'CoursesModel', [ 'CoursesIO', 'timeAgo', (CoursesIO, timeAgo) ->
  timeAgo.settings.allowFuture = true

  CoursesSession = ->
    this.data = {}
    this.created = Date.NOW

  CoursesSession.prototype.fetch = (query) ->
    self = this

    CoursesIO.query query, (result) ->
      self.data = result

  new CoursesSession()
]

window.oplernoApp.directive 'backImg', ->
  return (scope, element, attrs) ->
    if attrs.backImg.lastIndexOf('/') == attrs.backImg.length-1
      attrs.backImg += '../../../../../../../../assets/medium/missing.png'
    url = 'url('
    url += attrs.backImg
    url += ')'
    style =
      'background-image': url

    element.css(style)

window.oplernoApp.controller 'CourseList', ['$scope', 'CoursesIO', 'CoursesModel', ($scope, CoursesIO, CoursesModel) ->
  $scope.courses_list = CoursesModel.fetch()


  $scope.courses = ->
    $('[data-toggle="tooltip"]').tooltip()
    $scope.courses_list

  0 # DON'T REMOVE
]

