'use strict';

angular.module('lessonPlannerApp')
	.controller('EditcourseCtrl', ['$scope', '$routeParams', 'parseWrapper', function($scope, $routeParams, parseWrapper) {
		var stopWatching;
		var callOnceFlag = true;
		function bindCourse(){
			$scope.course = $scope.courseModel.attributes;
			
			if(!$scope.course.lessons){
				$scope.course.lessons = [];
			}
			stopWatching = $scope.$watchCollection('course', function(value){
				$scope.courseModel.set(value);
			});
		}
		parseWrapper.getCourse($routeParams.course)
		.then(function(course){
			$scope.courseModel = course;
			bindCourse();
			setInterval(function(){
				$scope.courseModel = course;
				$scope.courseModel.save(null).then(function(){
					console.log('saved');
				});

			}, 60000);
		});

		$scope.saveCourse = function(){
			console.log('attempting save');
			$scope.courseModel.save(null).then(
				function(){
					console.log('saved');
				},
				function(myComment, error) {
			    console.warn(error);
				}
			);
		}
		$scope.newLesson = function(){
			var newLesson = parseWrapper.newLesson();
			var lessons = $scope.courseModel.getLessons();

			if(!lessons){
				lessons = [];
			}
			newLesson.id = lessons.length;
			lessons.push(newLesson);
			console.log(newLesson);
			$scope.courseModel.setLessons(lessons);
			$scope.courseModel.save().then(function(newModel){
				$scope.courseModel = newModel;
				bindCourse();
			});
		}
		$scope.newSubLesson = function(lesson){
			lesson.sublessons.push({id: lesson.sublessons.length, title: 'this'});
		}
	}]);
