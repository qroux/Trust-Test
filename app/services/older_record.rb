class OlderRecord
  def self.from_csv(row)
    Employment.find_by(collectivity: row["Collectivité"],
                       contract_type: row["Type de contrat"],
                       position: row["Emplois"],
                       level: row["Niveau"],
                       speciality: row["Spécialité"])
  end

  def self.from_json(row)
    # improved fetching success with case insensitive queries
    Employment.where("collectivity ILIKE ? AND contract_type ILIKE ?
                      AND position ILIKE ? AND level ILIKE ?
                      AND speciality ILIKE ?",
                      row['collectivite'],
                      row['type_de_contrat'],
                      row['emplois'],
                      row['niveau'],
                      row["specialite"]).first
  end
end
