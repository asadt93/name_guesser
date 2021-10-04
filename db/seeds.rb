require 'csv'

puts 'importing country data ...'

countries = []
CSV.foreach("public/country_list.csv", headers: true) do |row|
  countries << Country.new(code: row[1], name: row[0])
end
puts 'storing in to country data to database ..'
Country.import countries
puts 'all country list have been imported'

puts '=========================='
CountriesIndex.import!

users = []
puts 'importing name with country ...'
i = 0
CSV.foreach("public/name_list.tsv",
              force_quotes: true,
              encoding: Encoding::UTF_8,
              headers: true,
              col_sep: "\t",
              liberal_parsing: true) do |row|
  i += 1
  next if row[1].include?('_people')
  users << User.new(name: row[0], country_name: row[1])
  
  if i == 20000
    puts 'please wait, ...'
  elsif i == 30000
    puts '50% ...'
  elsif i == 40000
    puts '80% ...'
  end 
end
puts '100% done ...'
puts '========================='
puts 'storing in to database ..'

User.import users
UsersIndex.import


puts 'creating dummy data for archive table'

i = 0
100.times do
  i +=1

  timestamp = i <= 50 ? Time.utc(2016, 12, 25).to_i : Time.current.utc.to_i
  data = ['foo', 'bar', 'boo'].sample
  archive = Archive.new(data: data, timestamp: timestamp)
  archive.save

end
puts 'dummy data for archive is saved'


puts 'Yeah, we good!'
