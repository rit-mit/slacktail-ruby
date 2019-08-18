require 'active_model'

module Slacktail
  module Channel
    class Parameter
      include ::ActiveModel::Model
      include ::ActiveModel::Attributes

      attribute :color
      attribute :include
      attribute :exclude
      attribute :interval
    end
  end
end
