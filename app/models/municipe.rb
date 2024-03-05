class Municipe < ApplicationRecord
  has_many :addresses

  validates :full_name, :cpf, :cns, :email, :birth, :phone, :photo, :status, presence: true
end
