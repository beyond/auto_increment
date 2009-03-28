# Include hook code here
class ActiveRecord::ConnectionAdapters::SQLiteAdapter
	def set_auto_increment( table_name, value )
		execute( "update sqlite_sequence set seq=#{value} where name=#{table_name};" )
	end
end

class ActiveRecord::ConnectionAdapters::MysqlAdapter
	def set_auto_increment( table_name, value )
		execute( "alter table #{table_name} auto_increment=#{value};" )
	end
end

class ActiveRecord::Base
	def self.auto_increment=(value)
		value = value.to_i
		return if value <= 0
		connection.set_auto_increment( quoted_table_name, value )
	end
end
