require 'rails_helper'

RSpec.describe Log, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :document }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :document }
  end
end
