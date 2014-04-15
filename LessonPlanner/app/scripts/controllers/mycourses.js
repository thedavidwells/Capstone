'use strict';

angular.module('lessonPlannerApp')
  .controller('MycoursesCtrl', function ($scope, $location, parseWrapper) {
    parseWrapper.getLessons().then(function(data){
			$scope.lessons = data;
		}, function(e){
				console.warn(e);
			});
		$scope.createCourse = function(){
			parseWrapper.createCourse().then(function(newCourse){
				console.log(newCourse.getTitle());
				$location.path('/editCourse/'+newCourse.id);
			}, function(e){
				console.warn(e);
			})
		}
  });
