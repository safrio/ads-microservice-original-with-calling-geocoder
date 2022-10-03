module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      res = store_ad
      enrich_with_coords
      res
    end

    private

    def store_ad
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end

    def enrich_with_coords
      res = GeocoderService::Client.new.coordsByCity(@ad[:city])
      if res.is_a?(Array)
        @ad.lat, @ad.lon = res
        @ad.save
      end
    end
  end
end
