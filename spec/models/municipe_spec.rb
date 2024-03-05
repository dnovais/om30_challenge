require 'rails_helper'

RSpec.describe Municipe, type: :model do
  context 'relationships' do
    it { should have_many(:addresses) }
  end
end
