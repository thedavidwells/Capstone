'use strict';

angular.module('lessonPlannerApp')
  .controller('SchoolmanagerCtrl', function ($scope, $location, parseWrapper) {
    parseWrapper.getSchools().then(function(data){
			$scope.schools = data;
		}, function(e){
				console.warn(e);
			});
		$scope.createSchool = function(){
			parseWrapper.createSchool().then(function(newSchool){
				console.log(newSchool.getTitle());
				$location.path('/editSchool/'+newSchool.id);
			}, function(e){
				console.warn(e);
			})
		}

  });
