RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    import

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

RailsAdminImport.config do |config| 
  config.model Team do
    # excluded_fields do
    #   [:local_team_matches, :away_team_matches, :leagues]
    # end
    label :name
    # extra_fields do
      # [:avatar]
    # end
  end
end

# RailsAdminImport.config do |config| 
#   config.model Team do

#     # Fields to make available for import (whitelist)
#     included_fields do
#       [:name]
#     end

#     # Fields to skip (blacklist)
#     excluded_fields do
#       [:avatar]
#     end

#     # Custom methods to get/set the values on? (Not in use?)
#     # extra_fields do
#     #   [:field3, :field4, :field5]
#     # end

#     # Name of the method on the model to use in alert messages indicating success/failure of import
#     label :name

#     # Specifies the field to use to find existing records (when nil, admin page shows dropdown with options)
#     # update_lookup_field do
#     #   :email
#     # end

#     # map fields to an RSS feed
#     # rss_mapping do
#     #   {
#     #     :title => Proc.new{ |item| item.title  + item.published.to_s },
#     #     :body => Proc.new{ |item| item.summary },
#     #     :published_at => Proc.new{ |item| item.published }
#     #   }
#     # end

#     # Define instance methods to be hooked into the import process, if special/additional processing is required on the data
#     # before_import_save do
#     #   # block must return an object that responds to the "call" method
#     #   lambda do |model, row, map|
#     #     # skip confirmation email when importing Devise User model
#     #     model.skip_confirmation!
#     #   end
#     # end
#   end
# end
