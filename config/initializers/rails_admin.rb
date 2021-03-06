RailsAdmin.config do |config|
  # require 'i18n'
  # I18n.default_locale = 'es'
  # Se produce un error `<top (required)>'

  ### Popular gems integration
  config.main_app_name = Proc.new { |controller| [ "Aceim", "Admin - #{controller.params[:action].try(:titleize)}" ] }
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.sidescroll = {num_frozen_columns: false}

  # Details sidescroll:
  # https://github.com/sferik/rails_admin/wiki/Horizontally-scrolling-table-with-frozen-columns-in-list-view

  config.default_items_per_page = 50
  # Máximos items por Páginas

  config.configure_with(:import) do |config|
    config.logging = true
    config.line_item_limit = 30000
    config.update_if_exists = false
    config.rollback_on_error = false
    # config.header_converter = lambda do |header|
    #   header.parameterize.underscore if header.present?
    # end
    config.csv_options = {}
  end


  # ActiveRecord::Base.connection.tables.each do |model|
    
  #   config.model "#{model.capitalize.singularize.camelize}" do
  #     list do
  #       checkboxes false
  #       exclude_fields :created_at, :updated_at
  #     end
  #   end

  # end


  # ActiveRecord::Base.descendants.each do |imodel| 
  #   config.model "#{imodel.name}" do
  #     list do
  #       checkboxes false
  #       exclude_fields :created_at, :updated_at
  #     end
  #   end
  # end


#   config.model 'Language' do
#    object_label_method do
#      :custom_label_method
#    end
#  end

#  def custom_label_method
#    "#{self.name}"
#  end

  config.excluded_models = ["Item"]
  # config.excluded_models << "Item"


  ## == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  PAPER_TRAIL_AUDIT_MODEL = ['AcademicRecord', 'PartialQualification', 'PaymentDetail', 'Section', 'Student']

  config.actions do
    dashboard                     # mandatory
    index do                        # mandatory
      # except [QualificationDetail, Career, Course]
      except [QualificationStatus, QualificationDetail, Career, Course, PartialQualification, HistorialAcademico]
      # Estudiar comportamiento: https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb
      # show_in_sidebar [User, Section]
    end
    new
    export
    import
    # bulk_delete
    show
    edit
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    # HELP: https://github.com/sferik/rails_admin/wiki/Papertrail
    # history_index
    # history_show

    history_index do
      only PAPER_TRAIL_AUDIT_MODEL
      # controller :my_test_action
    end
    history_show do
      only PAPER_TRAIL_AUDIT_MODEL
    end

  end

  config.model "PaperTrail::Version" do
    visible false
  end

  config.model "PaperTrail::VersionAssociation" do
    visible false
  end

  config.model "ActionText::RichText" do
    visible false
  end

  config.model "ActiveStorage::Blob" do
    visible false
  end
  config.model "ActiveStorage::Attachment" do
    visible false
  end


end
