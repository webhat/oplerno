window.oplernoApp.factory 'MentorSignupIO', [
  '$resource', '$location', ($resource, $location)->
    methods =
      update:
        isArray: false
        method: 'POST'

    MentorSignupIO = $resource "/mentors.json", {}, methods

    return MentorSignupIO
]

window.oplernoApp.service 'MentorSignupModel', [
  'MentorSignupIO', (MentorSignupIO)->
    MentorSignupSession = ->
      this.data = {}

    MentorSignupSession.prototype.update = (value) ->
      self = this

      MentorSignupIO.update value, (result)->
        self.data = result

    new MentorSignupSession()
]

