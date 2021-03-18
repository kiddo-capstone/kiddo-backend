require 'rails_helper'

describe 'reward create api' do
  before :each do
    @parent = create(:parent)
    @user = create(:user)
  end

  it 'create a reward' do
    reward = {
      title: 'reward 1',
      points_to_redeem: 30,
      parent_id: @parent.id,
      user_id: @user.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/rewards', headers: headers, params: JSON.generate(reward)
    created_reward = Reward.last
    expect(response).to be_successful
    expect(created_reward.title).to eq(reward[:title])
  end

  it 'it will not create reward without points_to_redeem' do
    reward = {
      title: 'reward 1',
      parent_id: @parent.id,
      user_id: @user.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/rewards', headers: headers, params: JSON.generate(reward)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to be_a(String)
  end

  it 'it will not create reward without title' do
    reward = {
      points_to_redeem: 30,
      parent_id: @parent.id,
      user_id: @user.id
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/rewards', headers: headers, params: JSON.generate(reward)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to be_a(String)
  end

  it 'can destroy a reward' do
    reward = create(:reward)
    expect(Reward.count).to eq(1)
    delete "/api/v1/rewards/#{reward.id}"
    expect(response).to be_successful
    expect(Reward.count).to eq(0)
    expect{ Reward.find(reward.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'sends an error json when tryign to destroy an invalid reward' do

    delete "/api/v1/rewards/17"
    expect(response.status).to eq(400)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Unable to destroy reward.", :status=>"bad_request"}}
    expect(expected).to eq(response_body)
  end

  it 'can update a reward' do
    reward = {
      title: 'reward 1',
      points_to_redeem: 25,
      parent_id: @parent.id,
      user_id: @user.id
    }
    reward_params = {
      redeemed: true
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/rewards', headers: headers, params: JSON.generate(reward)
    updated_reward = Reward.last

    patch api_v1_reward_path(updated_reward.id), headers: headers, params: JSON.generate(reward_params)
    updated_reward.reload
    expect(updated_reward.title).to eq('reward 1')
    expect(updated_reward.points_to_redeem).to eq(25)
    expect(updated_reward.redeemed).to eq(true)
  end

  it 'cannot update a reward with empty title' do
    reward = {
      title: 'reward 1',
      points_to_redeem: 30,
      parent_id: @parent.id,
      user_id: @user.id
    }
    reward_params = {
      title: '',
      points_to_redeem: 25,
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/rewards', headers: headers, params: JSON.generate(reward)
    updated_reward = Reward.last
    patch api_v1_reward_path(updated_reward.id), headers: headers, params: JSON.generate(reward_params)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Title can't be blank")
  end

  it 'cannot update a reward with letters in numbers title' do
    reward = {
      title: 'reward 1',
      points_to_redeem: 30,
      parent_id: @parent.id,
      user_id: @user.id
    }
    reward_params = {
      points_to_redeem: 'abc',
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/rewards', headers: headers, params: JSON.generate(reward)
    updated_reward = Reward.last

    patch api_v1_reward_path(updated_reward.id), headers: headers, params: JSON.generate(reward_params)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points to redeem is not a number")
  end

end
