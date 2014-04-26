'use strict';

$(document).ready(function(){
  $('#fsCheckbox').change(function() {
    if($(this).is(':checked')) {
      $('#outerContainer').removeClass('container');
      return $('#outerContainer').addClass('spaceMe');
    } else {
      return $('#outerContainer').addClass('container');
    }
        // $('#textbox1').val($(this).is(':checked'));
  });
});

angular
  .module('lessonPlannerApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'parse-angular',
    'parse-angular.enhance',
    'ui.ace',
    'angular-parallax'
  ])
  .controller('lessonPlannerApp', ['', function($scope){
    $scope.currentUser = Parse.User.currentUser();
  }])
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
      .when('/myCourses', {
        templateUrl: 'views/mycourses.html',
        controller: 'MycoursesCtrl'
      })
      .when('/editCourse/:course', {
        templateUrl: 'views/editcourse.html',
        controller: 'EditcourseCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
