Logger = require('vair_log').Logger
restify = require 'restify'
ServiceCtl = require './service/service-facade'
domain = require 'domain'
tosource = require 'tosource'

# log = getLogger 'info', {name: "itinerary.log", path: "./log"}
log = Logger.getLogger()

d = domain.create()

d.on 'error', (err) ->
	log.error "Error occur: #{tosource err}"

d.run =>
	server = restify.createServer {
		name: "booking service",
		version: "1.0.0",
		log: log
	}

	server.use restify.acceptParser(server.acceptable)
	server.use restify.queryParser()
	server.use restify.bodyParser()

	server.post "/booking/passengerManifest", (req, res, next) ->
		opts = req.body
		ServiceCtl.getPassengerManifest opts, (err, data) ->
			if err?
				log.error "error occur #{err}"
				return res.json {code: "9000", message: err}
			return res.json {code:"0000", message: data}

	server.get "/booking/itinerary/:pnr", (req, res, next) ->
		# query itinerary by PNR
		log.info "retrieve request with params: #{JSON.stringify req.params}"
		pnr = req.params.pnr

		ServiceCtl.getItinerary pnr, (err, data) ->
			if err?
				log.error "error occur: #{err}"
				return res.json {code: "9000", message: err}
			return res.json {code: "0000", message: data}

	server.listen 8000, () ->
		log.info "#{server.name} is listen at #{server.url}"
		# console.log "#{server.name} is listen at #{server.url}"
