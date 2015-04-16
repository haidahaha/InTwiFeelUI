class ReportsController < ApplicationController
    def index
        @status = params[:status] || "finished"
        @reports = Report.where(status: @status)
    end

    def show
        @report = Report.find(params[:id])
        @photos = @report.photos
        @records = @report.records
    end

    def download
        report_name = Report.find(params[:id]).patientID.to_s
        send_file "public/reports/#{report_name}.pdf", type: "application/pdf", status: 200
    end

    def submit
        report = Report.find(params[:id])
        report.status = "finished"
        respond_to do |format|
          if report.save
            format.html { redirect_to action: :index, notice: 'Report was successfully submitted.' }
            format.json { render :show, status: :created, location: report }
          else
            format.html { render :new }
            format.json { render json: report.errors, status: :unprocessable_entity }
          end
        end

    end

    def upload_photos
      @report = Report.find(params[:id])
      respond_to do |format|
          params[:photos]['photo'].each do |p|
            @photos = @report.photos.create!(:photo => p, :report_id => @report.id)
          end
          format.html { redirect_to @report, notice: 'Photos were successfully uploaded.' }
          format.json { render :show, status: :ok, location: @report }
      end
    end

    def destroy_photos
      @report = Report.find(params[:id])
      @report.photos.destroy_all
      respond_to do |format|
        format.html { redirect_to @report, notice: 'All photos were successfully deleted.' }
        format.json { head :no_content }
      end
    end
end
