# config.coffee
module.exports = 
	manifest_service:
		wsdl: "http://vair.avantik.io/TikAeroWebAPI_PM/BookingService.asmx?WSDL"
		userName: "softmobile"
		agencyCode: "softmobile"
		password: "softmobile1234"
	itinerary_service:
		wsdl: "https://vair_secure.avantik.io/tikAeroWebAPI/BookingService.asmx?WSDL"
		userName: "softmobile"
		agencyCode: "B2C"
		password: "B2C135"
		faultToranceTimes: 3