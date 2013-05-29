console.log "Must write some tests.."

should = require('should')
sleepsort = require('../lib/rssfeed-local')

describe 'rssfeed', ->
    describe 'feed list without logging', ->
        it 'gives error', (done) ->
            RssfeedLocal.feeds (err, feeds) ->
              should.exist err
              done()
