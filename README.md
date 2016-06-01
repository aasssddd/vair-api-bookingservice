# Itinerary Service #

## Usage ##

	npm start

## Service List ##

### Get Itinerary of specified PRL ###

##### METHOD #####
GET
##### URL #####
    http://somehost:someport/booking/itinerary/{prl}


### Get Passenger Manifest ###

##### METHOD #####
POST

##### URL #####
    http://somehost:someport/booking/passengerManifest

##### Payload (Example) #####
    { 
        "origin_rcd": "TPE",
        "destination_rcd": "DMK",
        "airline_rcd": "ZV",
        "flight_number": "006",
        "departure_date_from": "2016-06-01",
        "departure_date_to": "2016-06-01",
        "bReturnServices": false,
        "bReturnRemarks": false,
        "bNotCheckedIn": true,
        "bOffloaded": false,
        "bNoShow": true,
        "bInfants": true,
        "bConfirmed": false,
        "bWaitlisted": false,
        "bCancelled": false,
        "bStandby": false,
        "bIndividual": true,
        "bGroup": true,
        "bTransit": true
    }
