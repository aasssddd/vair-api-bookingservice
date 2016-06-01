# service-facade.coffee
{parseString} = require 'xml2js'
config = require '../config'
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
				booking.itinerary.getItinerary authorizedClient, pnr, (err, result) ->
					callback err, result

	@getPassengerManifest = (args, callback) ->
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
				booking.pxManifest.getPassengerManifest authorizedClient, args, (err, data) ->
					return callback err, data

module.exports = ServiceCtl