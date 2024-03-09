class Municipe < ApplicationRecord
  # after_create :send_registration_confirmation
  # after_update :send_status_change_notification, if: :saved_change_to_status?

  has_many :addresses, dependent: :destroy

  scope :filter_by_full_name, ->(full_name) { where("full_name ILIKE ?", "%#{full_name}%") }
  scope :filter_by_cpf, -> (cpf) { where(cpf: cpf) if cpf.present? }
  scope :filter_by_cns, -> (cns) { where(cns: cns) if cns.present? }
  scope :filter_by_email, -> (email) { where("email ILIKE ?", "%#{email}%") if email.present? }
  scope :filter_by_birth, -> (birth) { where(birth: birth) if birth.present? }
  scope :filter_by_phone, -> (phone) { where("phone LIKE ?", "%#{phone}%") if phone.present? }
  scope :filter_by_status, -> (status) { where(status: status) if status.present? }

  scope :filter_by_street, -> (street) { joins(:addresses).merge(Address.filter_by_street(street)) if street.present? }
  scope :filter_by_neighborhood, -> (neighborhood) { joins(:addresses).merge(Address.filter_by_neighborhood(neighborhood)) if neighborhood.present? }
  scope :filter_by_city, -> (city) { joins(:addresses).merge(Address.filter_by_city(city)) if city.present? }
  scope :filter_by_uf, -> (uf) { joins(:addresses).merge(Address.filter_by_uf(uf)) if uf.present? }
  scope :filter_by_ibge_code, -> (ibge_code) { joins(:addresses).merge(Address.filter_by_ibge_code(ibge_code)) if ibge_code.present? }

  validates :full_name, :cpf, :cns, :birth, :phone, :photo, :status, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :cpf_validation, :cns_validation, :birth_validation

  has_one_attached :photo

  private

  def send_registration_confirmation
    MunicipeMailer.registration_confirmation(self).deliver_later
  end

  def send_status_change_notification
    MunicipeMailer.status_change_notification(self).deliver_later
  end

  def cpf_validation
    errors.add(:cpf, "is not valid") unless CPF.valid?(cpf)
  end

  def cns_validation
    return if cns.blank?

    cns_numbers = cns.gsub(/\D/, '')

    return errors.add(:cns, 'is not valid') unless cns_numbers.length == 15

    sum_numbers = cns_numbers.chars.map.with_index { |char, index| char.to_i * (15 - index) }.sum

    unless sum_numbers % 11 == 0
      errors.add(:cns, 'is not valid')
    end
  end

  def birth_validation
    return if birth.blank?

    if birth > Date.today
      errors.add(:birth, 'cannot be in the future')
    elsif Date.today.year - birth.year > 120
      errors.add(:birth, 'is unlikely')
    end
  end
end
