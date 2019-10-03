class ImportCsv
  def self.import(file)
    csv_options = { col_sep: ';', headers: :first_row }

    CSV.foreach(file.path, csv_options) do |row|
      result = OlderRecord.find_record(row)

      if result.nil?
        Employment.create(year: row["Année"].to_i,
                          collectivity: row["Collectivité"],
                          contract_type: row["Type de contrat"],
                          position: row["Emplois"],
                          level: row["Niveau"],
                          speciality: row["Spécialité"])
        puts "#{row['Emplois']} job CREATED"
      elsif result.year > row['Année'].to_i
        result.update(year: row['Année'])
        puts "Updated #{result.year == row['Année'].to_i} ----have: #{result.year} Expected: #{row['Année']}"
      else
        puts "More recent record already in DB"
      end
    end
  end
end
