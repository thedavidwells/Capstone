'use strict';

describe('Controller: EditcourseCtrl', function () {

  // load the controller's module
  beforeEach(module('lessonPlannerApp'));

  var EditcourseCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    EditcourseCtrl = $controller('EditcourseCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
