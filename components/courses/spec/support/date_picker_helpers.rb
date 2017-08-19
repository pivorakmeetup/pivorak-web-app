module Courses
  module Test
    module DatePickerHelpers
      def pick_a_date(field_name, date = Time.now)
        select(date.strftime('%Y'),  from: "#{field_name}_1i")
        select(date.strftime('%B'),  from: "#{field_name}_2i")
        select(date.strftime('%-e'), from: "#{field_name}_3i")
        select(date.strftime('%H'),  from: "#{field_name}_4i")
        select(date.strftime('%M'),  from: "#{field_name}_5i")
      end
    end
  end
end
