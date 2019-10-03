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

  def enrichement
    employment = Job.find(params[:id])

    FetchApi.perform_query(employment)


        finish = Time.now

        puts "-----------------------------------------------"
        puts "temps pour enrichir: #{ finish - start}"

        redirect_to root_path
  end
end
