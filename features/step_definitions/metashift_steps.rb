Given /^the following metashifts exist$/ do |metashifts_table|
  metashifts_table.hashes.each do |metashift|
    Metashift.create!(metashift)
  end
end

Given /^the following workshifts exist$/ do |metashifts_table|
  metashifts_table.hashes.each do |metashift|
    Metashift.create!(metashift)
  end
end