require 'rails_helper'

RSpec.describe JsonWebToken, type: :lib do
  let(:user_data) do
    { username: 'admin', groups: 'full' }
  end

  describe '#encode'do
    subject { described_class.encode(user_data) }
    before { expect(JWT).to receive(:encode).once.and_return('') }

    it { is_expected.to be_a String }
  end

  describe '#decode'do
    subject { described_class.decode('token') }
    let(:token) do
      'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwiZ3JvdXBzIjoiZnVsbC' \
      'IsImV4cCI6MTU3NDkxMzgyNn0.ZH8d_z_3qzQG3EWEOB2BByhOZyrA9DjQ9CtK1tBbyrQ'
    end
    before { expect(JWT).to receive(:decode).once.and_return(user_data) }

    it { is_expected.to be_a Hash }
  end
end
