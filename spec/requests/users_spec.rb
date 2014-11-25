require 'rails_helper'

RSpec.describe 'Users', :type => :request do

  describe 'POST /users/sign_in.json' do
    context 'correct email and password' do
      it 'returns api_key' do
        user = create(:user)

        post api_sign_in_path, { email: user.email, password: 'password', format: :json }

        hash = JSON.parse(response.body)
        expect(hash['api_key']).to eq(user.api_key)
      end
    end

    context 'incorrect email or password' do
      it 'returns error' do
        user = create(:user)

        post api_sign_in_path, { email: user.email, password: 'password1', format: :json }

        hash = JSON.parse(response.body)
        expect(hash['error']['message']).to eq('Invalid email or password.')
      end
    end
  end

end
