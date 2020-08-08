require 'active_model'

module Model
  module History
    module Content
      class Base
        include ::ActiveModel::Model
        include ::ActiveModel::Attributes

        def self.class_name
          name.split('::').last
        end

        def attribute_keys
          attributes.keys.map(&:to_sym)
        end

        def self.attribute_keys
          new.attribute_keys
        end
      end
    end
  end
end
