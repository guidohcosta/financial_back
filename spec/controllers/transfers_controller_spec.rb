require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  describe '#POST create' do
    before do
      allow(JsonWebToken).to receive(:decode).
        and_return({ groups: group_mock })
    end

    subject { JSON.parse(response.body) }

    let(:token) do
      { token: 'token' }
    end
    let(:default_params) do
      { account_id: '1', amount: '200' }
    end
    let(:expected) do
      default_params.merge(id: 1)
    end

    context 'with valid token' do
      before do
        expect(LegacyService).to receive(:transfer).
          once.
          with(default_params).
          and_return(expected)
        post :create, params: default_params.merge(token)
      end

      let(:group_mock) { 'financial' }

      it { expect(response).to have_http_status(:success) }
      it { is_expected.to include 'id' }
      it { is_expected.to include 'account_id' => '1' }
      it { is_expected.to include 'amount' => '200' }
      it { expect(Log.count).to be 1 }
    end

    context 'with invalid token' do
      before do
        post :create, params: default_params.merge(token)
      end
      let(:group_mock) { 'common' }

      it { expect(response).to have_http_status(401) }
      it { is_expected.to include 'error' => 'Unauthorized' }
      it { expect(Log.count).to be 1 }
    end

    context 'without token' do
      before do
        post :create, params: default_params
      end
      let(:group_mock) { 'common' }

      it { expect(response).to have_http_status(401) }
      it { is_expected.to include 'error' => 'Token is missing' }
      it { expect(Log.count).to be 0 }
    end
  end
end
