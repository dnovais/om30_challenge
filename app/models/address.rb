class Address < ApplicationRecord
  belongs_to :municipe

  validates :street, :neighborhood, :city, :uf, presence: true
  validates :uf, length: { is: 2 }
end
