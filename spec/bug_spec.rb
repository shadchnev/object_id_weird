describe "Ruby bug" do

  let (:headers) { [:guess_candidates_length, :object_id_before, :object_id_after] }

  it "changes object id on the fly" do
    output = `ruby test.rb`
    iterations = parse output
    buggy_iterations = iterations.select &object_id_changed
    expect(buggy_iterations).not_to be_empty    
  end

  def object_id_changed
    lambda do |iteration|
      iteration[:object_id_before] != iteration[:object_id_after] &&
      !iteration[:object_id_before].nil? && !iteration[:object_id_after].nil?
    end
  end

  def parse output
    output.split("\n").map do |line|
      Hash[headers.zip(line.split(":"))]  
    end
  end

end