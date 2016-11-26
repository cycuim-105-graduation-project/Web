class Form::Beacon
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :beacon_type, :namespace, :instance, :advertised_id, :status,
                :place_id, :longitude, :latitude, :indoor_level, :expected_stability,
                :description, :properties

  def initialize(attributes={})
    super
    # Set Deafault Value
    @beacon_type ||= "EDDYSTONE"
    @status      ||= "ACTIVE"
    @expected_stability ||= "STABLE"
  end

  def advertised_id
    # Calculate advertised_id with Eddystone UID
    # https://developers.google.com/beacons/proximity/register
    @advertised_id ||= Base64.encode64 [@namespace + @instance].pack("H*").gsub("\n", "")
  end

  def namespace
    @namespace ||= Base64.decode64(@advertised_id).unpack("H*")[0].first(20)
  end

  def instance
    @instance  ||= Base64.decode64(@advertised_id).unpack("H*")[0].last(12)
  end

  def beacon_object
    Google::Apis::ProximitybeaconV1beta1::Beacon.new(
      advertised_id: advertised_object,
      status: self.status
    )
  end

  def advertised_object
    Google::Apis::ProximitybeaconV1beta1::AdvertisedId.new(
      id: [@namespace + @instance].pack("H*"),
      type: "EDDYSTONE"
    )
  end
end
