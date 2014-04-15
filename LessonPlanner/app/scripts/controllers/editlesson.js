'use strict';

angular.module('lessonPlannerApp')
	.controller('EditlessonCtrl', ['$scope', '$routeParams', 'parseWrapper', function($scope, $routeParams, parseWrapper) {
		var stopWatching;
		var callOnceFlag = true;
		function bindLesson(){
			$scope.lesson = $scope.lessonModel.attributes;
			
			if(!$scope.lesson.steps){
				$scope.lesson.steps = [];
			}
			stopWatching = $scope.$watchCollection('lesson', function(value){
				$scope.lessonModel.set(value);
			});
		}
		parseWrapper.getLesson($routeParams.lesson)
		.then(function(lesson){
			$scope.lessonModel = lesson;
			bindLesson();
			setInterval(function(){
				$scope.lessonModel = lesson;
				$scope.lessonModel.save(null).then(function(){
					console.log('saved');
				});

			}, 60000);
		});

		$scope.saveLesson = function(){
			$scope.lessonModel.save(null).then(
				function(){
					console.log('saved');
				},
				function(myComment, error) {
			    console.warn(error);
				}
			);
		}
		$scope.newStep = function(){
			var newStep = parseWrapper.newStep();
			var steps = $scope.lessonModel.getSteps();

			if(!steps){
				steps = [];
			}
			newStep.id = steps.length;
			steps.push(newStep);
			console.log(newStep);
			$scope.lessonModel.setSteps(steps);
			$scope.lessonModel.save().then(function(newModel){
				$scope.lessonModel = newModel;
				bindLesson();
			});
		}
	}]);
