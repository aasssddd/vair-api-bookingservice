# itinerary.coffee
Logger = require('vair_log').Logger
{parseString} = require 'xml2js'

module.exports.getItinerary = (client, pnr, callback) ->
	log = Logger.getLogger()
	client.BookingGetItinerary {strRecordLocator: pnr}, (err, soapResult) ->
		if err?
			log.error "fail calling getItinerary service: #{err}"
			return callback err, null
		else if not soapResult.BookingGetItineraryResult
			log.warn "PNR #{pnr} info is empty"
			return callback "PNR #{pnr} info is empty", null

		parseString soapResult.BookingGetItineraryResult, (err, parsedResult) ->
			if err?
				log.error "result is not an xml: #{err}"
				throw err
				return callback err, null
			return callback null, parsedResult