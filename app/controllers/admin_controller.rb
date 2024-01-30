class AdminController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if !current_user.is_labs_employee
      redirect_to "/"
    end
    @users = User.all
    @beta_users = @users.reject {|user| !user.beta_access || user.is_labs_employee}
    @reg_users = @users.select {|user| !user.beta_access}

    @orgs = Organization.all 
  end

  def grant
    @user = User.find(params[:id])
    @user.beta_access = true
    @user.save
    redirect_to "/admin"
  end

  def revoke
    @user = User.find(params[:id])
    @user.beta_access = false
    @user.save
    redirect_to "/admin"
  end

  def org_grant
    @org = Organization.find(params[:id])
    @org.owner.beta_access = true
    @org.owner.save
    @org.memberships.each do |mem|
      mem.user.beta_access = true
      mem.user.save
    end
    redirect_to "/admin"
  end

end
