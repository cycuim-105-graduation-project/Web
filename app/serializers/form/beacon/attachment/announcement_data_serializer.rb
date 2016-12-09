class Form::Beacon::Attachment::AnnouncementDataSerializer < ActiveModel::Serializer
  attributes :category, :subject, :content, :attachment
end
