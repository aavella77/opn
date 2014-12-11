class HealthDataController < ApplicationController
  before_action :authenticate_user!, :only => [:data_explore, :data_reports, :medications]
  before_action :set_active_top_nav_link_to_health_data
  before_action :validate_oodt_module, :only => [:explore, :reports]
  before_action :validate_validic_module, :only => []

  layout "community"

  def validate_oodt_module
    raise "OODT must be enabled for this feature." if !Figaro.env.oodt_enabled
  end

  def validate_validic_module
    raise "Validic must be enabled for this feature." if !Figaro.env.validic_enabled
  end

  def index
    @check_in_questions = Group.find_by_name("Health Data Check In").questions
    @med_list = current_user ? current_user.get_med_list : {}
  end

end
