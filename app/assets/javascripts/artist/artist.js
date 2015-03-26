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
    console.log('got here');
    return $http.get('/artists/search/' + artist.name, artist).success(function(data) {
      console.log('artist created: ' + data);
    }).
    error(function(data) {
      console.log('data in failure')
      console.log(data)
    });
  };

  return o;
}])