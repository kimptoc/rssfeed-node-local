# RssfeedLocal = {} unless RssfeedLocal?

class RssfeedLocal

  constructor: ->
    @requires_login = false
    @logged_in = false
    @token1 = undefined
    @token2 = undefined


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
    console.log("feeds called")
    if @requires_login == true and @logged_in == false
      callback?(new Error("boo"), undefined)
    else
      callback?(undefined, [])

  requiresLogin: ->
    @requires_login

  setRequiresLogin: (requires_login) ->
    @requires_login = requires_login


module.exports = new RssfeedLocal()
