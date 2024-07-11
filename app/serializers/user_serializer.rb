module UserSerializer
  require 'active_support/core_ext/string'

  def serialized_hash
    atttributes = { id:, first_name:, last_name:, email: }
    atttributes.transform_keys { |key| key.to_s.camelize(:lower) }
  end
end
