class Address < ApplicationRecord
  belongs_to :municipe

  scope :filter_by_street, -> (street) { where("street ILIKE ?", "%#{street}%") if street.present? }
  scope :filter_by_complement, -> (complement) { where("complement ILIKE ?", "%#{complement}%") if complement.present? }
  scope :filter_by_neighborhood, -> (neighborhood) { where("neighborhood ILIKE ?", "%#{neighborhood}%") if neighborhood.present? }
  scope :filter_by_city, -> (city) { where("city ILIKE ?", "%#{city}%") if city.present? }
  scope :filter_by_uf, -> (uf) { where(uf: uf) if uf.present? }
  scope :filter_by_ibge_code, -> (ibge_code) { where(ibge_code: ibge_code) if ibge_code.present? }

  validates :street, :neighborhood, :city, :uf, presence: true
  validates :uf, length: { is: 2 }
end
