require 'rails_helper'

RSpec.describe Municipe, type: :model do
  context 'relationships' do
    it { should have_many(:addresses) }
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      municipe = build(:municipe)

      expect(municipe).to be_valid
    end

    it 'is not valid without a full_name' do
      municipe = build(:municipe, full_name: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:full_name]).to include("can't be blank")
    end

    it 'is not valid without a cpf' do
      municipe = build(:municipe, cpf: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:cpf]).to include("can't be blank")
    end

    it 'is not valid without a cns' do
      municipe = build(:municipe, cns: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:cns]).to include("can't be blank")
    end

    it 'is not valid without an email' do
      municipe = build(:municipe, email: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:email]).to include("can't be blank")
    end

    it 'is not valid without an birth' do
      municipe = build(:municipe, birth: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:birth]).to include("can't be blank")
    end

    it 'is not valid without an phone' do
      municipe = build(:municipe, phone: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:phone]).to include("can't be blank")
    end

    it 'is not valid without an photo' do
      municipe = build(:municipe, photo: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:photo]).to include("can't be blank")
    end

    it 'is not valid without an status' do
      municipe = build(:municipe, status: nil)

      expect(municipe).not_to be_valid
      expect(municipe.errors[:status]).to include("can't be blank")
    end
  end

  context 'email validation' do
    it 'is valid with a valid email' do
      municipe = build(:municipe, email: 'test@example.com')

      expect(municipe).to be_valid
    end

    it 'is invalid with an invalid email' do
      municipe = build(:municipe, email: 'invalid_email')
      municipe.valid?

      expect(municipe.errors[:email]).to include("is invalid")
    end
  end

  context 'birth date validation' do
    it 'is valid with a reasonable birth date' do
      municipe = build(:municipe, birth: 30.years.ago)

      expect(municipe).to be_valid
    end

    it 'is invalid with a future birth date' do
      municipe = build(:municipe, birth: Date.tomorrow)
      municipe.valid?

      expect(municipe.errors[:birth]).to include('cannot be in the future')
    end

    it 'is invalid with an unlikely birth date' do
      municipe = build(:municipe, birth: 130.years.ago)
      municipe.valid?

      expect(municipe.errors[:birth]).to include('is unlikely')
    end
  end

  context 'CNS validation' do
    it 'is valid with a valid CNS number' do
      municipe = build(:municipe)

      expect(municipe).to be_valid
    end

    it 'is invalid with an invalid CNS number' do
      municipe = build(:municipe, cns: 'invalid_cns')
      municipe.valid?

      expect(municipe.errors[:cns]).to include('is not valid')
    end

    it 'is invalid with an incorrect length' do
      municipe = build(:municipe, cns: '123')
      municipe.valid?

      expect(municipe.errors[:cns]).to include('is not valid')
    end

    it 'is invalid with non-numeric characters' do
      municipe = build(:municipe, cns: 'abcd12345678901')
      municipe.valid?

      expect(municipe.errors[:cns]).to include('is not valid')
    end
  end

  context 'photo attachment' do
    it 'allows photo to be attached' do
      municipe = FactoryBot.create(:municipe)
      municipe.photo.attach(io: File.open(Rails.root.join('spec/support/uploads/image_for_test.png')), filename: 'image_for_test.png', content_type: 'image/png')

      expect(municipe.photo).to be_attached
    end
  end
end
