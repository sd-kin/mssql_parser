require './sql_connector'
require './image_converter'

include MSSQLOLEConnector
include ImageToHexConverter

db = SqlServer.new
db.open
db.query("SELECT * FROM PERSON WHERE PHOTO IS NULL;")
field_names = db.fields
players = db.data
puts players.first(10)
db.close

