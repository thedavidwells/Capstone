'use strict';

describe('Controller: MylessonsCtrl', function () {

  // load the controller's module
  beforeEach(module('lessonPlannerApp'));

  var MylessonsCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    MylessonsCtrl = $controller('MylessonsCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
