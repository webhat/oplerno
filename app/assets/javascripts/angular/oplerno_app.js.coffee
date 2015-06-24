'use strict'
bootstrapAngular = ->
  try
    angular.bootstrap(document.body, ['oplernoApp'])
  catch e
    console.log 'Failed to bootstrap, probably already done.'

window.oplernoApp =
  angular.module 'oplernoApp', [
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'yaru22.angular-timeago',
    'ngDialog'
  ], ->
    console.log 'oplernoApp'
    
window.oplernoApp.config [
  '$routeProvider',
  '$resourceProvider',
  '$httpProvider',
  '$locationProvider',
  ($routeProvider, $resourceProvider, $httpProvider, $locationProvider)->
    $locationProvider.html5Mode({
      enabled: true
      requireBase:false}).hashPrefix('!')
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name=csrf-token]').attr('content')
    $resourceProvider.defaults.stripTrailingSlashes = true
  #   $routeProvider.otherwise '/'
]


$(document).on('ready', bootstrapAngular)
$(document).on('page:change', bootstrapAngular)
