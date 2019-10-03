class EmploymentsController < ApplicationController
  def index
    @employments = Employment.order(position: :asc, year: :desc)
  end

  def import
    csv_options = { col_sep: ';', headers: :first_row }

    CSV.foreach(params[:file].path, csv_options) do |row|
      Employment.create(year: row["Année"],
                  collectivity: row["Collectivité"],
                  contract_type: row["Type de contrat"],
                  position: row["Emplois"],
                  level: row["Niveau"],
                  speciality: row["Spécialité"])

      puts "#{row['Emplois']} job CREATED"
    end

    redirect_to root_url
  end

  def destroy_all
    Employment.destroy_all
    redirect_to root_url
  end
end
