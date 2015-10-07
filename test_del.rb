del_array = [1, 2, 2.5, 3, 4, 5, 7, 7.5, 8, 12, 13]

del_array.each do 
  |del|
  cmd = "ruby bst.rb #{del}"
  puts "executing cmd: #{cmd}"
  system(cmd)
  $stdin.gets
end
