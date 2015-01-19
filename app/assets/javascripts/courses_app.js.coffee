'use strict'
bootstrapAngular = ->
  angular.bootstrap(document, ['coursesApp'])

window.coursesApp =
  angular
    .module 'coursesApp', ['ngResource', 'ngSanitize', 'yaru22.angular-timeago'], ->
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

String.prototype.trunc = String.prototype.trunc || (n, useWord) ->
  toLong = this.length>n
  s_ = if toLong then this.substr(0,n-1) else this
  s_ = if useWord && toLong then s_.substr(0,s_.lastIndexOf(' ')) else s_
  if toLong then s_ + '...' else s_

String.prototype.stripHTML = String.prototype.stripHTML || ->
  this.replace(/<[^>]+>/gm, '').replace(/&[^;]+;/gm, '')

window.coursesApp.controller 'CourseList', ($scope, CoursesIO, CoursesModel) ->
  console.log 'Course List'
  console.log CoursesModel
  $scope.courses_list = CoursesModel.fetch()

  $scope.courses = -> $scope.courses_list

  0 # DON'T REMOVE

$(document).on('ready', bootstrapAngular)
$(document).on('page:load', bootstrapAngular)
