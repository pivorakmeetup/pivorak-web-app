# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    "<div class='ui date-time-picker calendar'> <div class='ui input left icon'> <i class='calendar icon'></i> #{@builder.text_field(attribute_name, merged_input_options)} </div> </div>".html_safe
  end
end
# rubocop:enable Metrics/LineLength
