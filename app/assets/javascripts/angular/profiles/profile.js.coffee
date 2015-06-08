window.oplernoApp.factory 'ProfilesIO', [
  '$resource', '$location', ($resource, $location)->
    console.log 'ProfilesIO'
    methods =
      update:
        isArray: false
        method: 'PUT'

    ProfilesIO = $resource "#{ $location.path() }.json", {}, methods

    return ProfilesIO
]

window.oplernoApp.service 'ProfilesModel', [
  'ProfilesIO', (ProfilesIO)->
    console.log 'ProfilesModel'
    ProfilesSession = ->
      this.data = {}

    ProfilesSession.prototype.update = (value) ->
      self = this

      ProfilesIO.update value, (result)->
        self.data = result
        console.log result

    new ProfilesSession()
]

window.oplernoApp.controller 'ProfilesController', [
  '$scope', 'ProfilesIO', 'ProfilesModel', ($scope, ProfilesIO, ProfilesModel)->
    console.log 'ProfilesController'

    $scope.submit = ->
      description = $('#description>div').text()
      console.log 'submit'
      ProfilesIO.update({resource:{description:description}})
]
