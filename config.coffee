# config.coffee
module.exports = 
	manifest_service:
		wsdl: "https://passenger.manifest.wsdl.url"
		userName: "user name"
		agencyCode: "agency code"
		password: "password"
	itinerary_service:
		wsdl: "http://itinerary.service.wsdl.url"
		userName: "user name"
		agencyCode: "agency code"
		password: "password"
		faultToranceTimes: 3