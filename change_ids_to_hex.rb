puts 'test'
File.open('employee.csv', 'r+').each_line do |line|
  number, *rest = line.split(';')
  File.open('employee_hex.csv', 'a+') {|file|  file.write ( [number.to_i.to_s(16), *rest].join(',') )}
end