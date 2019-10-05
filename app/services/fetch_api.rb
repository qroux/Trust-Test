class FetchApi
  def self.perform_query(employment)
    query = BuildQuery.encode_query(employment)

    hash_result = JSON.parse(open(query).read)
    array_of_records = hash_result.dig('records')

    array_of_records.each do |r|
      result = OlderRecord.from_json(r['fields'])

      if result.nil?
        puts "ERROR: no corresponding record in db"
      else
        result.update(men_number: r['fields']['nombre_d_hommes'].to_i,
                      women_number: r['fields']['nombre_de_femmes'].to_i)
      end
    end
  end
end
