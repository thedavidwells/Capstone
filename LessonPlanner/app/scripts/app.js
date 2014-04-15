'use strict';

angular
  .module('lessonPlannerApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'parse-angular',
    'parse-angular.enhance'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/Auth', {
        templateUrl: 'views/auth.html',
        controller: 'AuthCtrl'
      })
      .when('/myLessons', {
        templateUrl: 'views/mylessons.html',
        controller: 'MyLessonsCtrl'
      })
      .when('/editLesson/:lesson', {
        templateUrl: 'views/editlesson.html',
        controller: 'EditlessonCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
