require 'rails_helper'

RSpec.describe LegacyService, type: :service do
  describe '.transfer' do
    subject { described_class.transfer(transfer_params) }
    let(:transfer_params) do
      { account_id: 1, amount: 200 }
    end

    it { is_expected.to include 'id' }
    it { is_expected.to include 'account_id' => 1 }
    it { is_expected.to include 'amount' => 200 }
  end
end
