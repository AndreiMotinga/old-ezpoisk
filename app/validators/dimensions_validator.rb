# validates partners image dimensions
class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.queued_for_write[:original]
    width = get_width(record)
    height = get_height(record)
    dimensions = Paperclip::Geometry.from_file(
      value.queued_for_write[:original].path
    )

    unless dimensions.width == width
      msg = "Для позиции #{record.position} ширина банера должна быть #{width}px"
      record.errors[attribute] << msg
    end

    unless dimensions.height == height
      msg = "Для позиции #{record.position} высота банера должна быть #{height}px"
      record.errors[attribute] << msg
    end
  end

  private

  def get_width(record)
    case record.position
    when "Вверху"
      1170
    when "Справа"
      420
    when "Внизу"
      680
    end
  end

  def get_height(record)
    case record.position
    when "Вверху"
      160
    when "Справа"
      160
    when "Внизу"
      160
    end
  end
end
