require 'json'

module Cronofy
  # Internal: Class for dealing with the parsing of API responses.
  class ResponseParser
    def initialize(response)
      @response = response
    end

    def parse_collection(type, attribute = nil)
      target = parsing_target(attribute)
      target.map { |item| type.new(item) }
    end

    def parse_json(type, attribute = nil)
      target = parsing_target(attribute)
      type.new(target)
    end

    def json
      json_hash.dup
    end

    private

    def json_hash
      @json_hash ||= JSON.parse(@response.body)
    end

    def parsing_target(attribute)
      if attribute
        json_hash[attribute]
      else
        json_hash
      end
    end
  end
end
