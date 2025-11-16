require 'rails_helper'

RSpec.describe "Applications", type: :request do
  apiVersion = '/api/v1'

  before do
    # create test data
    @application = FactoryBot.create(:application, name: 'Test Application', token: 'f66811c5-1079-4bcb-9f4c-5223f90fd2db-1763245480')
    @application2 = FactoryBot.create(:application, name: 'Test Application 2', token: 'da458f4a-f907-4b36-8728-e035a487f378-1763155721')
  end

  describe "GET /applications" do
    it "returns http success" do
      get "#{apiVersion}/applications"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'return by limit' do
      get "#{apiVersion}/applications", params: { limit: 1 }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return page & limit' do
      get "#{apiVersion}/applications", params: { page: 0, limit: 1 }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'POST /applications' do
    it 'add a new application' do
      expect {
        post "#{apiVersion}/applications", params: { application: { name: 'Test Application 3' } }
      }.to change(Application, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /applications' do
    it 'edit application' do
      patch "#{apiVersion}/applications/#{@application.token}", params: { application: { name: 'Test Application 4' } }

      expect(response).to have_http_status(:success)
    end
  end
end
