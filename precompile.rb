ip = `ip route`.split("\n")[0].split(" ")[2]
system "SECRET_KEY_BASE=dummydummy DATABSE_URL='postgres://#{ip}/precompile' ./bin/rake assets:precompile"
