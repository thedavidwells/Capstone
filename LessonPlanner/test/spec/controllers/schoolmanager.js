'use strict';

describe('Controller: SchoolmanagerCtrl', function () {

  // load the controller's module
  beforeEach(module('lessonPlannerApp'));

  var SchoolmanagerCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    SchoolmanagerCtrl = $controller('SchoolmanagerCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});