angular.module('rapStats')
.factory('artist', [
'$http',
function($http) {
  var o = {
    doesExist: false,
    name: '',
    featuredArtists: []
  };

  o.search = function(artist) {
    return $http.get('/artists/search/' + artist.name + '.json').success(function(data) {
      console.log(data)
    }).
    error(function(data) {
      console.log('data in failure')
    });
  };

  return o;
}])