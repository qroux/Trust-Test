class OlderRecord
  def self.from_csv(row)
    row["Niveau"] ||= "-"
    row["Spécialité"] ||= "-"

    Employment.find_by(collectivity: row["Collectivité"],
                       contract_type: row["Type de contrat"],
                       position: row["Emplois"],
                       level: row["Niveau"],
                       speciality: row["Spécialité"])
  end

  def self.from_json(row)
    # case insensitive queries + nil value removed to remove "where(field IS NULL) cases"
    row["niveau"] ||= "-"
    row["specialite"] ||= "-"

    results = Employment.where("lower(collectivity) LIKE ?
                                AND lower(contract_type) LIKE ?
                                AND position LIKE ?
                                AND lower(level) LIKE ?
                                AND lower(speciality) LIKE ?",
                                row['collectivite'].downcase.gsub(/[é]/, 'e'),
                                row['type_de_contrat'].downcase,
                                row['emplois'],
                                row["niveau"].downcase,
                                row["specialite"].downcase)

    return results.first
  end
end
