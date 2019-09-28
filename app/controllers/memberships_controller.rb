class MembershipsController < AuthorizedController

  before_action :set_project, only: %i[index new create]

  def index
    @memberships = policy_scope(Membership)
  end

  def new
    @membership = authorize(@project.memberships.new)
  end

  def create
    @membership = authorize(@project.memberships.new(membership_params))
    respond_to do |format|
      if @membership.save
        format.html { redirect_to project_memberships_path, notice: 'Membership was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership = authorize(Membership.find(params[:id]))
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to project_memberships_path(@membership.project), notice: 'Membership was successfully destroyed.' }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :role)
  end
end
