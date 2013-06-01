
LocalStorage = require("node-localstorage").LocalStorage
global.localStorage = new LocalStorage('storage')

store = require "store"

get_key = (collection, key) ->
  collection+"-"+key


class FeedStore

  initialize: ->
    console.log "FeedStore ctor"

# empty store
  clear: ->
    store.clear()

# collection: name, key: id, value: obj
  add: (params) ->
    c = params.collection
    k = params.key
    v = params.value
    store.set(get_key(c,k), {collection:c,key:k,value:v})

# collection: name, key: id
  find: (params) ->
    c = params.collection
    k = params.key
    wrapped_value = store.get(get_key(c, k))
    return wrapped_value?.value

  find_all: (params) ->
    c = params.collection
#    console.log JSON.stringify(c+"/"+JSON.stringify(store.getAll()))
    results = {}
    query_result = store.getAll()
    for own key of query_result
      wrapped_value = query_result[key]
      results[wrapped_value.key] = wrapped_value.value if wrapped_value.collection == c
    return results
    
module.exports = new FeedStore()