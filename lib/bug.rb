class Bug

  SEED = [
    [0,0]
  ]

  def recurse          
    array = SEED.shift || []
    print [array.length, o_id(array)].join(":")    
    array.each do |candidate|
      puts ":#{o_id(array)}"
      recurse            
    end                
  end

  def o_id(object)
    object.object_id.to_s.slice(-4, 4)
  end

end
