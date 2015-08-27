window.oplernoApp.factory 'CartIO', [ '$resource', ($resource) ->
  args = {}
  methods =
    query:
      method: 'GET',
      isArray: true

  CartIO = $resource '/carts/mycart.json', args, methods

  return CartIO
]
