require 'rails_helper'

RSpec.describe Address, type: :model do
  context 'relationships' do
    it { should belong_to(:municipe) }
  end

  context 'validations' do
    let(:address) { build(:address) }

    it 'is valid with valid attributes' do
      expect(address).to be_valid
    end

    it 'is not valid without a street' do
      address.street = nil
      expect(address).not_to be_valid
      expect(address.errors[:street]).to include("can't be blank")
    end

    it 'is not valid without a neighborhood' do
      address.neighborhood = nil
      expect(address).not_to be_valid
      expect(address.errors[:neighborhood]).to include("can't be blank")
    end

    it 'is not valid without a city' do
      address.city = nil
      expect(address).not_to be_valid
      expect(address.errors[:city]).to include("can't be blank")
    end

    it 'is not valid without a uf' do
      address.uf = nil
      expect(address).not_to be_valid
      expect(address.errors[:uf]).to include("can't be blank")
    end

    it 'is not valid with a uf that is not 2 characters long' do
      address.uf = 'ABC'
      expect(address).not_to be_valid
      expect(address.errors[:uf]).to include("is the wrong length (should be 2 characters)")
    end

    it 'is valid without an ibge_code' do
      address.ibge_code = nil
      expect(address).to be_valid
    end

    it 'is valid without a complement' do
      address.complement = nil
      expect(address).to be_valid
    end
  end
end
