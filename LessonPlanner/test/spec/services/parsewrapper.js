'use strict';

describe('Service: parseWrapper', function () {

  // load the service's module
  beforeEach(module('lessonPlannerApp'));

  // instantiate service
  var parseWrapper;
  beforeEach(inject(function (_parseWrapper_) {
    parseWrapper = _parseWrapper_;
  }));

  it('should do something', function () {
    expect(!!parseWrapper).toBe(true);
  });

});
