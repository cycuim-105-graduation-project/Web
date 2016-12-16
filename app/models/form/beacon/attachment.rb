class Form::Beacon::Attachment
  include Form::Beacon::BaseAttachment

  attr_accessor :object
  def initialize(attributes={})
    super
  end

  def namespace
    @namespaced_type.split(/\//).first if @namespaced_type.present?
  end

  def attachment_type
    @namespaced_type.split(/\//).second if @namespaced_type.present?
  end

  def object
    {
      namespaced_type: @namespaced_type,
      attachment_name: @attachment_name,
      beacon_id: @beacon_id,
      namespace: self.namespace,
      attachment_type: self.attachment_type
    }.merge(JSON.parse(@data))
  end

  def attachment
    case self.attachment_type.downcase.to_sym
    when :announcement
      Form::Beacon::Attachment::Announcement.new(object)
    when :qestionnaire
      Form::Beacon::Attachment::Questionnaire.new(object)
    when :voting
      Form::Beacon::Attachment::Voting.new(object)
    when :indoorlevel
      Form::Beacon::Attachment::IndoorLevel.new(object)
    end
  end
end
