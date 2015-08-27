window.oplernoApp.directive 'scrollPosition', ($window) ->
  return {
    scope: {
      scroll: '=scrollPosition'
    },
    link: (scope, element, attrs) ->
      handler = ->
        scope.scroll = document.body.scrollTop
      angular.element($window).on('scroll', scope.$apply.bind(scope, handler ))
      handler()
  }
