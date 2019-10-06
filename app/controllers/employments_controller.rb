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
    EnrichJob.perform_now(@employment)

    redirect_to employment_path(@employment)
  end

  def enrich_all
    # prevents redundant job if already enriched
    employments = Employment.where(enriched: false)

    employments.each do |employment|
      EnrichJob.perform_later(employment)
    end

    redirect_to root_url
  end

  private

  def set_employment
    @employment = Employment.find(params[:id])
  end
end
