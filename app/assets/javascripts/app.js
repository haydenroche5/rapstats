angular.module('rapStats', ['ui.router', 'templates'])

.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'MainCtrl'
    })
    .state('artists', {
      url: '/artists/{id}',
      templateUrl: 'artist/_artist.html',
      controller: 'artistsCtrl'
    });

    $urlRouterProvider.otherwise('home');
}])