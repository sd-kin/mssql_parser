require './sql_connector'
require './image_converter'

include MSSQLOLEConnector
include ImageToHexConverter

db = SqlServer.new
db.open
db.query("SELECT * FROM PERSON WHERE PHOTO IS NULL;")
field_names = db.fields
players = db.data
p players
p field_names

db.connection.execute("insert into[PARSEC3].[dbo].[person] values('user8', 0x#{image_to_hex('images.jpg')}, null);")
db.close

