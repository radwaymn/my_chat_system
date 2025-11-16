require "rails_helper"

RSpec.describe Api::V1::ApplicationsController, type: :controller do
    it 'has max limit of 100' do
      expect(Application).to receive(:limit).with(100).and_call_original
      get :index, params: { limit: 999 }
    end
end
