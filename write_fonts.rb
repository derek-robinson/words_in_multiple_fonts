require 'victor'
require 'ttfunk'

#text_to_write = 'Just Married'
#text_to_write = '1 Corinthians 13:4-5'
if ARGV.empty?
  text_to_write = 'Jones'
else
  text_to_write = ARGV[0].chomp
end

#basedir = '~/Library/Fonts'
basedir = '/Users/derekrobinson/Library/Fonts'
font_files = Dir.glob("*.*tf", base: basedir)
font_files.map! {|file| basedir+"/"+file}

font_list = []
font_files.each do |font|
  #font_list << (TTFunk::File.open(font).name.font_name[0])
  font_list << (TTFunk::File.open(font).name.font_family[0])
end
font_list.uniq!
font_list.map! {|font| font.delete("\000")}

svg = Victor::SVG.new width: 500, height: 500, style: { background: '#ddd' }
y_pos = 50
svg.build do
  font_list.each do |font_name|
    puts "fn: #{font_name} - text: #{text_to_write}"
   # g font_size: 60, font_family: font_name, fill: 'black' do
    #    text text_to_write, x: 190, y: 200
   # end
   svg.text text_to_write, x: 40, y: y_pos, font_family: font_name
   y_pos = y_pos + 10
  end
end

if text_to_write.include? ' '
  filename = "font_"+(text_to_write.gsub(' ','_'))
else
  filename = "font_"+text_to_write
end

svg.save filename
