'use strict';

describe('Controller: MyschoolCtrl', function () {

  // load the controller's module
  beforeEach(module('lessonPlannerApp'));

  var MyschoolCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MyschoolCtrl = $controller('MyschoolCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
