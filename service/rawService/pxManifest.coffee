# passengers-manifest.coffee
{parseString} = require 'xml2js'

module.exports.getPassengerManifest = (client, opts, callback) ->
	request = 
		PassengersManifestRequest:
			origin_rcd: opts.origin_rcd ? undefined
			destination_rcd: opts.destination_rcd ? undefined
			airline_rcd: opts.airline_rcd ? undefined
			flight_number: opts.flight_number ? undefined
			departure_date_from: opts.departure_date_from ? undefined
			departure_date_to: opts.departure_date_to ? undefined
			bReturnServices: opts.bReturnServices ? undefined
			bReturnRemarks: opts.bReturnRemarks ? undefined
			bNotCheckedIn: opts.bNotCheckedIn ? undefined
			bOffloaded: opts.bOffloaded ? undefined
			bNoShow: opts.bNoShow ? undefined
			bInfants: opts.bInfants ? undefined
			bConfimed: opts.bConfirmed ? undefined
			bWaitlisted: opts.bWaitlisted ? undefined
			bCancelled: opts.bCancelled ? undefined
			bStandby: opts.bStandby ? undefined
			bIndividual: opts.bIndividual ? undefined
			bGroup: opts.bGroup ? undefined
			bTransit: opts.bTransit ? undefined

	client.GetPassengerManifest request, (err, result) ->
		# console.log "request header: #{JSON.stringify client.lastRequestHeaders}"
		# console.log "request: #{client.lastRequest}"
		# console.log "response: #{client.lastResponse}"
		if err?
			throw err
		else
			parseString result.GetPassengerManifestResult, (err, parseResult) ->
				callback err, parseResult
