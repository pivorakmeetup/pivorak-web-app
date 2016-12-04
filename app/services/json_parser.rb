class JsonParser
  def self.call(json)
    Oj.load(json)
  end
end
