class Employment < ApplicationRecord
  validates :year, :collectivity, :contract_type, :position, presence: true

  def parity
    result = (women_number.fdiv(women_number + men_number) * 100)

    (result - 50).abs <= 15 ? "respectée" : "non respectée"
  end
end
