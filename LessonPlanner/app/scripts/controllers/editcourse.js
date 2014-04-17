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
			// stopWatching = $scope.$watch('course', function(value){
				// $scope.courseModel.set(value);
			// }, true);
		}
		parseWrapper.getCourse($routeParams.course)
		.then(function(course){
			$scope.courseModel = course;
			bindCourse();
			setInterval($scope.saveCourse, 60000);
		});

		$scope.saveCourse = function(){
			console.log('attempting save');
			$scope.courseModel.set($scope.lesson);
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
			$scope.course.lessons.push(
				{
					id: $scope.course.lessons.length,
					title: 'New lesson ' + ($scope.course.lessons.length + 1),
					sublessons: []
				}
			);
			$scope.saveCourse();
		}
		$scope.newSubLesson = function(lesson){
			lesson.sublessons.push(
				{
					id: lesson.sublessons.length,
					title: 'New sublesson ' + (lesson.sublessons.length + 1),
					steps: []
				}
			);
			$scope.saveCourse();
		}
		$scope.newStep = function(sublesson){
			sublesson.steps.push(
				{
					id: sublesson.steps.length,
					title: 'New Step ' + (sublesson.steps.length + 1),
					hints: [],
					expectedResult: {
						type: 'Number',
						result: 'Enter in your result here'
					}
				}
			);
			$scope.saveCourse();
		}
		$scope.newHint = function(step){
			step.hints.push(
				{
					id: step.hints.length,
					title: 'New Hint ' + (step.hints.length + 1),
				}
			);
			$scope.saveCourse();
		}
		$scope.cmFocus = function(e){
			var textarea = $(e.target);
			var editor = CodeMirror.fromTextArea(e.target, {
			    mode: "text/javascript"
			});
		}
		$scope.hideLower = function(obj){
			obj.hideLower = !obj.hideLower;
		}
		$scope.aceLoaded = function(_editor){
			_editor.on('blur', function(){
				$scope.saveCourse();
			})
		}
	}]);
/*
Course
	Title √
	Ratings ¬
	Description √
	Author √ 
	Description √
	Lessons √
		Title √
		Description √
		Steps √
			Title √
			Description √
			Goal √
			Expected Result
				Type (Number, string, etc)
				expectation
			Hints √
			Initial text

 */
