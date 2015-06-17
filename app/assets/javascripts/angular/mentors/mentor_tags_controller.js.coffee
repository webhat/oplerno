window.oplernoApp.factory 'MentorTagsIO', [
  '$resource', '$location', ($resource, $location)->
    console.log 'MentorTagsIO'
    methods =
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
  console.log 'loaded'
  $scope.tags = []

  $scope.update = (id)->
    console.log 'edit'
    MentorTagsIO.update({ id: id }, {tag:{name:$scope.new_tag}})
  $scope.make = ->
    $('#new-tag').toggle()
    $('#new-tag-button').toggle()
    true
  $scope.remove = (id)->
    console.log 'remove'
    MentorTagsIO.remove({ id: id }, {tag:{name:$scope.new_tag}})
  $scope.create = ->
    console.log 'create'
    create = MentorTagsIO.create({tag:{name:$scope.new_tag}})
    create.$promise.then (value)->
      console.log value
      console.log $scope.tags
      $scope.tags[$scope.tags.length] = value
    create
]






