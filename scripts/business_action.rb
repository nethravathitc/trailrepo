class Business_action

	require '/home/user/hybrid_framework/funtional_lib/readexceldata.rb'
	
	def initilize
		@obj = Read.new('./hybrid_framework/test_case/inputdata.xls')# test data path
	end

	def method_trail1
			@obj = Read.new('./hybrid_framework/test_case/inputdata.xls')
		for i in 2..6
			email= @obj.dataread(i,0)
 			pass = @obj.dataread(i,1)
 			name = @obj.dataread(i,2)

 			puts email + "\t" + pass + "\t" + name + "\n"
 			puts "\n"
		end

	end

	def method_trail2
		puts "this is method2"
	end
end
#obj= Business_action.new
#obj.method_trail1
