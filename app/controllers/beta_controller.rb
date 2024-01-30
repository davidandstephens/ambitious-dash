class BetaController < ApplicationController
  before_action :authenticate_user!

  def index
    if !current_user.beta_access || current_user.is_labs_employee
      redirect_to "/"
    end
  end
end
