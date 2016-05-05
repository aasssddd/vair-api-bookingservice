getLogger = require 'vair_log'
restify = require 'restify'
{getClient, serviceInit, getItinerary} = require './service/BookingService'

log = getLogger 'info', {name: "itinerary.log", path: "./log"}

server = restify.createServer {
	name: "booking service",
	version: "1.0.0"
}

server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()

server.get "/itinerary/:pnr", (req, res, next) ->
	# query itinerary by PNR
	log.info "retrieve request with params: #{JSON.stringify req.params}"
	pnr = req.params.pnr
	getClient pnr, (err, client) ->
		if err?
			log.error err
			return res.json {code: "9000", message: err}
		serviceInit client, (err, authorizedClient) ->
			if err?
				log.error err
				return res.json {code: "1000", message: err}
			getItinerary authorizedClient, pnr, (err, result) ->
				if err?
					log.error err
					return res.json {code: "2000", message: err}
				return res.json {code: "0000", message: result}



server.listen 8000, () ->
	log.info "#{server.name} is listen at #{server.url}"
	# console.log "#{server.name} is listen at #{server.url}"
