require 'nokogiri'
require 'open-uri'
require 'json'
load 'opening.rb'

def get_eco_code(name)
  name.split(' ').first
end

def remove_eco_code(name)
  name.split(' ').drop(1).join(' ')
end

def has_more_than_1_code?(name)
  get_eco_code(name).size > 3
end

def convert_line_to_array(moves)
  moves.split(' ').select{ |move| !move.include?('.') }
end

initial_page = "http://www.365chess.com/eco.php"

openings = []
pages_to_scrap = [initial_page]

# Scrap pages in pages_to_scrap array and dump Opening objects to openings array
pages_to_scrap.each do |link|

  page = Nokogiri::HTML(open(link))
  page.css('ul#tree li.closed div.line').each do |line|

    if has_more_than_1_code?(line.css('div.opname a').text)

      pages_to_scrap << line.css('div.opname a').first["href"]
    else
      name = remove_eco_code(line.css('div.opname a').text)
      eco = get_eco_code(line.css('div.opname a').text)
      moves = convert_line_to_array(line.css('div.fright').text.empty? ? line.css('div.opmoves').text : line.css('div.fright').text)

      openings << Opening.new(name, eco, moves)
    end
  end
end

puts "Number of openings aquired: #{openings.size}"
puts "Number of pages scrapped: #{pages_to_scrap.size}"

# openings.each do |op|
#   puts op.to_s
# end

# Check if there are some invalid openings
invalid_openings = openings.select do |op|
  op.name.empty? || op.moves.empty? || op.eco_code.empty?
end

# If there are no invalid openings, go ahead and create a JSON
if invalid_openings.empty?

  # Convert array elements to hashes
  openings.map! { |op| op.to_h }

  # Write to JSON
  json_file = "openings.json"
  File.delete(json_file) if File.exists?(json_file)
  File.open(json_file, "a+") do |file|
    file.write("{\n")
    file.write("\"openings\": [\n")

    openings.each_with_index do |op, index|
      result = openings.size == index + 1 ? "" : ", "
      file.write("#{JSON.generate(op)}#{result}\n")
    end

    file.write("]")
    file.write("}")

    puts "openings.json was successfully created!"
  end

else
  puts "There were some invalid openings detected:"
  puts invalid_openings
end
