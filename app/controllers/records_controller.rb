class RecordsController < ApplicationController
  def show
    @record = Record.find(params[:id])
  end

  def note
    @record = Record.find(params[:id])
  end

  def create_note
    @record = Record.find(params[:id])
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record.report, notice: 'Transcription was successfully saved.' }
        format.json { render :index, status: :ok, location: @record.report }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def record_params
      params.require(:record).permit(:rtype, :length, :transcribed, :report_id, :note)
  end
end
