require "rails_helper"

RSpec.describe MunicipeMailer, type: :mailer do
  before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  context 'registration_confirmation' do
    let(:municipe) { create(:municipe) }
    let(:mail) { MunicipeMailer.registration_confirmation(municipe) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Registration Confirmation')
      expect(mail.to).to eq([municipe.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(municipe.full_name)
    end
  end

  context 'status_change_notification' do
    let(:municipe) { create(:municipe, status: 'ativo') }
    let(:mail) { MunicipeMailer.status_change_notification(municipe) }
  
    before do
      municipe.update(status: 'inativo')
    end
  
    it 'renders the headers' do
      expect(mail.subject).to eq('Status Change Notification')
      expect(mail.to).to eq([municipe.email])
      expect(mail.from).to eq(['from@example.com'])  # Adjust if you have a different sender email
    end
  
    it 'renders the body' do
      expect(mail.body.encoded).to match('Your new status is: inativo')
      expect(mail.body.encoded).to match(municipe.full_name)
    end
  end
end
