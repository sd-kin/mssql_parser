require 'win32ole'

module MSSQLOLEConnector
  class SqlServer
      # This class manages database connection and queries
      attr_accessor :connection, :data, :fields

      def initialize
          @connection = nil
          @data = nil
      end

      def open
          # Open ADO connection to the SQL Server database
          connection_string =  "Provider=SQLOLEDB.1;"
          connection_string << "Persist Security Info=False;"
          connection_string << "User ID=sa;"
          connection_string << "password=36jndthnjr;"
          connection_string << "Initial Catalog=PARSEC3;"
          connection_string << "Data Source=localhost\\PARSEC3;"
          connection_string << "Network Library=dbmssocn"
          @connection = WIN32OLE.new('ADODB.Connection')
          @connection.open(connection_string)
      end

      def query(sql)
          # Create an instance of an ADO Recordset
          recordset = WIN32OLE.new('ADODB.Recordset')
          # Open the recordset, using an SQL statement and the
          # existing ADO connection
          recordset.Open(sql, @connection)
          # Create and populate an array of field names
          @fields = []
          recordset.Fields.each do |field|
              @fields << field.Name
          end
          begin
              # Move to the first record/row, if any exist
              recordset.MoveFirst
              # Grab all records
              @data = recordset.GetRows
          rescue
              @data = []
          end
          recordset.Close
          # An ADO Recordset's GetRows method returns an array 
          # of columns, so we'll use the transpose method to 
          # convert it to an array of rows
          @data = @data.transpose
          # make hash from data array
          @data = @data.map{|x| Hash[@fields.zip(x)]}
      end

      def close
        @connection.Close
      end
  end
end