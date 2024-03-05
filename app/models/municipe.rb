class Municipe < ApplicationRecord
  has_many :addresses

  validates :full_name, :cpf, :cns, :birth, :phone, :photo, :status, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :cpf_validation, :cns_validation

  private

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
end
