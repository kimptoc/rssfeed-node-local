
should = require 'should'
_ = require 'underscore'

feedstore = require('../lib/feed-store')

describe 'feed-store', ->
  describe 'store something', ->
    it 'store/retrieve', (done) ->
      testobj = {"id":2,3:"a"}
      feedstore.add collection:"test", key:testobj.id, value:testobj
      foundObj = feedstore.find collection:"test", key:testobj.id
      should.exist foundObj
      testobj.should.eql foundObj
      done()

    it 'store 2/retrieve 2', (done) ->
      testobj1 = {"id":2,3:"a"}
      testobj2 = {"id":3,3:"b"}
      feedstore.add collection:"test", key:testobj1.id, value:testobj1
      feedstore.add collection:"test", key:testobj2.id, value:testobj2
      foundObj1 = feedstore.find collection:"test", key:testobj1.id
      foundObj2 = feedstore.find collection:"test", key:testobj2.id
      should.exist foundObj1
      testobj1.should.eql foundObj1
      should.exist foundObj2
      testobj2.should.eql foundObj2
      done()

    it 'retrieve all in collection', (done) ->
      feedstore.clear()
      objs = feedstore.find_all collection:"test"
      should.exist objs
      _.keys(objs).length.should.equal 0

      testobj1 = {"id":2,3:"a"}
      testobj2 = {"id":3,3:"b"}
      feedstore.add collection:"test", key:testobj1.id, value:testobj1
      feedstore.add collection:"test", key:testobj2.id, value:testobj2
      objs = feedstore.find_all collection:"test"
      should.exist objs
      _.keys(objs).length.should.equal 2
      done()

    it 'retrieve all in collection, when several collections', (done) ->
      feedstore.clear()
      objs = feedstore.find_all collection:"test"
      should.exist objs
      _.keys(objs).length.should.equal 0

      testobj1 = {"id":2,3:"a"}
      testobj2 = {"id":3,3:"b"}
      testobj3 = {"id":4,3:"b"}
      feedstore.add collection:"test", key:testobj1.id, value:testobj1
      feedstore.add collection:"test", key:testobj2.id, value:testobj2
      feedstore.add collection:"test2", key:testobj3.id, value:testobj3
      objs = feedstore.find_all collection:"test"
      should.exist objs
      _.keys(objs).length.should.equal 2
      objs = feedstore.find_all collection:"test2"
      should.exist objs
      _.keys(objs).length.should.equal 1
      done()
