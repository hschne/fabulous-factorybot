class MembershipsController < AuthorizedController
  def index
    @memberships = policy_scope(Membership)
  end

  def new
    @membership = authorize(Membership.new)
  end

  def create
    @membership = authorize(Membership.new(membership_params))
    respond_to do |format|
      if @membership.save
        format.html { redirect_to memberships_url, notice: 'Membership was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @membership = authorize(Project.find(params[:id]))
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url, notice: 'Membership was successfully destroyed.' }
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end
end
