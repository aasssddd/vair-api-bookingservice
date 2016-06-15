# itinerary.coffee
Logger = require('vair_log').Logger
{parseString} = require 'xml2js'
async = require 'async'

log = Logger.getLogger()

module.exports.getItinerary = (client, pnr, faultToranceTimes, callback) ->
	try_count  = faultToranceTimes
	retry = true

	async.whilst ->
		return try_count > 0 and retry
	, (callback) ->
		try_count--
		getItineraryData client, pnr, (err, result) ->
			if err? and try_count > 0
				log.warn "get data failed, retry"
				callback err, null
			else 
				retry = false
				callback null, result
	, (err, result) ->
		parseItineraryResult result.BookingGetItineraryResult, (err, parsedResult) ->
			if err?
				log.error "result is not an xml: #{err}"
				return callback err, null
			return callback null, parsedResult


getItineraryData = (client, pnr, callback) ->
	client.BookingGetItinerary {strRecordLocator: pnr}, (err, soapResult) ->
		if err?
			log.error "fail calling getItinerary service: #{err}"
			return callback err, null
		else if not soapResult.BookingGetItineraryResult
			log.warn "PNR #{pnr} info is empty"
			log.warn "Result is: #{JSON.stringify soapResult}"
			return callback "PNR #{pnr} info is empty", null
		return callback null, soapResult

parseItineraryResult = (data, callback) ->
	parseString data, (err, parsedResult) ->
			if err?
				log.error "result is not an xml: #{err}"
				throw err
				return callback err, null
			return callback null, parsedResult