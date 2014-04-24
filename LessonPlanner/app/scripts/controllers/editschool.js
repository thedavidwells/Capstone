'use strict';

angular.module('lessonPlannerApp')
.controller('EditschoolCtrl', ['$scope', '$routeParams', 'parseWrapper', function($scope, $routeParams, parseWrapper) {
  	function bindSchool(){
		$scope.school = $scope.schoolModel.attributes;
	}
  	$scope.saveSchool = function(){
  		console.log('attempting save');
		$scope.schoolModel.set($scope.school);
		$scope.schoolModel.save(null).then(
			function(){
				console.log('saved');
			},
			function(myComment, error) {
		    	console.warn(error);
			}
		);
  	}
  	parseWrapper.getSchool($routeParams.school)
	.then(function(school){
		$scope.schoolModel = school;
		bindSchool();
		setInterval($scope.saveSchool, 60000);
	});
}]);
