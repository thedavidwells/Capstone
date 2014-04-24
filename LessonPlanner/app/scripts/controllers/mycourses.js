'use strict';

angular.module('lessonPlannerApp')
  .controller('MycoursesCtrl', function ($scope, $location, parseWrapper) {
    parseWrapper.getCourses().then(function(data){
			$scope.courses = data;
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
		},
		$scope.destroyCourse = function(course){
			if(confirm('Are you sure you want to destroy \''+course.getTitle() +'\'')){
				parseWrapper.getCourse(course.id).then(function(c){
					parseWrapper.destroyCourse(c).then(function(){
						
					}, function(e){
						alert(e);
					})
				});
			}
		}
  });
