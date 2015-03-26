angular.module('rapStats')
.controller('ArtistCtrl', [
'$scope',
'$stateParams',
'artist',
function($scope, $stateParams, artist) {
  $scope.artist = 'Test artist';
}]);
