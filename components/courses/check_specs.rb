require 'colorize'
require 'pry'

class CheckSpec
  def self.check
    new.check
  end

  attr_reader :layers

  def initialize
    @layers = %i[finders policies services]
  end

  def check
    layers.each do |layer|
      Dir["app/#{layer}/courses/**/*.rb"].each do |file|
        output *check_spec_exists(file, layer)
      end
    end
  end

  private

  def check_spec_exists(file, layer)
    code_file   = file.split('/')[-1].split('.rb').first
    domain_name = file.split('/')[-2]
    spec_file   = "spec/#{layer}/courses/#{domain_name}/#{code_file}_spec.rb"

    [File.exist?(spec_file), file]
  end

  def output(exists, code_file)
    color = exists ? :green : :red
    puts code_file.send(color)
  end
end

CheckSpec.check
