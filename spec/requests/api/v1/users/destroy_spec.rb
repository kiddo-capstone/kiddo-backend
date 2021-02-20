describe 'user destroy api' do
  it 'can destroy a user' do
    user = create(:user)
    expect(User.count).to eq(1)
    delete "/api/v1/users/#{user.id}"
    expect(response).to be_successful
    expect(User.count).to eq(0)
    expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
