class MembershipsController < ApplicationController
  before_action :authenticate_user!  
  
  def create
    @membership = Membership.new(mem_params)
    if @membership.save
      redirect_to organization_path(@membership.organization)
    else
      redirect_to organizations_path
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if !can? :update, @membership
      redirect_to organization_path(@membership.organization)
    end
    if @membership.update(update_params)
      redirect_to "/admin/organizations/#{@membership.organization_id}"
    else
      redirect_to organizations_path
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    if !can? :destroy, @membership
      redirect_to organization_path(@membership.organization)
    end
    @membership.destroy
    puts @membership.user_id
    if @membership.user == current_user
      redirect_to organizations_path
    else
      redirect_to "/admin/organizations/#{@membership.organization_id}"
    end
  end

  def mem_params
    params.require(:membership).permit(:organization_id, :user_id)
  end

  def update_params
    params.require(:membership).permit(:approved, :rejected)
  end

end
