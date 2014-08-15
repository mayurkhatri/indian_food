class StartTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)

  end
end

module ActiveModel::Validations::HelperMethods
  def validates_start_time(*attr_names)
    validates_with StartTimeValidator, _merge_attributes(attr_names)
  end
end
