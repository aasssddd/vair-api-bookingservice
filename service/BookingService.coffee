soap = require 'soap'
Cookie = require 'soap-cookie'
getLogger = require 'vair_log'
{parseString} = require 'xml2js'

wsdl = "https://vair_secure.avantik.io/tikAeroWebAPI/BookingService.asmx?WSDL"

log = getLogger "info", {name: "itinerary.log", path: "./log"}


#  initialize query
module.exports.serviceInit = (client, callback) ->
	options = 
		strUserName: "softmobile"
		strAgencyCode: "B2C"
		strPassword: "qazwsx"
		# strLanguageCode: "ZH"

	client.ServiceInitialize options, (err, soapResult) ->
		if err?
			log.error "initialize fail: #{err}"
			throw err
			return callback err, null
		else
			parseString soapResult.ServiceInitializeResult, (err, parsedResult) ->
				if err?
					log.error "initialize result is not an xml: #{err}"
					throw err
					return callback err, null
				log.info "raw request: #{client.lastRequest}"
				log.info "ServiceInitializeResult is #{JSON.stringify parsedResult}"
				if "#{parsedResult.error.code}" != "000"
					log.warn "error login credential"
					return callback "initialize fail", null
				cookie = new Cookie client.lastResponseHeaders
				client.setSecurity cookie
				return callback null, client

module.exports.getItinerary = (client, pnr, callback) ->
	client.BookingGetItinerary {strRecordLocator: pnr}, (err, soapResult) ->
		if err?
			log.error "fail calling getItinerary service: #{err}"
			return callback err, null
		parseString soapResult.BookingGetItineraryResult, (err, parsedResult) ->
			if err?
				log.error "result is not an xml: #{err}"
				throw err
				return callback err, null
			log.info "#{JSON.stringify parsedResult}"
			return callback null, parsedResult





module.exports.getClient = (pnr, callback) ->
	soap.createClient wsdl, (err, client) ->
		if err?
			log.error "connect to avantik service fail: #{err}"
			throw err
			return callback err, null
		else 
			return callback null, client


