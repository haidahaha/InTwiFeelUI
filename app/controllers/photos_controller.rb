class PhotosController < ApplicationController
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to @photo.doctor, notice: 'Photo was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
