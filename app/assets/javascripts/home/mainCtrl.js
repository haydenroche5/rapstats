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

    var promise = artist.search({
      name: $scope.name
    });

    promise.success(function(data) {
      var svg = d3.select("svg");
      svg.selectAll("*").remove();

      var topThirty = data.top_thirty;
      
      for (var i = 0; i < topThirty.length; i++) {
        console.log(topThirty[i].count);
        console.log(topThirty[i].featured_artist_name);
      }

      var width = 800,
        height = 450;

      var y = d3.scale.linear()
        .domain([0, d3.max(topThirty, function(d) { return d.count; })])
        .range([0, height]);

      var tip = d3.tip()
        .attr('class', 'd3-tip')
        .offset([-10, 0])
        .html(function(d) {
          return "<span style='color:white'>" + d.featured_artist_name+ "</span>";
        });

      var chart = d3.select('.feature-chart')
        .attr('width', width)
        .attr('height', height);

      chart.call(tip);

      var barWidth = width / topThirty.length

      var bar = chart.selectAll('g')
        .data(topThirty)
        .enter().append('g')
        .attr('transform', function(d, i) { return 'translate(' + i * barWidth + ', 0)'; });

      bar.append('rect')
        .attr('y', function(d) { return height; })
        .attr('width', barWidth - 1)
        .transition()
        .duration(2000)
        .attr('height', function(d, i) { return y(d.count); })
        .attr('y', function(d) { return height - y(d.count); })

      chart.selectAll('rect')
        .on('mouseover', tip.show)
        .on('mouseout', tip.hide);

      bar.append('text')
        .attr('x', barWidth / 2)
        .attr('y', function(d) { return height - y(d.count) + 4; })
        .attr('dy', '.75em')
        .text(function(d) { return d.count; });

    }).
    error(function(data) {
      console.log('data in failure: ' + data);
    });
  }
}])