class FetchApi
  def self.perform_query(employment)
    query = BuildQuery.encode_query(employment)

    hash_result = JSON.parse(open(query).read)
    array_of_records = hash_result.dig('records')

    array_of_records.each do |r|
      r_f = r['fields']

      result = OlderRecord.from_json(r_f)

      if result.nil?
        puts "ERROR: no corresponding record in db"
      else
        result.update(year: r_f['annee'],
                     men_number: r_f['nombre_d_hommes'].to_i,
                     women_number: r_f['nombre_de_femmes'].to_i)
       puts " "
       puts " "
       puts " "
       puts " "
       puts "employment UPDATED"
       puts "employment UPDATED"
       puts "employment UPDATED"
       puts " "
       puts " "
       puts " "
       puts " "
      end
    end
  end
end

# begin
#   job_to_update = Job.where("unaccent(collectivity) ilike ? AND unaccent(contract_type) ilike ? AND unaccent(position) ilike ? AND unaccent(level) ilike ?", r_f['collectivite'].unaccent, r_f['type_de_contrat'].unaccent, r_f['emplois'].unaccent, r_f['niveau'].unaccent).first
# rescue NoMethodError => e
#   puts "#{$!.class}: #{$!.message}"
# end
