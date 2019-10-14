class EmploymentsController < ApplicationController
  before_action :set_employment, only: [:show, :enrichment]

  def index
    @employments = Employment.order(position: :asc, year: :desc).page(params[:page]).per(10)
  end

  def show
    @query = BuildQuery.encode_query(@employment)
  end

  def import
    if params[:file].nil? #|| params[:file][:csv].content_type != "text/csv" doesn't work with windows
      flash[:alert] = "Erreur: mauvais format de fichier"
    else
      ImportCsv.import(params[:file][:csv])
      flash[:notice] = "Archive importée avec succès"
    end
    redirect_to root_url
  end

  def destroy_all
    Employment.destroy_all
    redirect_to root_url
  end

  def enrichment
    EnrichJob.perform_now(@employment)

    redirect_to employment_path(@employment), notice: "#{@employment.position} mis à jour"
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
