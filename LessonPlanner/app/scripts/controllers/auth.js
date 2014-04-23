'use strict';

angular.module('lessonPlannerApp')
.controller('AuthCtrl', ['$rootScope', '$location',function ($scope, $location) {
	console.log($scope.currentUser);
	if($scope.currentUser){
		console.log('redirecting');
		$location.path( '/myCourses' );
	}
}])
.run(['$rootScope', '$location', function($scope, $location) {
	Parse.initialize('29wOKycz8F6JaRXHNttPXiynbGOFKUqOYAZvKZVc', '4iNIqeEGthAqjMAhYRIz5JVF1hKDnsTBDCPomf5o');
	$scope.scenario = 'Sign up';
	$scope.currentUser = Parse.User.current();


	$scope.signUp = function(form) {
		var user = new Parse.User();
		user.set('email', form.email);
		user.set('username', form.username);
		user.set('password', form.password);

		user.signUp(null, {
			success: function(user) {
				$scope.currentUser = user;
				$scope.$apply();
			},
			error: function(user, error) {
				alert('Unable to sign up:  ' + error.code + ' ' + error.message);
			}
		});
	};

	$scope.logIn = function(form) {
		console.log(form);

		Parse.User.logIn(form.username, form.password, {
			success: function(user) {
				$scope.currentUser = user;
				$scope.$apply();
				$location.path( '/myCourses' );
			},
			error: function(user, error) {
				alert('Unable to log in: ' + error.code + ' ' + error.message);
			}
		});
	};

	$scope.logOut = function(form) {
		form = form;
		Parse.User.logOut();
		$scope.currentUser = null;
	};
}]);
