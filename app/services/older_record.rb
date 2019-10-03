class OlderRecord
  def self.find_record(row)
    Employment.find_by(collectivity: row["Collectivité"],
                       contract_type: row["Type de contrat"],
                       position: row["Emplois"],
                       level: row["Niveau"],
                       speciality: row["Spécialité"])
  end

  def self.from_json(row)
    Employment.find_by(collectivity: row["collectivite"].upcase,
                       contract_type: row["type_de_contrat"].upcase,
                       position: row["emplois"].upcase,
                       level: row["niveau"].try(:upcase),
                       speciality: row["specialite"])
  end
end

    # Employment.find_by(collectivity: row["collectivite"], contract_type: row["type_de_contrat"], position: row["emplois"], level: row["niveau"], speciality: row["specialite"])
