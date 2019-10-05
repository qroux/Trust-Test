a = "COMMUNE"
b = "TEMPS INCOMPLET"
c = "ADJOINTS ADMINISTRATIFS"
d = "ADJOINT ADMINISTRATIF DE 2EME CLASSE"
e = nil


# # normal full champs

# results = Employment.where("lower(collectivity) LIKE ?
#                             AND lower(contract_type) LIKE ?
#                             AND position LIKE ?
#                             AND lower(level) LIKE ?
#                             AND lower(speciality) LIKE ?",
#                             a.downcase.gsub(/[é]/, 'e'),
#                             b.downcase,
#                             c,
#                             d.try(:downcase),
#                             e.try(:downcase))

# il manque spécialité

results = Employment.where("lower(collectivity) LIKE ?
                            AND lower(contract_type) LIKE ?
                            AND position LIKE ?
                            AND lower(level) LIKE ?
                            AND speciality IS NULL",
                            a.downcase.gsub(/[é]/, 'e'),
                            b.downcase,
                            c,
                            d.try(:downcase))

# # il manque level

# results = Employment.where("lower(collectivity) LIKE ?
#                             AND lower(contract_type) LIKE ?
#                             AND position LIKE ?
#                             AND level IS NULL LIKE ?
#                             AND lower(speciality) LIKE ?",
#                             a.downcase.gsub(/[é]/, 'e'),
#                             b.downcase,
#                             c,
#                             e.try(:downcase))

# # il manque les deux

# results = Employment.where("lower(collectivity) LIKE ?
#                             AND lower(contract_type) LIKE ?
#                             AND position LIKE ?
#                             AND level IS NULL
#                             AND speciality IS NULL",
#                             a.downcase.gsub(/[é]/, 'e'),
#                             b.downcase,
#                             c)



puts results.count

results.each do |r|
  puts r.id
end

# puts results.first.contract_type == results.last.contract_type
