module Protobuffness
  class Schema
    attr_reader :fields
    def initialize(fields)
      @fields = fields
    end

    def field_for(name)
      fields.find{ |field| field.name == name }
    end
  end
end
