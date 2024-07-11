module UserSerializer
  include Serializer

  private

  def attributes
    { id:, first_name:, last_name:, email: }
  end
end
