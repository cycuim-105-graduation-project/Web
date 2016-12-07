require 'google/apis/proximitybeacon_v1beta1'

module Form::Beacon::BaseAttachment
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :attachment_type, :namespace, :data, :beacon_id, :namespaced_type, :attachment_name

    def namespaced_type
      "#{namespace}/#{attachment_type}" if @namespace.present? && @attachment_type.present?
    end

    def attachment_object
      Google::Apis::ProximitybeaconV1beta1::BeaconAttachment.new(
        namespaced_type: self.namespaced_type,
        data: [self.data].pack("H*")
      )
    end
  end
end
