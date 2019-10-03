class EmploymentsController < ApplicationController
  def index
    @employments = Employment.order(position: :asc, year: :desc)
  end

  def import
    ImportCsv.import(params[:file])
    redirect_to root_url, notice: 'Fichier importé avec succès'
  end

  def destroy_all
    Employment.destroy_all
    redirect_to root_url
  end
end
