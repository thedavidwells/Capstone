'use strict';

angular.module('lessonPlannerApp')
	.controller('MyLessonsCtrl', function ($scope, $location, parseWrapper) {
		parseWrapper.getLessons().then(function(data){
			$scope.lessons = data;
		}, function(e){
				console.warn(e);
			});
		$scope.createLesson = function(){
			parseWrapper.createLesson().then(function(newLesson){
				console.log(newLesson.getTitle());
				$location.path('/editLesson/'+newLesson.id);
			}, function(e){
				console.warn(e);
			})
		}

	});
