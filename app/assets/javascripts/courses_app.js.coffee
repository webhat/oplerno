'use strict'
bootstrapAngular = ->
  angular.bootstrap(document.getElementById('angular_courses_list'), ['coursesApp'])

window.coursesApp =
  angular
    .module 'coursesApp', ['ngResource', 'ngSanitize', 'yaru22.angular-timeago', 'ngDialog'], ->
      console.log 'Angular'
    .factory 'CoursesIO', ($resource) ->
      args = {}
      methods =
        query:
          method: 'GET',
          isArray: true
        update:
          method: 'PUT'

      CoursesIO = $resource '/courses.json', args, methods

      return CoursesIO
    .service 'CoursesModel', (CoursesIO, timeAgo) ->
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

coursesApp.directive 'backImg', ->
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

window.coursesApp.controller 'CourseList', ($scope, CoursesIO, CoursesModel) ->
  console.log 'Course List'
  console.log CoursesModel
  $scope.courses_list = CoursesModel.fetch()

  $scope.courses = -> $scope.courses_list

  0 # DON'T REMOVE

window.coursesApp.controller 'InfoController', ($scope, $http, ngDialog) ->

  $scope.priceInfo = ->
    console.log 'priceInfo'
    ngDialog.open({ template: 'priceInfo', scope: $scope })

window.coursesApp.controller 'CartFormController', ($scope, $http, ngDialog) ->
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
      ngDialog.open({ template: 'putInCartDialog', scope: $scope })
    .error ->
      console.log 'Error'
      $scope.message = 'NOT'
      ngDialog.open({ template: 'putInCartDialog', scope: $scope })


$(document).on('ready', bootstrapAngular)
$(document).on('page:change', bootstrapAngular)
