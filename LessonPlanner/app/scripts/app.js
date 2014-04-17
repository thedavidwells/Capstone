'use strict';

$(document).ready(function(){
  console.log('happens');
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
    'ui.ace'
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
  }).value('ui.config', {
    codemirror: {
        mode: 'text/javascript',
        lineNumbers: true,
        matchBrackets: true
    }
});;
