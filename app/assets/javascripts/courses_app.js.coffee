bootstrapAngular = ->
  angular.bootstrap(document, ['coursesApp'])

window.coursesApp = angular.module 'coursesApp', ['ngResource', 'ngSanitize'], ->
  console.log 'Hello Angular'

$(document).on('ready', bootstrapAngular)
$(document).on('page:load', bootstrapAngular)
