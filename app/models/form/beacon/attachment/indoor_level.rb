class Form::Beacon::Attachment::IndoorLevel
  include Form::Beacon::BaseAttachment
  attr_accessor :name

  def initialize(attributes={})
    super
    # Set Deafault Value
    @attachment_type = 'IndoorLevel'
  end

  def data
    Form::Beacon::Attachment::IndoorLevelDataSerializer.new(self).to_json.to_s
  end
end
