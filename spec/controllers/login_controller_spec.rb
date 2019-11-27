require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe '#POST create' do
    before { do_create }

    let(:do_create) { post :create, params: login_params }
    let(:login_params) do
      { user: 'admin', password: 'password' }
    end

    subject { JSON.parse(response.body) }

    it { expect(response).to have_http_status(:success) }
    it { is_expected.to include 'token' }
    it { expect(subject['token']).to be_a String }
    it { expect(Log.count).to be 1 }
  end
end
