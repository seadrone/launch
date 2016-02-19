desc "Default task"
task :default do 
  puts "This is the default task"
end

desc "Says hello"
task :hello, [:name] do |task, args|
  name = args[:name]
  puts "Hello, #{name}"
end