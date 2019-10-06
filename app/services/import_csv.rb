class ImportCsv
  def self.import(file)
    csv_options = { col_sep: ';', headers: :first_row }

    CSV.foreach(file.path, csv_options) do |row|
      result = OlderRecord.from_csv(row)

      if result.nil?
        # remove nil value to remove where(field IS NULL) in olderRecord service
        row["Niveau"].nil? ? lvl = "-" : lvl = row["Niveau"]
        row["Spécialité"].nil? ? spe = "-" : spe = row["Spécialité"]

        Employment.create(year: row["Année"].to_i,
                          collectivity: row["Collectivité"],
                          contract_type: row["Type de contrat"],
                          position: row["Emplois"],
                          level: lvl,
                          speciality: spe)
      elsif result.year < row['Année'].to_i
        result.update(year: row['Année'])
      end
    end
  end
end
