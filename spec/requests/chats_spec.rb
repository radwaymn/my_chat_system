require 'rails_helper'

RSpec.describe "Chats", type: :request do
  apiVersion = '/api/v1'

  before do
    # create test data
    @application = FactoryBot.create(:application, name: 'Test Application', token: 'f66811c5-1079-4bcb-9f4c-5223f90fd2db-1763245480')
    @chat = FactoryBot.create(:chat, application_id: @application.id, number: 1)
    @chat2 = FactoryBot.create(:chat, application_id: @application.id, number: 2)
  end

  describe "GET /chats" do
    it "returns http success" do
      get "#{apiVersion}/applications/#{@application.token}/chats"
      expect(response).to have_http_status(:success)
    end

    it 'return by limit' do
      get "#{apiVersion}/applications/#{@application.token}/chats", params: { limit: 1 }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return page & limit' do
      get "#{apiVersion}/applications/#{@application.token}/chats", params: { page: 0, limit: 1 }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'POST /chats' do
    it 'add a new chat' do
      key = "application:#{@application.id}:chats_buffer"
      REDIS.del(key)

      post "#{apiVersion}/applications/#{@application.token}/chats"

      FlushChatsJob.new.perform

      expect(Chat.count).to eq(3)

      expect(response).to have_http_status(:accepted)
    end
  end
end
