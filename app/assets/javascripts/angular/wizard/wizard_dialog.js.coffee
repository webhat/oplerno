window.oplernoApp.controller 'WizardDialog', [ '$scope', 'ngDialog', ($scope, ngDialog) ->
  ngDialog.open({
    template: 'wizard_dialog',
    scope: $scope,
    showClose: true
    })
]
