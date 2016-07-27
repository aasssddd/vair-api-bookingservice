# flightAvailibility.coffee
config = require 'app-config'
{parseString} = require 'xml2js'

module.exports = (client, opts, callback) ->
	req = 
		strAgencyCode: config.booking_service.agencyCode
		strPassword: config.booking_service.password
		strOrigin: opts.origin ? "TPE"
		strDestination: opts.dest
		strDepartFrom: opts.departDate
		strDepartTo: opts.departDate
		strReturnFrom: opts.returnDate ? undefined
		strReturnTo: opts.returnDate ? undefined
		iAdult: opts.adult ? 1
		iChild: opts.child ? 0
		iInfant: opts.infant ? 0
		iOther: opts.other ? 0
		strBookingClass: opts.bookingClass ? undefined
		strPromoCode: opts.promoCode ? undefined

	client.FlightAvailability req, (err, result) ->
		# console.log "request header: #{JSON.stringify client.lastRequestHeaders}"
		# console.log "request: #{client.lastRequest}"
		# console.log "response: #{client.lastResponse}"
		if err?
			throw err
		else
			parseString result.FlightAvailabilityResult, (err, parseResult) ->
				callback err, parseResult