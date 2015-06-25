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
      console.log('CartsContentController');
      console.log(CartsContentIO.query());

      $scope.items = 0;

      CartsContentIO.query().$promise.then(function(result) {
        console.log('LEN: '+ result.length);
        $scope.items = result.length;
      });
  }]);
}).call(this);
