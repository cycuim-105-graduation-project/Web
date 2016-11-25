class Form::BeaconSerializer < ActiveModel::Serializer
  attributes :advertisedId, :status, :placeId, :latLng, :indoorLevel,
             :expectedStability, :description, :properties

  def advertisedId
    {
      type: object.beacon_type,
      id: object.advertised_id
    }
  end

  def placeId
    object.place_id
  end

  def latLng
    {
      latitude: object.latitude,
      longitude: object.longitude
    }
  end

  def indoorLevel
    {
      name: object.indoor_level
    }
  end

  def expectedStability
    object.expected_stability
  end
end
