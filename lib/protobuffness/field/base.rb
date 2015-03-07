module Protobuffness
  module Field
    class Base
      attr_reader :name, :order, :rule

      def initialize(rule, name, order)
        @rule = rule
        @name = name
        @order = order
      end
    end
  end
end
