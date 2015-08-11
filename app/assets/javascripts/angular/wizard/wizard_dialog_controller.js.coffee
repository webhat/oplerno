window.oplernoApp.controller 'WizardDialogController', [ 'MentorSignupIO', '$scope', 'ngDialog', (MentorSignupIO, $scope, ngDialog) ->
  $scope.mentor = {}

  $scope.submit = ->
    ngDialog.close('ngdialog1')

    MentorSignupIO.update(mentor: $scope.mentor).$promise.then( ->
      ngDialog.open({
        template: 'wizard_dialog_thanks',
        scope: $scope
        })
    , ->
      ngDialog.open({
        template: 'wizard_dialog_error',
        scope: $scope
        })
    )
]

