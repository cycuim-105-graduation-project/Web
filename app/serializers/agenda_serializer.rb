class AgendaSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :indoor_level, :speaker, :start_at_date,
             :start_at_time, :end_at_time

  def indoor_level
    object.indoor_level.name
  end

  def speaker
    {
      name: object.speaker.name,
      description: object.speaker.description,
      image: object.speaker.image.url
    } if object.speaker.present?
  end

  def start_at_time
    object.start_at.strftime("%R")
  end

  def end_at_time
    object.end_at.strftime("%R")
  end
end
