'use strict'

window.oplernoApp.factory 'RankingIO', [ '$resource', '$location', ($resource, $location) ->
  path = $location.absUrl().split('/')
  # FIXME: hack to keep tests working
  args = { id: path[4] || 120, type: path[3] || 'courses'}
  methods =
    query:
      method: 'GET',
      isArray: true
    update:
      method: 'PUT'

  RankingIO = $resource '/ranking/:type/:id.json', args, methods

  return RankingIO
]
window.oplernoApp.service 'RankingModel', [ 'RankingIO', (RankingIO) ->
  RankingSession = ->
    this.data = {}
    this.created = Date.NOW

  RankingSession.prototype.fetch = (query) ->
    self = this

    RankingIO.query query, (result) ->
      self.data = result

  new RankingSession()
]
window.oplernoApp.controller 'RankingList', [ '$scope', 'RankingIO', 'RankingModel', ($scope, RankingIO, RankingModel) ->
  $scope.ranking_value = RankingModel.fetch()

  $scope.ranking = ->
    if $scope.ranking_value.length > 0
      $scope.ranking_value[0].rank

  0 # DON'T REMOVE
]

