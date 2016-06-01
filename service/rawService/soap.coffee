# soap-client.coffee
soap = require 'soap'
Logger = require('vair_log').Logger

module.exports.getClient = (wsdl, callback) ->
	log = Logger.getLogger()
	soap.createClient wsdl, (err, client) ->
		if err?
			log.error "connect to avantik service fail: #{err}"
			throw "get client fail: #{err}"
			return callback err, null
		else 
			log.info "get client successful"
			return callback null, client