angular.module('rapStats')
.factory('artist', [
'$http',
function($http) {
  var o = { };

  o.search = function(artist) {
    return $http.get('/artists/search/' + artist.name + '.json').success(function(data) {
      console.log(data);
      var feature_counts = data;

      var x = d3.scale.linear()
        .domain([1, feature_counts[0].count])
        .range([0, 500]);

      d3.select('.feature-chart')
        .selectAll('div')
          .data(feature_counts)
        .enter().append('div')
          .style('width', function(d) { return x(d.count) + 'px'; })
          .append('text')
            .text(function(d) {
              return d.featured_artist_name + ', ' + d.count;
            });
      d3.select('.feature-chart')
        .selectAll('div')

    }).
    error(function(data) {
      console.log('data in failure');
    });
  };

  return o;
}])