class Form::Beacon::Attachment::Announcement
  include Form::Beacon::BaseAttachment
  attr_accessor :category, :subject, :content, :attachment

  def initialize(attributes={})
    super
    # Set Deafault Value
    @attachment_type = 'Announcement'
  end

  def data
    Form::Beacon::Attachment::AnnouncementDataSerializer.new(self).to_json.to_s
  end
end
