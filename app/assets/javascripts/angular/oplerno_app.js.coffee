'use strict'
bootstrapAngular = ->
  angular.bootstrap(document.body, ['oplernoApp'])

window.oplernoApp =
  angular.module 'oplernoApp', [
    'ngResource',
    'ngSanitize'
  ]
window.oplernoApp.config ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content')


$(document).on('ready', bootstrapAngular)
$(document).on('page:change', bootstrapAngular)
