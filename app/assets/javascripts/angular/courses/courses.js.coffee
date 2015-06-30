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
      console.log "called get"
      self.data = result
      console.log result.result

  new CoursesSession()
]

window.oplernoApp.directive 'backImg', ->
  console.log 'Directive'
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
  console.log 'Course List'
  console.log CoursesModel
  $scope.courses_list = CoursesModel.fetch()


  $scope.courses = ->
    $('[data-toggle="tooltip"]').tooltip()
    $scope.courses_list

  0 # DON'T REMOVE
]

window.oplernoApp.controller 'CartFormController', [ '$rootScope', '$scope', '$http', 'ngDialog', ($rootScope, $scope, $http, ngDialog) ->
  $scope.formData =
    course : '',
    authenticity_token : ''

  $scope.clickToOpen = ->
    request =
      method  : 'POST',
      url     : '/carts/',
      data    : $.param($scope.formData)
      headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
    $http(request).success (data) ->
      $scope.message = ''
      $rootScope.$broadcast("cartContentUpdated", {})
      ngDialog.open({ template: 'putInCartDialog', scope: $scope })
    .error ->
      console.log 'Error'
      $scope.message = 'NOT'
      ngDialog.open({ template: 'putInCartDialog', scope: $scope })
]
