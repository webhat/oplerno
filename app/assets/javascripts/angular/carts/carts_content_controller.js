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
    '$scope',
    'CartsContentIO',
    function($scope, CartsContentIO) {
      $scope.items = 0;
      $scope.total = 0;

      CartsContentIO.query().$promise.then(function(result) {
        console.log('LEN: '+ result);
        $scope.items = result.length;
        $scope.total = 0;


        for(i=0;i<result.length;i++){
          $scope.total += result[i].price;
        }

      });
  }]);
}).call(this);
