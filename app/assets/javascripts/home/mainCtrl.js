angular.module('rapStats')
.controller('MainCtrl', [
'$scope',
'artist',
function($scope, artist) {
  $scope.name = artist.name
  $scope.featuredArtists = artist.featuredArtists

  $scope.search = function() {
    if (!$scope.name || $scope.name === '') { 
      return; 
    }

    artist.search({
      name: $scope.name
    });

    $scope.name = '';
  }
}])