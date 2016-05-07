# validates partners image dimensions
class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    val = value.queued_for_write[:original]
    return unless val
    width = get_width(record)
    height = get_height(record)
    dimensions = Paperclip::Geometry.from_file(val.path)
    position = record.position
    errors = record.errors[attribute]

    if dimensions.width != width
      errors << "Для позиции #{position} ширина банера должна быть #{width}px"
    end

    if dimensions.height != height
      errors << "Для позиции #{position} высота банера должна быть #{height}px"
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
