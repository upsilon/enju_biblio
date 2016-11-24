class ApplicationController < ActionController::Base
  protect_from_forgery

  include EnjuBiblio::Controller
  include EnjuLibrary::Controller
  include EnjuEvent::Controller
  include EnjuSubject::Controller
  include EnjuInventory::Controller
  before_action :set_paper_trail_whodunnit
  after_action :verify_authorized

  include Pundit
end
