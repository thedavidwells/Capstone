'use strict';

describe('Service: Parseservices', function () {

  // load the service's module
  beforeEach(module('lessonPlannerApp'));

  // instantiate service
  var Parseservices;
  beforeEach(inject(function (_Parseservices_) {
    Parseservices = _Parseservices_;
  }));

  it('should do something', function () {
    expect(!!Parseservices).toBe(true);
  });

});
