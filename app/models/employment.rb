class Employment < ApplicationRecord
  validates :year, :collectivity, :contract_type, :position, presence: true
end
