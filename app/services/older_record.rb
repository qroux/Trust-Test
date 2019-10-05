class OlderRecord
  def self.from_csv(row)
    Employment.find_by(collectivity: row["Collectivité"],
                       contract_type: row["Type de contrat"],
                       position: row["Emplois"],
                       level: row["Niveau"],
                       speciality: row["Spécialité"])
  end

  def self.from_json(row)
    # improved fetching success with case insensitive queries + nil value

    if row['niveau'].nil? && row['specialite'].nil?

      results = Employment.where("lower(collectivity) LIKE ?
                                  AND lower(contract_type) LIKE ?
                                  AND position LIKE ?
                                  AND level IS NULL
                                  AND speciality IS NULL",
                                  row['collectivite'].downcase.gsub(/[é]/, 'e'),
                                  row['type_de_contrat'].downcase,
                                  row['emplois'])
    elsif row['niveau'].nil?

      results = Employment.where("lower(collectivity) LIKE ?
                                  AND lower(contract_type) LIKE ?
                                  AND position LIKE ?
                                  AND lower(speciality) LIKE ?
                                  AND level IS NULL",
                                  row['collectivite'].downcase.gsub(/[é]/, 'e'),
                                  row['type_de_contrat'].downcase,
                                  row['emplois'],
                                  row['specialite'].downcase)

    elsif row['specialite'].nil?

      results = Employment.where("lower(collectivity) LIKE ?
                                  AND lower(contract_type) LIKE ?
                                  AND position LIKE ?
                                  AND lower(level) LIKE ?
                                  AND speciality IS NULL",
                                  row['collectivite'].downcase.gsub(/[é]/, 'e'),
                                  row['type_de_contrat'].downcase,
                                  row['emplois'],
                                  row['niveau'].downcase)

    else

      results = Employment.where("lower(collectivity) LIKE ?
                                  AND lower(contract_type) LIKE ?
                                  AND position LIKE ?
                                  AND lower(level) LIKE ?
                                  AND lower(speciality) LIKE ?",
                                  row['collectivite'].downcase.gsub(/[é]/, 'e'),
                                  row['type_de_contrat'].downcase,
                                  row['emplois'],
                                  row['niveau'].downcase,
                                  row['specialite'].downcase)

    end

    raise if results.count > 1

    return results.first
  end
end
