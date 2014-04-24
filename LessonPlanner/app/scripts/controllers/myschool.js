'use strict';

angular.module('lessonPlannerApp')
  .controller('MyschoolCtrl', function ($scope, $location, parseWrapper) {
    parseWrapper.allSchools().then(function(schools){
    	$scope.schools = schools;
    });
  });
