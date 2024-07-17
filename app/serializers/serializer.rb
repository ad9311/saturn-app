module Serializer
  require 'active_support/core_ext/string'

  def serialized_hash(options = {})
    camelize = options.fetch(:camelize, true)
    return attributes(options) unless camelize

    attributes(options).transform_keys { |key| key.to_s.camelize(:lower) }
  end

  private

  def attributes(_options)
    raise NotImplementedError, 'Subclasses must define the `attributes` method'
  end
end
