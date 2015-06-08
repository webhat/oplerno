'use strict'
bootstrapAngular = ->
  angular.bootstrap(document.body, ['oplernoApp'])

window.oplernoApp =
  angular.module 'oplernoApp', [
    'ngResource',
    'ngSanitize',
    'yaru22.angular-timeago',
    'ngDialog'
  ], ->
    console.log 'oplernoApp'
    
window.oplernoApp.config ($httpProvider, $locationProvider)->
  $locationProvider.html5Mode({
    enabled: true
    requireBase:false}).hashPrefix('!')
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content')


$(document).on('ready', bootstrapAngular)
$(document).on('page:change', bootstrapAngular)
