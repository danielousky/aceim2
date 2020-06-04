class CoursePeriod < ApplicationRecord
  #========== RELATIONSHIPS ==========#
  
  belongs_to :course
  belongs_to :period
  # has_one :language, through: :course, dependent: :nullify
  has_many :sections
  accepts_nested_attributes_for :sections

  has_many :academic_records, through: :sections
  accepts_nested_attributes_for :academic_records

  # has_one :language, through: :course
  # accepts_nested_attributes_for :language
  
  #========== VALIDATIONS ==========#
  validates :course_id, presence: true
  validates :period_id, presence: true
  validates :kind, presence: true
  enum kind: [:online, :interdiario, :sabatino, :mixtos]

  after_create :create_first_section
  #========== SCOPE ==================#

  #========== RAILS ADMIN ============= #


  rails_admin do

    # import do
    #   mapping_key = [:period_id, :language_id, :level_id]
    #   mapping_key_list [:period_id, :language_id, :level_id]
    # end

    list do

      # field :period do
      #   label 'Periodo'
      #   formatted_value do
      #     bindings[:object].period.name
      #   end
      #   filterable true
      #   searchable true
      # end

      field :language do
        label 'Idioma'
        formatted_value do
          bindings[:object].course.language.name
        end
        # filterable true
        # searchable true
      end

      field :level do
        label 'Nivel'
        formatted_value do
          bindings[:object].course.level.name
        end
        # filterable true
        # searchable true
      end

      # field :course do
      #   label 'curso'
      # end
      field :period do
        label 'periodo'
        filterable true
        searchable true
      end
      field :kind do
        label 'tipo'
      end
      field :sections do
        label 'secciones'
        filterable true
        searchable true
      end
    end

    edit do
      field :course do
        label 'curso'
      end
      field :period do
        label 'periodo'
      end
      field :kind do
        label 'Tipo'
      end
    end

  end
  

  #========== FUNCTIONS =============#
  def language
    course.language if course
  end

  def before_import_save(record)
    if (letter_aux, year_aux = record[:period_id].split("-")) && (period = Period.where(year: year_aux, letter: letter_aux).first)
      self.period_id = period.id
    end
    if (course = Course.where(language_id: record[:language_id], level_id: record[:level_id]).first)
      self.course_id = course.id
    end
    self.kind = :Mixtos
  end

  def description_inscription
    "#{course.name} para el período #{period.name} en la modalidad #{kind.capitalize}"
  end

  def name
    (self.period and self.course) ? "#{self.period.name}:#{self.course.name}" : "#{self.id}"
  end

  protected

  def create_first_section
    sections.create(number: '1') unless sections.any?
  end

end
