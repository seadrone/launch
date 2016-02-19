def has_b?(string)
  if /b/.match(string)
    puts "Match!"
  else
    puts "No match!"
  end
end

has_b?("hockey")
has_b?("football")
has_b?("golf")
has_b?("basketball")