class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  layout 'notes', only: [:index]

  def index
    @notes = Note.where(user_id: current_user)
    @notes_by_date = @notes.group_by(&:date_appointment)
    @date = params[:date] ? DateTime.parse(params[:date]) : Time.now
  end

  def all_notes
    @notes = (current_user.admin? || current_user.head? ) ? Note.all : Note.where(user_id: current_user)
    @notes_by_date = @notes.group_by(&:date_appointment)
    @date = params[:date] ? DateTime.parse(params[:date]) : Time.now
  end

  def get_user_notes(user_id)
    @notes = (current_user.admin? || current_user.head? ) ? Note.all : Note.where(user_id: user_id)
    @notes_by_date = @notes.group_by(&:date_appointment)
    @date = params[:date] ? DateTime.parse(params[:date]) : Time.now
  end

  def show
  end

  def get_notes
    @telegram_notes = Note.all
  end

  def new(user_id = current_user.id)
    @note = Note.new
    @note.user_id = user_id
  end

  def edit
  end

  def create(*args)
    @note = Note.new(note_params)
    @note.date_appointment = @note.appointment.to_date
    @note.user_id = note_params.has_key?(:user_id) ? note_params.fetch(:user_id) : current_user.id
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        # @note.date_appointment = @note.appointment.to_date
        @note.update_attributes!(date_appointment: @note.appointment.to_date)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
    redis = Redis.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:title, :content, :appointment, :date, :date_appointment, :user_id)
  end
end
