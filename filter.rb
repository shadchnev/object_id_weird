File.open('output.txt', 'r+') do |f|
  f.each_line do |line|
    # puts line
    a = line.match /(\d+) v (\d+)/
    # puts a.inspect
    if a
      first, second = a[1], a[2]
      puts line if first != second
    end
  end
end