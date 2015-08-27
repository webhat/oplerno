'use strict'
window.oplernoApp.service 'CartModel', [ 'CartIO', 'timeAgo', (CartIO, timeAgo) ->
  timeAgo.settings.allowFuture = true

  CartSession = ->
    this.data = {}
    this.created = Date.NOW

  CartSession.prototype.fetch = (query) ->
    self = this

    CartIO.query query, (result) ->
      self.data = result

  new CartSession()
]
