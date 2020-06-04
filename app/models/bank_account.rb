class BankAccount < ApplicationRecord
  # ========== RELATIONSHIPS ============ #
  
  belongs_to :bank

  # ========== VALIDATIONS ============ #
  
  validates :id, presence: true
  validates :number, presence: true
  validates :holder, presence: true
  validates :bank_id, presence: true

  # ========== RAILS ADMIN ============ #
  rails_admin do
    edit do
      field :id do
        label 'Identificador'
      end
      field :number do
        label 'Número'
      end
      field :holder do
        label 'Titular'
      end
      field :bank do
        label 'Banco'
      end
    end
  end

end
