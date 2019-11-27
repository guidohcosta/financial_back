require 'rails_helper'

RSpec.describe AdService, type: :service do
  describe '.authenticate' do
    subject { described_class.authenticate(username) }
    let(:username) { 'admin' }

    it { is_expected.to include 'group' => 'financial' }
  end
end
