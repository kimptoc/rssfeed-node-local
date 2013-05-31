
LocalStorage = require("node-localstorage").LocalStorage
global.localStorage = new LocalStorage('storage')

store = require "store"

get_key = (collection, key) ->
  collection+"-"+key


class FeedStore

  initialize: ->
    console.log "FeedStore ctor"


# collection: name, key: id, value: obj
  add: (params) ->
    @c = params.collection
    @k = params.key
    @v = params.value
    store.set(get_key(@c,@k), @v)

# collection: name, key: id
  find: (params) ->
    @c = params.collection
    @k = params.key
    return store.get(get_key(@c,@k))

module.exports = new FeedStore()