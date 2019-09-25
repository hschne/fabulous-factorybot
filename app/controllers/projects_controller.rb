class ProjectsController < AuthorizedController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show
    authorize(@project)
  end

  def new
    @project = authorize(Project.new(project_params))
  end

  def edit
    authorize(@project)
  end

  def create
    @project = authorize(Project.new(project_params))
    membership = Membership.new(user: current_user, project: @project, role: Membership::Role[:admin])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize(@project)
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize(@project)
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
