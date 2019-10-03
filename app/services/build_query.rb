class BuildQuery
  def self.encode_query(employment)
    query = "https://opendata.paris.fr/api/records/1.0/search/?"\
            "dataset=bilan-social-effectifs-non-titulaires-permanents"\
            "&refine.annee=#{employment.year}"\
            "&refine.type_de_contrat=#{employment.contract_type.titleize}"\
            "&refine.emplois=#{employment.position}"

    URI.encode(query)
  end
end
