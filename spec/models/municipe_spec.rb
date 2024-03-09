require 'rails_helper'

RSpec.describe Municipe, type: :model do
  context 'relationships' do
    it { should have_many(:addresses) }
  end

  context 'scopes' do
    let!(:municipe_01) do
      create(
        :municipe,
        full_name: 'Maria da Silva',
        cpf: '60877957908',
        cns: '199406843140000',
        email: 'maria.silva@example.com',
        birth: '1980-01-01',
        phone: '(93) 98258-2760',
        status: 'active'
      )
    end

    let!(:municipe_01_address) do
      create(
        :address,
        municipe: municipe_01,
        street: 'Rails Street',
        complement: 'Apt 221B',
        neighborhood: 'Marylebone',
        city: 'London',
        uf: 'LN',
        ibge_code: '12345'
      )
    end

    let!(:municipe_02) do
      create(
        :municipe,
        full_name: 'Pedro Alves',
        cpf: '13228595587',
        cns: '794482561550000',
        email: 'pedro.alves@example.com',
        birth: '1987-01-01',
        phone: '(68) 98328-2233',
        status: 'inactive'
      )
    end

    let!(:municipe_02_address) do
      create(
        :address,
        municipe: municipe_02,
        street: 'Ruby Street',
        complement: 'Near of the three',
        neighborhood: 'Ciy',
        city: 'London',
        uf: 'LN',
        ibge_code: '987634'
      )
    end

    let!(:municipe_03) do
      create(
        :municipe,
        full_name: 'Jose da Silva',
        cpf: '03664608976',
        cns: '961853722450006',
        email: 'jose.silva@example.com',
        birth: '1989-01-01',
        phone: '(71) 97238-1445',
        status: 'active'
      )
    end

    let!(:municipe_03_address) do
      create(
        :address,
        municipe: municipe_03,
        street: 'Another Street',
        complement: 'Another complement',
        neighborhood: 'Eldorado',
        city: 'Another City',
        uf: 'SP',
        ibge_code: '237812'
      )
    end

    context '.filter_by_full_name' do
      it 'returns municipe that match the full_name' do
        result = described_class.filter_by_full_name('Maria')

        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end

      it 'is case insensitive' do
        result = described_class.filter_by_full_name('pedro alves')

        expect(result).to include(municipe_02)
      end

      it 'returns municipes that partially match the full name' do
        resul = described_class.filter_by_full_name('Silva')

        expect(resul).to include(municipe_01, municipe_03)
        expect(resul).not_to include(municipe_02)
      end
    end

    context '.filter_by_cpf' do
      it 'returns municipes with the given CPF' do
        result = described_class.filter_by_cpf('60877957908')

        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end

      it 'returns an empty collection when no municipes match the given CPF' do
        result = described_class.filter_by_cpf('00000000000')

        expect(result).to be_empty
      end

      it 'returns all municipes if the CPF is not present' do
        result_01 = described_class.filter_by_cpf(nil)
        result_02 = described_class.filter_by_cpf('')

        expect(result_01).to include(municipe_01, municipe_02, municipe_03)
        expect(result_02).to include(municipe_01, municipe_02, municipe_03)
      end
    end

    context '.filter_by_cns' do
      it 'returns municipes with the given CNS' do
        result = described_class.filter_by_cns('199406843140000')

        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end

      it 'returns an empty collection when no municipes match the given CNS' do
        result = described_class.filter_by_cns('000000000000000')

        expect(result).to be_empty
      end

      it 'returns all municipes if the CNS is not present' do
        result_01 = described_class.filter_by_cns(nil)
        result_02 = described_class.filter_by_cns('')

        expect(result_01).to include(municipe_01, municipe_02, municipe_03)
        expect(result_02).to include(municipe_01, municipe_02, municipe_03)
      end
    end

    context '.filter_by_email' do
      it 'returns municipes that match the email' do
        result = described_class.filter_by_email('maria.silva@example.com')

        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end

      it 'is case insensitive' do
        result = described_class.filter_by_email('MARIA.SILVA@EXAMPLE.COM')
        expect(result).to include(municipe_01)
      end

      it 'returns municipes that partially match the email' do
        result = described_class.filter_by_email('silva')

        expect(result).to include(municipe_01, municipe_03)
        expect(result).not_to include(municipe_02)
      end

      it 'returns an empty collection when no municipes match the given email' do
        result = described_class.filter_by_email('nonexistent@example.com')

        expect(result).to be_empty
      end

      it 'returns all municipes if the email is not present' do
        result_01 = described_class.filter_by_email(nil)
        result_02 = described_class.filter_by_email('')

        expect(result_01).to include(municipe_01, municipe_02, municipe_03)
        expect(result_02).to include(municipe_01, municipe_02, municipe_03)
      end
    end

    context '.filter_by_birth' do
      it 'returns municipes with the given birth date' do
        expect(described_class.filter_by_birth('1980-01-01')).to include(municipe_01)
        expect(described_class.filter_by_birth('1980-01-01')).not_to include(municipe_02, municipe_03)
      end

      it 'returns an empty collection when no municipes match the given birth date' do
        expect(described_class.filter_by_birth('2000-01-01')).to be_empty
      end

      it 'returns all municipes if the birth date is not present' do
        expect(described_class.filter_by_birth(nil)).to include(municipe_01, municipe_02, municipe_03)
        expect(described_class.filter_by_birth('')).to include(municipe_01, municipe_02, municipe_03)
      end
    end

    context '.filter_by_phone' do
      it 'returns municipes with the given phone number' do
        expect(described_class.filter_by_phone('(93) 98258-2760')).to include(municipe_01)
        expect(described_class.filter_by_phone('(93) 98258-2760')).not_to include(municipe_02, municipe_03)
      end

      it 'returns an empty collection when no municipes match the given phone number' do
        expect(described_class.filter_by_phone('(00) 00000-0000')).to be_empty
      end

      it 'returns all municipes if the phone number is not present' do
        expect(described_class.filter_by_phone(nil)).to include(municipe_01, municipe_02, municipe_03)
        expect(described_class.filter_by_phone('')).to include(municipe_01, municipe_02, municipe_03)
      end
    end

    context '.filter_by_status' do
      it 'returns municipes with the given status' do
        expect(described_class.filter_by_status('active')).to include(municipe_01, municipe_03)
        expect(described_class.filter_by_status('active')).not_to include(municipe_02)
      end

      it 'returns an empty collection when no municipes match the given status' do
        expect(described_class.filter_by_status('pending')).to be_empty
      end

      it 'returns all municipes if the status is not present' do
        expect(described_class.filter_by_status(nil)).to include(municipe_01, municipe_02, municipe_03)
        expect(described_class.filter_by_status('')).to include(municipe_01, municipe_02, municipe_03)
      end
    end

    describe '.filter_by_street' do
      it 'returns municipes that match the street' do
        result = described_class.filter_by_street('Rails Street')
        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end
    end

    describe '.filter_by_neighborhood' do
      it 'returns municipes that match the neighborhood' do
        result = described_class.filter_by_neighborhood('Marylebone')

        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end
    end

    describe '.filter_by_city' do
      it 'returns municipes that match the city' do
        result = described_class.filter_by_city('London')

        expect(result).to include(municipe_01, municipe_02)
        expect(result).not_to include(municipe_03)
      end
    end

    describe '.filter_by_uf' do
      it 'returns municipes that match the UF' do
        result = described_class.filter_by_uf('LN')

        expect(result).to include(municipe_01, municipe_02)
        expect(result).not_to include(municipe_03)
      end
    end

    describe '.filter_by_ibge_code' do
      it 'returns municipes that match the IBGE code' do
        result = described_class.filter_by_ibge_code('12345')

        expect(result).to include(municipe_01)
        expect(result).not_to include(municipe_02, municipe_03)
      end
    end
  end

  context 'validations' do
    let(:municipe) { build(:municipe) }

    it 'is valid with valid attributes' do
      expect(municipe).to be_valid
    end

    it 'is not valid without a full_name' do
      municipe.full_name = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:full_name]).to include("can't be blank")
    end

    it 'is not valid without a cpf' do
      municipe.cpf = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:cpf]).to include("can't be blank")
    end

    it 'is not valid without a cns' do
      municipe.cns = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:cns]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      municipe.email = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:email]).to include("can't be blank")
    end

    it 'is not valid without an birth' do
      municipe.birth = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:birth]).to include("can't be blank")
    end

    it 'is not valid without an phone' do
      municipe.phone = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:phone]).to include("can't be blank")
    end

    it 'is not valid without an photo' do
      municipe.photo = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:photo]).to include("can't be blank")
    end

    it 'is not valid without an status' do
      municipe.status = nil

      expect(municipe).not_to be_valid
      expect(municipe.errors[:status]).to include("can't be blank")
    end

    context 'email validation' do
      let(:municipe) { build(:municipe, email: 'test@example.com') }

      it 'is valid with a valid email' do
        expect(municipe).to be_valid
      end

      it 'is invalid with an invalid email' do
        municipe.email = 'invalid_email'
        municipe.valid?

        expect(municipe.errors[:email]).to include("is invalid")
      end
    end

    context 'birth date validation' do
      let(:municipe) { build(:municipe, birth: 30.years.ago) }

      it 'is valid with a reasonable birth date' do
        expect(municipe).to be_valid
      end

      it 'is invalid with a future birth date' do
        municipe.birth = Date.tomorrow
        municipe.valid?

        expect(municipe.errors[:birth]).to include('cannot be in the future')
      end

      it 'is invalid with an unlikely birth date' do
        municipe.birth = 130.years.ago
        municipe.valid?

        expect(municipe.errors[:birth]).to include('is unlikely')
      end
    end

    context 'CNS validation' do
      let(:municipe) { build(:municipe) }

      it 'is valid with a valid CNS number' do
        expect(municipe).to be_valid
      end

      it 'is invalid with an invalid CNS number' do
        municipe.cns = 'invalid_cns'
        municipe.valid?

        expect(municipe.errors[:cns]).to include('is not valid')
      end

      it 'is invalid with an incorrect length' do
        municipe.cns = '123'
        municipe.valid?

        expect(municipe.errors[:cns]).to include('is not valid')
      end

      it 'is invalid with non-numeric characters' do
        municipe.cns = 'abcd12345678901'
        municipe.valid?

        expect(municipe.errors[:cns]).to include('is not valid')
      end
    end
  end

  context 'photo attachment' do
    let(:municipe) { build(:municipe) }

    it 'allows photo to be attached' do
      municipe.photo.attach(io: File.open(Rails.root.join('spec/support/uploads/image_for_test.png')), filename: 'image_for_test.png', content_type: 'image/png')

      expect(municipe.photo).to be_attached
    end
  end
end
