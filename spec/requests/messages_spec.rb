require 'rails_helper'

RSpec.describe "Messages", type: :request do
  apiVersion = '/api/v1'

  before do
    # create test data
    @application = FactoryBot.create(:application, name: 'Test Application', token: 'f66811c5-1079-4bcb-9f4c-5223f90fd2db-1763245480')
    @chat = FactoryBot.create(:chat, application_id: @application.id, number: 1)
  end

  describe "GET /index" do
    it "returns http success" do
      get "#{apiVersion}/applications/#{@application.token}/chats/#{@chat.number}/messages"
      expect(response).to have_http_status(:success)
    end
  end
end
