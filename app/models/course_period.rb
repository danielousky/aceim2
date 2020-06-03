class CoursePeriod < ApplicationRecord
  #========== RELATIONSHIPS ==========#
  
  belongs_to :course
  belongs_to :period
  # has_one :language, through: :course, dependent: :nullify
  has_many :sections
  accepts_nested_attributes_for :sections

  has_many :academic_records, through: :sections
  accepts_nested_attributes_for :academic_records
  
  #========== VALIDATIONS ==========#
  validates :course_id, presence: true
  validates :period_id, presence: true
  validates :kind, presence: true
  enum kind: [:online, :interdiario, :sabatino, :mixtos]

  after_create :create_first_section
  #========== SCOPE ==========#

  #========== FUNCTIONS ==========#
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
