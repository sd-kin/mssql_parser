require './sql_connector'
require './image_converter'

include MSSQLOLEConnector
include ImageToHexConverter

def add_photo(user, db)
  file = 'img/'<<user['name']<<'.jpg'
  if File.exists?(file)
    photo='0x'<<image_to_hex(file)
    sql = "UPDATE [PARSEC3].[dbo].[person] SET photo="
    sql << photo
    sql << "WHERE name='"
    sql << user['name']
    sql << "';"
    db.connection.execute(sql)
  else
    File.open('unprocessed_users.txt', 'a+') {|f| f.write(user['name'] + "\n")}
  end
end

def remove_photo(user, db)
   db.connection.execute("UPDATE [PARSEC3].[dbo].[person] SET photo=NULL WHERE name='"+user['name']+"';")
end

def remove_all(db)
  db.query("SELECT * FROM PERSON WHERE PHOTO IS not NULL;")
  users = db.data
  users.each { |user| remove_photo(user, db) }
end

def add_all(db)
  db.query("SELECT * FROM PERSON WHERE PHOTO IS NULL;")
  users = db.data
  users.each {|user| add_photo(user, db)}
end

db = SqlServer.new
db.open
add_all(db)
#remove_all(db)
db.close
