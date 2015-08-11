(function() {
  window.oplernoApp.factory('CartsContentIO', [ '$resource', function($resource) {

    methods = {
      query: {
        method: 'GET',
        isArray: true
      }
    };
    CartsContentIO = $resource('/carts/mycart.json', null, methods);

    return CartsContentIO;
  }]);
  window.oplernoApp.controller('CartsContentController', [
    '$rootScope',
    '$scope',
    'CartsContentIO',
    function($rootScope, $scope, CartsContentIO) {
      $scope.items = 0;
      $scope.total = 0;

      $rootScope.$on("cartContentUpdated", function (args) {
        $scope.update();
      });

      $scope.update = function() {
        CartsContentIO.query().$promise.then(function(result) {
          console.log('LEN: '+ result);
          $scope.items = result.length;
          $scope.total = 0;

          for(i=0;i<result.length;i++){
            $scope.total += result[i].price;
          }

        });
      }

      $scope.update();
  }]);
}).call(this);
