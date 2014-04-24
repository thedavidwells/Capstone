'use strict';

describe('Controller: EditschoolCtrl', function () {

  // load the controller's module
  beforeEach(module('lessonPlannerApp'));

  var EditschoolCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    EditschoolCtrl = $controller('EditschoolCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
