module GeocoderService
  module Api
    def coordsByCity(city)
      connection.get('geocoder', { city: city })&.body
    end
  end
end