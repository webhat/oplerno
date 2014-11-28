require 'podio_crm'
PodioCrm.setup(username: ENV['PODIO_USERNAME'], password: ENV['PODIO_PASSWORD'], api_key: ENV['PODIO_CID'], api_secret: ENV['PODIO_SECRET'])
