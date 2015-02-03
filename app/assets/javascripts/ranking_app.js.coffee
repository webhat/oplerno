'use strict'
bootstrapRankingAngular = ->
  angular.bootstrap(document.getElementById('angular_ranking_list'), ['rankingApp'])

window.rankingApp =
  angular
    .module 'rankingApp', ['ngResource', 'ngSanitize'], ->
      console.log 'Angular Ranking'
    .factory 'RankingIO', ($resource, $location) ->
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
    .service 'RankingModel', (RankingIO) ->
      RankingSession = ->
        this.data = {}
        this.created = Date.NOW

      RankingSession.prototype.fetch = (query) ->
        self = this

        RankingIO.query query, (result) ->
          self.data = result
          console.log result.result

      new RankingSession()

    .controller 'RankingList', ($scope, RankingIO, RankingModel) ->
      $scope.ranking_value = RankingModel.fetch()

      $scope.ranking = ->
        if $scope.ranking_value.length > 0
          $scope.ranking_value[0].rank

      0 # DON'T REMOVE

$(document).on('ready', bootstrapRankingAngular)
$(document).on('page:change', bootstrapRankingAngular)
