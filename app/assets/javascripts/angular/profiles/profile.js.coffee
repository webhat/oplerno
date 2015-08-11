window.oplernoApp.factory 'ProfilesIO', [
  '$resource', '$location', ($resource, $location)->
    methods =
      update:
        isArray: false
        method: 'PUT'

    ProfilesIO = $resource "#{ $location.path() }.json", {}, methods

    return ProfilesIO
]

window.oplernoApp.service 'ProfilesModel', [
  'ProfilesIO', (ProfilesIO)->
    ProfilesSession = ->
      this.data = {}

    ProfilesSession.prototype.update = (value) ->
      self = this

      ProfilesIO.update value, (result)->
        self.data = result

    new ProfilesSession()
]

window.oplernoApp.controller 'ProfilesController', [
  '$scope', 'ProfilesIO', 'ProfilesModel', ($scope, ProfilesIO, ProfilesModel)->

    $scope.submit = ->
      description = $('#description>div').text()
      ProfilesIO.update({resource:{description:description}})
]
