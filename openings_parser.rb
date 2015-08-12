require 'nokogiri'
require 'open-uri'
require 'json'
load 'opening.rb'

def get_eco(name)
  name.split(' ').first
end

def remove_eco(name)
  name.split(' ').drop(1).join(' ')
end

def has_more_than_1_code?(name)
  get_eco(name).size > 3
end

def convert_line_to_array(moves)
  moves.split(' ').select{ |move| !move.include?('.') }
end


page = Nokogiri::HTML(open("http://www.365chess.com/eco.php"))   
openings = []
more_pages = []
# test = page.css('ul#tree li.closed ul li div.line').each do |line|
  
#   name = remove_eco(line.css('div.opname a').text)
#   eco = get_eco(line.css('div.opname a').text)
#   moves = line.css('div.opmoves').text

#   openings << Opening.new(name, eco, moves)
# end

page.css('ul#tree li.closed div.line').each do |line|

  if has_more_than_1_code?(line.css('div.opname a').text)
  
    more_pages << line.css('div.opname a').first["href"]
  else
    name = remove_eco(line.css('div.opname a').text)
    eco = get_eco(line.css('div.opname a').text)
    moves = convert_line_to_array(line.css('div.fright').text.empty? ? line.css('div.opmoves').text : line.css('div.fright').text)

    openings << Opening.new(name, eco, moves)
  end
end


more_pages.each do |link|
  page = Nokogiri::HTML(open(link))   
  
  page.css('ul#tree li.closed div.line').each do |line|

    if has_more_than_1_code?(line.css('div.opname a').text)
    
      more_pages << line.css('div.opname a').first["href"]
    else
      name = remove_eco(line.css('div.opname a').text)
      eco = get_eco(line.css('div.opname a').text)
      moves = convert_line_to_array(line.css('div.fright').text.empty? ? line.css('div.opmoves').text : line.css('div.fright').text)

      openings << Opening.new(name, eco, moves)
    end
  end
end

puts openings.size
puts more_pages
puts more_pages.size

openings.each do |op|
  puts op.to_s
end

invalid_openings = openings.select do |op|
  op.name.empty? || op.moves.empty? || op.eco.empty?
end

if invalid_openings.empty?
  File.delete("openings_array.rb") if File.exists?("openings_array.rb")
  File.open("openings_array.rb", "a+") do |file|
    file.write("#{openings.size}\n")
    openings.each do |op|
      file.write("#{op.name}\n")
      file.write("#{op.eco}\n")
      result = ""
      op.moves.each_with_index do |move, index|
        result += move
        result += ", " unless op.moves.size == index + 1
      end
      file.write("#{result}\n")
      file.write("====================\n")
    end
  end

else
  puts "INVALID OPENINGS ==============="
  puts invalid_openings
end



openings.map! { |op| op.to_h }

File.delete("openings.json") if File.exists?("openings.json")
File.open("openings.json", "a+") do |file|
  # file.write("#{openings.size}\n")
  file.write("{\n")
  
  openings.each_with_index do |op, index|
    file.write("\"opening#{index}\": \n")
    result = openings.size == index + 1 ? "" : ", "
    file.write("#{JSON.generate(op)}#{result}\n")
  end
  
  file.write("}")
end





