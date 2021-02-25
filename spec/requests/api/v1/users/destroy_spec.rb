require 'rails_helper'

describe 'user destroy api' do
  it 'can destroy a user' do
    calvin = User.create(name: 'Calvin',
                         email: 'Calvin@example.com',
                         auth_token: SecureRandom.uuid)

    body = {
             email: calvin.email,
             auth_token: calvin.auth_token
           }

    expect(User.count).to eq(1)
    delete "/api/v1/users/#{calvin.id}", headers: headers, params: JSON.generate(body)
    expect(response).to be_successful
    expect(User.count).to eq(0)
    expect{ User.find(calvin.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
