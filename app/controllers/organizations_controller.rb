class OrganizationsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  
  def index
    @organizations = Organization.all
    @organizations = @organizations.reject do |org|
      membership = org.memberships.where(user: current_user).first
      if !membership.nil?
        membership.rejected
      else
        false
      end
    end
    @owned_orgs = current_user.owned_organizations
  end

  def show
    @organization = Organization.find(params[:id])
    @user = current_user
    @membership = @organization.users.include?(@user) ? @organization.memberships.where(user: @user).first : Membership.new
    if !@membership.new_record?
      if @membership.rejected
        redirect_to organizations_path
      end
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(create_params)
    @organization.owner = current_user
    if @organization.save
      redirect_to organizations_path
    else
      # the new action is NOT being called
      # Assign any instance variables needed
      render("new")
    end
  end

  def edit
    @organization = Organization.find(params[:id])
    @user = current_user
    if !can? :update, @organization
      redirect_to organization_path(@organization)
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(create_params)
      redirect_to organization_path(@organization)
    else
      render("edit")
    end
  end

  def delete
    @organization = Organization.find(params[:id])
    @user = current_user
    if !can? :update, @organization
      redirect_to organization_path(@organization)
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_path
  end

  def admin
    @organization = Organization.find(params[:id])
    @user = current_user
    if @organization.owner != @user
    redirect_to organization_path(@organization)
    end
    memberships = @organization.memberships
    @rejects = memberships.select{|mem| mem.rejected}
    @pending = memberships.select{|mem| !mem.approved && !mem.rejected}
    @members = memberships.select{|mem| mem.approved && !mem.rejected}
  end

  def create_params
    params.require(:organization).permit(:name, :description, :location)
  end

end
