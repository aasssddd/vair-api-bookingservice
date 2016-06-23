# itinerary.coffee
Logger = require('vair_log').Logger
{parseString} = require 'xml2js'
async = require 'async'

log = Logger.getLogger()

class Itinerary

	constructor: (@faultToranceTimes) ->


	getItinerary: (client, pnr, faultToranceTimes, callback) ->
		try_count  = faultToranceTimes
		retry = true
		getItineraryData = @getItineraryData
		parseItineraryResult = @parseItineraryResult

		async.whilst ->
			if try_count < faultToranceTimes and retry
				log.warn "get itinerary of PNR: #{pnr} fail, #{try_count} retry times remain"
			return try_count > 0 and retry
		, (cb) ->
			try_count = try_count - 1
			getItineraryData client, pnr, (err, result) ->
				if err? and try_count > 0 
					log.warn "get data failed, retry"
					cb null, null
				else 
					retry = false
					cb null, result
		, (err, result) ->
			if result?
				parseItineraryResult result.BookingGetItineraryResult, (err, parsedResult) ->
					if err?
						log.error "result is not an xml: #{err}"
						return callback err, null
					return callback null, parsedResult
			callback null, null


	getItineraryData: (client, pnr, callback) ->
		client.BookingGetItinerary {strRecordLocator: pnr}, (err, soapResult) ->
			if err?
				log.error "fail calling getItinerary service: #{err}"
				callback err, null
			else if not soapResult.BookingGetItineraryResult
				log.warn "PNR #{pnr} info is empty"
				log.warn "Result is: #{JSON.stringify soapResult}"
				callback "PNR #{pnr} info is empty", null
			else
				return callback null, soapResult

	parseItineraryResult: (data, callback) ->
		parseString data, (err, parsedResult) ->
				if err?
					log.error "result is not an xml: #{err}"
					throw err
					return callback err, null
				return callback null, parsedResult

module.exports = Itinerary