class EmploymentsController < ApplicationController
  before_action :set_employment, only: [:enrichement]

  def index
    @employments = Employment.order(position: :asc, year: :desc)
  end

  def import
    ImportCsv.import(params[:file]) unless params[:file].nil?
    redirect_to root_url, notice: 'Fichier importé avec succès'
  end

  def destroy_all
    Employment.destroy_all
    redirect_to root_url
  end

  def enrichement
    FetchApi.perform_query(@employment)

    redirect_to root_url
  end

  def enrich_all
    start = Time.now
    employments = Employment.all

    employments.each do |employment|
      FetchApi.perform_query(employment)
    end

    puts "Time to ENRICH ALL: #{Time.now - start}"

    redirect_to root_url
  end

  private

  def set_employment
    @employment = Employment.find(params[:id])
  end
end
