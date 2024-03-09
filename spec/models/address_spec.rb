require 'rails_helper'

RSpec.describe Address, type: :model do
  before(:all) do
    @address_01 = create(
      :address,
      street: 'Baker Street',
      complement: 'Apt 221B',
      neighborhood: 'Marylebone',
      city: 'London',
      uf: 'LN',
      ibge_code: '12345'
    )

    @address_02 = create(
      :address,
      street: 'Fleet Street',
      complement: 'Near the pub',
      neighborhood: 'City of London',
      city: 'London',
      uf: 'LN',
      ibge_code: '67890'
    )

    @address_03 = create(
      :address,
      street: 'Elm Street',
      complement: '',
      neighborhood: 'Suburbia',
      city: 'Springwood',
      uf: 'SP',
      ibge_code: '54321'
    )
  end

  context 'relationships' do
    it { should belong_to(:municipe) }
  end

  context 'scopes' do
    let(:address_01) do
      create(
        :address,
        street: 'Baker Street',
        complement: 'Apt 221B',
        neighborhood: 'Marylebone',
        city: 'London',
        uf: 'LN',
        ibge_code: '12345'
      )
    end

    let(:address_02) do
      create(
        :address,
        street: 'Fleet Street',
        complement: 'Near the pub',
        neighborhood: 'City of London',
        city: 'London',
        uf: 'LN',
        ibge_code: '67890'
      )
    end

    let(:address_03) do
      create(
        :address,
        street: 'Elm Street',
        complement: '',
        neighborhood: 'Suburbia',
        city: 'Springwood',
        uf: 'SP',
        ibge_code: '54321'
      )
    end

    context '.filter_by_street' do
      it 'returns addresses that match the street' do
        expect(Address.filter_by_street('Baker')).to include(address_01)
        expect(Address.filter_by_street('Baker')).not_to include(address_02, address_03)
      end
    end

    context '.filter_by_complement' do
      it 'returns addresses that match the complement' do
        expect(Address.filter_by_complement('Apt 221B')).to include(address_01)
        expect(Address.filter_by_complement('Apt 221B')).not_to include(address_02, address_03)
      end
    end

    context '.filter_by_neighborhood' do
      it 'returns addresses that match the neighborhood' do
        expect(Address.filter_by_neighborhood('Marylebone')).to include(address_01)
        expect(Address.filter_by_neighborhood('Marylebone')).not_to include(address_02, address_03)
      end
    end

    context '.filter_by_city' do
      it 'returns addresses that match the city' do
        expect(Address.filter_by_city('London')).to include(address_01, address_02)
        expect(Address.filter_by_city('London')).not_to include(address_03)
      end
    end

    context '.filter_by_uf' do
      it 'returns addresses that match the UF' do
        expect(Address.filter_by_uf('LN')).to include(address_01, address_02)
        expect(Address.filter_by_uf('LN')).not_to include(address_03)
      end
    end

    context '.filter_by_ibge_code' do
      it 'returns addresses that match the ibge_code' do
        expect(Address.filter_by_ibge_code('12345')).to include(address_01)
        expect(Address.filter_by_ibge_code('12345')).not_to include(address_02, address_03)
      end
    end
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
