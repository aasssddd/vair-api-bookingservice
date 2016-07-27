# service-init.coffee
Cookie = require 'soap-cookie'
Logger = require('vair_log').Logger
{parseString} = require 'xml2js'

module.exports.serviceInit = (client, options, callback) ->
	log = Logger.getLogger()
	options = 
		strUserName: options.strUserName ? ""
		strAgencyCode: options.strAgencyCode ? ""
		strPassword: options.strPassword ? ""
		# strLanguageCode: "ZH"

	# console.log "request: #{JSON.stringify options}"
	client.ServiceInitialize options, (err, soapResult) ->
		# log.info "raw request: #{client.lastRequest}"
		# log.info "raw response: #{client.lastResponse}"
		
		if err?
			log.error "initialize fail: #{err}"
			throw err
			return callback err, null
		else
			parseString soapResult.ServiceInitializeResult, (err, parsedResult) ->
				if err?
					log.error "initialize result is not an xml: #{err}"
					throw err
				if "#{parsedResult.error.code}" != "000"
					log.warn "error login credential"
					return callback "initialize fail", null
				cookie = new Cookie client.lastResponseHeaders
				client.setSecurity cookie
				return callback null, client
