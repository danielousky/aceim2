class Instructor < ApplicationRecord
  # ========== RELATIONSHIPS ============ #
  
  belongs_to :user, inverse_of: :instructor#, foreign_key: :user_id
  belongs_to :bank_account, optional: true, inverse_of: :instructors
  
  has_many :sections, inverse_of: :instructor, dependent: :nullify
  accepts_nested_attributes_for :sections

  # ========== VALIDATIONS ============ #
  validates :user, presence: true, uniqueness: true

  after_destroy :check_user_for_destroy
  before_save :set_nil_bank_account
  # ========== SCOPE ============ #

  # ========== RAILS ADMIN ============ #
  def before_import_save(record)
    self.user_id = record[:user_id]
    # if (email = record[:user_email]) && (user_aux = User.find_by_email(email))
      # self.user_id = user_aux.id
    self.active = record[:active]
    # end
  end
  scope :my_search, -> (keyword) { joins(:user).where("users.email LIKE '%#{keyword}%' OR users.email LIKE '%#{keyword}%' OR users.last_name LIKE '%#{keyword}%' OR users.number_phone LIKE '%#{keyword}%'") }


  #   scope :search, lambda { |clave| 
  #   where("ci LIKE ? OR nombres LIKE ? OR apellidos LIKE ? OR ci LIKE ? OR email LIKE ?","%#{clave}%","%#{clave}%","%#{clave}%", "%#{clave}%", "%#{clave}%")
  # }

  # scope :my_search, lambda { |clave| 
  #   joins(:user).where("MATCH(users.name, users.last_name, users.email, users.number_phone) AGAINST('#{clave}')")
  # }


  rails_admin do

    # import do
    #   mapping_key :user_id
    #   mapping_key_list [:active]
    # end
    show do
      field :description do
        label 'usuario'
        formatted_value do
          path = bindings[:view].show_path(model_name: 'User', id: bindings[:object].user_id)
          bindings[:view].link_to(bindings[:object].user.description, path )
        end
      end
      field :constancia do
        formatted_value do
          path = "/instructors/#{bindings[:object].id}/work_proof"
          bindings[:view].link_to('Generar Constancia', path, class: 'btn btn-sm btn-primary' )
        end        
      end

      field :active do
        label 'Activo'
      end
      field :sections do
        label 'Secciones'
      end
    end

    edit do

      field :user do
        label 'usuario'
      end

      # field :user do
      #   label 'usuario'
      #   formatted_value do
      #     bindings[:object].user.name if bindings[:object].user
      #   end
      # end

      field :ci
      field :rif
      field :active do
        label 'Activo'
      end
      field :bank_account do
        label 'Cuenta Bancaria'
      end
    end

    list do
      search_by :my_search
      field :name do
        label 'Nombre'
        formatted_value do
          bindings[:object].user.full_name_invert if bindings[:object].user
        end
      end

      field :email
      field :number_phone do
        label 'Teléfono'
      end

      field :total_sections do
        label 'Secciones'
      end

      field :languages do
        label 'Idiomas'
      end
      # Period.each do |pe|
        
      # end
      # fields :description
      # field :active do
      #   label 'Activo'
      # end
    end

  end 

  # ================ FUNCTIONS =================== #

  def any_blank?
    (!self.ci.blank? and !self.rif.blank? and self.user and !self.user.any_blank? and self.bank_account and !self.bank_account.any_blank?) ? false : true
  end

  def total_sections
    sections.count
  end

  def languages
    sections.map{|s| s.language.name}.uniq.to_sentence
  end

  def number_phone
    user ? user.number_phone : nil
  end

  def email
    user ? user.email : nil
  end

  def name
    "#{user.description}" if user
  end

  protected

  def check_user_for_destroy
    user_aux = User.find self.user_id
    user_aux.delete if user_aux.without_rol?
  end

  private

  def set_nil_bank_account
    self.bank_account_id = nil if self.bank_account_id.eql? ''
  end

end
