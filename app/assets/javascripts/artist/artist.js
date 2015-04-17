angular.module('rapStats')
.factory('artist', [
'$http',
function($http) {
  var o = { };

  o.search = function(artist) {
    return $http.get('/artists/search/' + artist.name + '.json')
  };

  return o;
}])