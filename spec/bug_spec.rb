describe "Ruby bug" do

  it "changes object id on the fly" do
    output = `ruby test.rb`
    iterations = parse output
    buggy_iterations = iterations.select &object_id_changed
    expect(buggy_iterations).not_to be_empty
    print_report(iterations, buggy_iterations)    
  end

end

def print_report(iterations, buggy_iterations)
  puts
  puts "HEISENBUG debugging data"
  puts
  puts " -> Out of #{iterations.size}, #{buggy_iterations.size} iterations were buggy"    
  puts
end

def object_id_changed
  lambda {|iteration|
    iteration[:object_id_before] != iteration[:object_id_after]
  }
end

def parse output
  output.split("\n").map do |line|
      line = line.split(":")
      headers = [:guess_candidates_length, :call_id, 
        :object_id_before, :object_id_after, 
        :candidate_id, :object_id_changed, :call_id,
        :iteration, :depth]
      Hash[headers.zip(line)]  
    end
end