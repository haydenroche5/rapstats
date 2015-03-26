angular.module('rapStats')
.controller('MainCtrl', [
'$scope',
'artist',
function($scope, artist) {
  $scope.name = artist.name
  $scope.featuredArtists = artist.featuredArtists
  
  // test data
  // $scope.featuredArtists.push({name: 'Jay-Z', count: 4});
  // $scope.featuredArtists.push({name: 'Pusha T', count: 4});
  // $scope.featuredArtists.push({name: 'Kanye West', count: 5});
  // $scope.featuredArtists.push({name: 'E-40', count: 10});

  $scope.search = function() {
    if (!$scope.name || $scope.name === '') { 
      return; 
    }

    console.log($scope.name);

    artist.search({
      name: $scope.name
    });

    $scope.name = '';
  }
}])