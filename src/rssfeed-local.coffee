feed_store = require './feed-store'
_ = require 'underscore'

FEEDS_COLL = 'feeds'

class RssfeedLocal

  constructor: ->
    @requires_login = false
    @logged_in = false
    @token1 = undefined
    @token2 = undefined
    @next_index = _.keys(feed_store.all()).length + 1
    # console.log "Next store index:#{@next_index}"


  login: (token1, token2, callback) ->
    err = undefined
    if @token1 == token1 and @token2 == token2
      @logged_in = true
    else
      @logged_in = false
      err = "login failed"
    callback?(err)

  setLogin: (token1, token2) ->
    @token1 = token1
    @token2 = token2

  feeds: (callback) ->
    # console.log("feeds called")
    if @requires_login == true and @logged_in == false
      callback?(new Error("boo"), undefined)
    else
      feed_urls = feed_store.find_all collection:FEEDS_COLL
      callback?(undefined, _.values(feed_urls))

  add: (feed_url, callback) ->
    if @requires_login == true and @logged_in == false
      callback?(new Error("boo"), undefined)
    else
      feed_store.add collection:FEEDS_COLL, key:@next_index, value:{feed_url,key:@next_index}
      @next_index++
      callback?()

  requiresLogin: ->
    @requires_login

  setRequiresLogin: (requires_login) ->
    @requires_login = requires_login

  clear: (callback)->
    if @requires_login == true and @logged_in == false
      callback?(new Error("boo"), undefined)
    else
      feed_store.clear()
      @next_index = 1
      callback?()


module.exports = new RssfeedLocal()
