class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :feature_img_url, :start_at, :end_at,
             :registration_start_at, :registration_end_at, :quantity, :vacancy,
             :place

  def feature_img_url
    object.feature_img.url
  end

  def place
    object.place.name
  end

  def start_at
    object.start_at.strftime("%Y/%m/%d %H:%M")
  end

  def end_at
    object.end_at.strftime("%Y/%m/%d %H:%M")
  end

  def registration_start_at
    object.registration_start_at.strftime("%Y/%m/%d %H:%M")
  end

  def registration_end_at
    object.registration_end_at.strftime("%Y/%m/%d %H:%M")
  end
end
