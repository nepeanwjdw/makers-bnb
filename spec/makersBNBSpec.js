'use strict';

describe('Test', function() {

  var test

  it('can say hello', function() {
    test = new Test()
    expect(test.hello()).toEqual("Hello")
  })

})
