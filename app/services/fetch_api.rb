class FetchApi
  def self.perform_query(employment)


    # query = "https://opendata.paris.fr/api/records/1.0/search/?"\
    #         "dataset=bilan-social-effectifs-non-titulaires-permanents&facet=annee&facet=collectivite&facet=type_de_contrat&facet=emplois&facet=niveau&refine.emplois=#{URI.encode(job.position)}"

    hash_result = JSON.parse(open(query).read)
    array_of_records = hash_result.dig('records')

    array_of_records.each do |r|
      r_f = r['fields']

      begin
        job_to_update = Job.where("unaccent(collectivity) ilike ? AND unaccent(contract_type) ilike ? AND unaccent(position) ilike ? AND unaccent(level) ilike ?", r_f['collectivite'].unaccent, r_f['type_de_contrat'].unaccent, r_f['emplois'].unaccent, r_f['niveau'].unaccent).first
      rescue NoMethodError => e
        puts "#{$!.class}: #{$!.message}"
      end

      if job_to_update.nil?
        puts "error: no corresponding record in db"
      elsif job_to_update.year <= r_f['annee']
        job_to_update.update(year: r_f['annee'],
                              men_number: r_f['nombre_d_hommes'],
                              women_number: r_f['nombre_de_femmes']
                            )
        puts "JOB UPDATED"
      else
        puts "error: More recent data already un db"
      end
    end

  end
end
