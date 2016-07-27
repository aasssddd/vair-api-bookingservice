# getBooking.coffee
{parseString} = require 'xml2js'

module.exports = (client, options, callback) ->
	request = 
		bookingGetRequest:
			airline: options.airline ? undefined
			flightNumber: options.flightNumber ? undefined
			flightId: options.flightId ? undefined
			flightFrom: options.flightFrom ? undefined
			flightTo: options.flightTo ? undefined
			recordLocator: options.recordLocator ? undefined
			origin: options.origin ? undefined
			destination: options.destination ? undefined
			passengerName: options.passengerName ? undefined
			seatNumber: options.seatNumber ? undefined
			ticketNumber: options.ticketNumber ? undefined
			phoneNumber: options.phoneNumber ? undefined
			agencyCode: options.agencyCode ? undefined
			clientNumber: options.clientNumber ? undefined
			memberNumber: options.memberNumber ? undefined
			clientId: options.clientId ? undefined
			showHostory: options.showHostory ? undefined
			bIndividual: options.bIndividual ? undefined
			bGroup: options.bGroup ? undefined
			createFrom: options.createFrom ? undefined
			createTo: options.createTo ? undefined

	console.log "request: #{JSON.stringify request}"
	client.GetBookings request, (err, result) ->
		# console.log "request header: #{JSON.stringify client.lastRequestHeaders}"
		console.log "request: #{client.lastRequest}"
		console.log "response: #{client.lastResponse}"
		if err?
			throw err
		else
			# console.log "result: #{JSON.stringify result}"
			parseString result.GetBookingsResult, (err, parseResult) ->
				# console.log JSON.stringify parseResult
				callback err, parseResult


