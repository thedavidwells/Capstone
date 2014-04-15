'use strict';

describe('Controller: MycoursesCtrl', function () {

  // load the controller's module
  beforeEach(module('lessonPlannerApp'));

  var MycoursesCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MycoursesCtrl = $controller('MycoursesCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
