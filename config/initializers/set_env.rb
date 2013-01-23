envfile = Rails.root.join(".env")
if envfile.exist?
  envfile.open("r").each do |line|
    key, val = line.split("=", 2)
    ENV[key] = val.to_s.chomp
  end
end
