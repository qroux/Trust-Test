class EmploymentsController < ApplicationController
  before_action :set_employment, only: [:show, :enrichment]

  def index
    @employments = Employment.order(position: :asc, year: :desc)
  end

  def show
    @query = BuildQuery.encode_query(@employment)
  end

  def import
    ImportCsv.import(params[:file]) unless params[:file].nil?
    redirect_to root_url, notice: 'Fichier importé avec succès'
  end

  def destroy_all
    Employment.destroy_all
    redirect_to root_url
  end

  def enrichment
    FetchApi.perform_query(@employment)

    redirect_to employment_path(@employment)
  end

  def enrich_all
    employments = Employment.all

    employments.each do |employment|
      EnrichAllJob.perform_later(employment)
    end

    redirect_to root_url
  end

  private

  def set_employment
    @employment = Employment.find(params[:id])
  end
end
