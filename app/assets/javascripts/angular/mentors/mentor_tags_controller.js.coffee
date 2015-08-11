window.oplernoApp.factory 'MentorTagsIO', [
  '$resource', '$location', ($resource, $location)->
    methods =
      fetch:
        isArray: true
        method: 'GET'
      create:
        isArray: false
        method: 'POST'
      update:
        isArray: false
        method: 'PUT'
      remove:
        isArray: false
        method: 'DELETE'

    #MentorTagsIO = $resource "/mentors/:mentor_id/tags/:id.json", null, methods
    MentorTagsIO = $resource "#{ $location.path() }/tags/:id.json", null, methods

    return MentorTagsIO
]

window.oplernoApp.controller 'MentorTagsController', [ 'MentorTagsIO', '$scope', ( MentorTagsIO, $scope)->
  $scope.tags = []

  $scope.update = (id)->
    MentorTagsIO.update({ id: id }, {tag:{name:$scope.new_tag}})
  $scope.make = ->
    $('#new-tag').toggle()
    $('#new-tag-button').toggle()
    true
  $scope.remove = (id)->
    remove = MentorTagsIO.remove({ id: id }, {tag:{name:$scope.new_tag}})
    remove.$promise.then (value)->
      $('rep').empty()
      $scope.tags = MentorTagsIO.fetch()
    remove

  $scope.create = ->
    create = MentorTagsIO.create({tag:{name:$scope.new_tag}})
    create.$promise.then (value)->
      $scope.tags.push(value)
    create
]






