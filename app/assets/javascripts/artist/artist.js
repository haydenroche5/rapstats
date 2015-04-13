angular.module('rapStats')
.factory('artist', [
'$http',
function($http) {
  var o = { };

  o.search = function(artist) {
    return $http.get('/artists/search/' + artist.name + '.json').success(function(data) {
      var featureCounts = data;

      var width = 900,
        height = 500;

      var y = d3.scale.linear()
        .domain([0, featureCounts[0].count])
        .range([height, 0]);

      var chart = d3.select('.feature-chart')
        .attr('width', width)
        .attr('height', height);

      var barWidth = width / featureCounts.length

      var bar = chart.selectAll('g')
        .data(featureCounts)
        .enter().append('g')
        .attr('transform', function(d, i) { return 'translate(' + i * barWidth + ', 0)'; });

      bar.append('rect')
        .attr('y', function(d) { return y(d.count); })
        .attr('height', function(d) { return height - y(d.count); })
        .attr('width', barWidth - 1);

      bar.append('text')
        .attr('x', barWidth / 2)
        .attr('y', function(d) { return y(d.count) + 3; })
        .attr('dy', '.75em')
        .text(function(d) { return d.count; });
    }).
    error(function(data) {
      console.log('data in failure');
    });
  };

  return o;
}])