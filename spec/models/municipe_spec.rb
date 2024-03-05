require 'rails_helper'

RSpec.describe Municipe, type: :model do
  context 'relationships' do
    it { should have_many(:addresses) }
  end

  context 'validations' do
    context 'municipe' do
      it 'is not valid without required fields' do
        required_fields = [:full_name, :cpf, :cns, :email, :birth, :phone, :photo, :status]
        municipe = Municipe.new
    
        required_fields.each do |field|
          municipe[field] = nil
          expect(municipe).not_to be_valid
          expect(municipe.errors[field]).to include("can't be blank")
          municipe[field] = "some value"
        end
      end
    end
  end
end
