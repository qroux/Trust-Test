class OlderRecord
  def self.from_csv(row)
    Employment.find_by(collectivity: row["Collectivité"],
                       contract_type: row["Type de contrat"],
                       position: row["Emplois"],
                       level: row["Niveau"],
                       speciality: row["Spécialité"])
  end

  def self.from_json(row)
    # case insensitive queries + nil value removed to remove "where(field IS NULL)"
    row["niveau"].nil? ? lvl = "-" : lvl = row["niveau"]
    row["specialite"].nil? ? spe = "-" : spe = row["specialite"]

    results = Employment.where("lower(collectivity) LIKE ?
                                AND lower(contract_type) LIKE ?
                                AND position LIKE ?
                                AND lower(level) LIKE ?
                                AND lower(speciality) LIKE ?",
                                row['collectivite'].downcase.gsub(/[é]/, 'e'),
                                row['type_de_contrat'].downcase,
                                row['emplois'],
                                lvl.downcase,
                                spe.downcase)

    raise if results.count > 1

    return results.first
  end
end
