class OlderRecord
  def self.find_record(row)
    Employment.find_by(collectivity: row["Collectivité"],
                       contract_type: row["Type de contrat"],
                       position: row["Emplois"],
                       level: row["Niveau"],
                       speciality:row["Spécialité"])
  end
end
