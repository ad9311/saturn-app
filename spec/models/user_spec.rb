require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) do
    @user = User.new(
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'Jon',
      last_name: 'Doe'
    )
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'creates a new user' do
    expect(@user.save).to be_truthy
  end
end
