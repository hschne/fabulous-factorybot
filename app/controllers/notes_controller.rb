class NotesController < AuthorizedController
  before_action :set_note, only: %i[show edit update destroy]
  before_action :set_project, only: %i[index new create]

  def index
    @notes = policy_scope(Note.where(project: @project))
  end

  def show
    authorize(@note)
  end

  def new
    @note = authorize(@project.notes.new)
  end

  def edit
    authorize(@note)
  end

  def create
    @note = authorize(@project.notes.new(note_params))

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize(@note)
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize(@note)
    @note.destroy
    respond_to do |format|
      format.html { redirect_to project_notes_url(@note.project), notice: 'Note was successfully destroyed.' }
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def note_params
    params.require(:note).permit(:title, :text)
  end
end
