# soap-client.coffee
soap = require 'soap'
Logger = require('vair_log').Logger
constants = require 'constants'
https = require 'https'
HttpClient = require '../core/http.js'

module.exports.getClient = (wsdl, callback) ->
	log = Logger.getLogger()
	soap.createClient wsdl, {httpClient: new HttpClient()}, (err, client) ->
		
		if err?
			log.error "connect to avantik service fail: #{err}"
			throw "get client fail: #{err}"
			return callback err, null
		else 
			return callback null, client