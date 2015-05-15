class LucidDream < Roda
  plugin :render, engine: "slim"
  plugin :json
  plugin :path_matchers

  Dir["./models/*.rb"].each{|f| require f}
  Dir["./repositories/*.rb"].each{|f| require f}
  
  route do |r|
    r.root do
      
    end
    
    next unless r.remaining_path.chomp!(".json")

    r.on "api" do
      r.is "welcome" do
        { user: "Guest" }
      end
    end

  end
end
