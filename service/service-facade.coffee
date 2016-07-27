# service-facade.coffee
{parseString} = require 'xml2js'
config = require 'app-config'
require_tree = require 'require-tree'
booking = require_tree './rawService'
tosource = require 'tosource'

class ServiceCtl	
	@getItinerary = (pnr, callback) ->
		wsdl = config.booking_service.wsdl
		options = 
			strUserName: config.booking_service.userName
			strAgencyCode: config.booking_service.agencyCode
			strPassword: config.booking_service.password 

		booking.soap.getClient wsdl, (err, client) ->
			if err?
				throw "get soap client fail: #{err}"
			booking.init.serviceInit client, options, (err, authorizedClient) ->
				if err?
					throw "service init fail #{err}"
				itinerary = new booking.itinerary config.itinerary_service.faultToranceTimes
				itinerary.getItinerary authorizedClient, pnr, config.itinerary_service.faultToranceTimes, (err, result) ->
					callback err, result

	@getPassengerManifest = (args, callback) ->
		wsdl = config.manifest_service.wsdl
		options = 
			strUserName: config.manifest_service.userName
			strAgencyCode: config.manifest_service.agencyCode
			strPassword: config.manifest_service.password
		booking.soap.getClient wsdl, (err, client) ->
			if err?
				throw err
			booking.init.serviceInit client, options, (err, authorizedClient) ->
				if err?
					throw err
				booking.pxManifest.getPassengerManifest authorizedClient, args, (err, data) ->
					return callback err, data

	@getBooking = (args, callback) ->
		wsdl = config.booking_service.wsdl
		options = 
			strUserName: config.booking_service.userName
			strAgencyCode: config.booking_service.agencyCode
			strPassword: config.booking_service.password
		booking.soap.getClient wsdl, (err, client) ->
			if err?
				throw err
			booking.init.serviceInit client, options, (err, authorizedClient) ->
				if err?
					throw err
				booking.getBooking authorizedClient, args, (err, data) ->
					return callback err, data

	@getFlightAvailability = (args, callback) ->
		wsdl = config.booking_service.wsdl
		booking.soap.getClient wsdl, (err, client) ->
			if err?
				throw err
			booking.flightAvailability client, args, (err, data) ->
				return callback err, data

module.exports = ServiceCtl