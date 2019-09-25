class NotesController < AuthorizedController
  before_action :set_note, only: %i[show edit update destroy]

  def index
    @notes = policy_scope(Note)
  end

  def show
    authorize(@note)
  end

  def new
    @note = authorize(Note.new(note_params))
  end

  def edit
    authorize(@note)
  end

  def create
    @note = authorize(Note.new(note_params))

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize(@note)
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:title, :text, :project_id)
  end
end
