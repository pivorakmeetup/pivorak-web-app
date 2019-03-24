# frozen_string_literal: true

require 'csv'

task import_users: :environment do
  puts 'Import started'

  User.transaction do
    CSV.foreach(File.join(File.dirname(__FILE__), 'pivorakers_list.csv')) do |row|
      # 0 first_name last_name
      # 1 email
      puts $INPUT_LINE_NUMBER
      user = User.new(email:      row[1],
                      first_name: row[0].split(' ')[0],
                      last_name:  row[0].split(' ')[1])
      user.synthetic = true
      user.verified = true
      user.skip_confirmation!
      user.password = SecureRandom.hex(16)
      user.save!
    end
  end

  puts 'Import finished'
end
