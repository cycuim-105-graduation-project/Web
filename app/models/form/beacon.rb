require 'google/apis/proximitybeacon_v1beta1'

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
    @advertised_id ||= Base64.encode64 [@namespace + @instance].pack("H*").gsub("\n", "") if @namespace.present? && @instance.present?
  end

  def namespace
    @namespace ||= Base64.decode64(@advertised_id).unpack("H*")[0].first(20) if @advertised_id.present?
  end

  def instance
    @instance  ||= Base64.decode64(@advertised_id).unpack("H*")[0].last(12)  if @advertised_id.present?
  end

  def beacon_object
    Google::Apis::ProximitybeaconV1beta1::Beacon.new(
      advertised_id:      advertised_object,
      status:             self.status,
      place_id:           @place_id,
      indoor_level:       indoor_level_object,
      expected_stability: @expected_stability,
      description:        @description
    )
  end

  def advertised_object
    Google::Apis::ProximitybeaconV1beta1::AdvertisedId.new(
      id: [@namespace + @instance].pack("H*"),
      type: "EDDYSTONE"
    )
  end

  def indoor_level_object
    Google::Apis::ProximitybeaconV1beta1::IndoorLevel.new(name: @indoor_level)
  end

  def self.build_from_beacon_object(beacon_object)
    self.new(
      advertised_id:      Base64.encode64(beacon_object.advertised_id.id).gsub("\n", ""),
      beacon_type:        beacon_object.advertised_id.type,
      status:             beacon_object.status,
      expected_stability: beacon_object.expected_stability,
      indoor_level:       beacon_object.indoor_level&.name,
      description:        beacon_object.description,
      place_id:           beacon_object.place_id
    )
  end
end
