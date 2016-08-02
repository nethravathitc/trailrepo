class Driver
	require './hybrid_framework/funtional_lib/readexceldata.rb'
	require './hybrid_framework/scripts/business_action.rb'

	def initialize
	end
	
	def test_execution
		@obj_excel = Read.new('./hybrid_framework/test_case/test_suit.xls')
		@obj_action = Business_action.new

		for i in 1..1
			test_suit= @obj_excel.dataread(i,0)
			puts "Test Suit Name :" + test_suit
			
			test_case_id = @obj_excel.dataread(i,1)
			puts "Test Case ID :" + test_case_id.to_s

			execution_flag = @obj_excel.dataread(i,2)
			puts "Execution Flag :" + execution_flag
		
			if execution_flag=="YES"

				action= @obj_excel.dataread(i,3)
				puts "Action Name :" + action
				@obj_action.method_trail1

				action= @obj_excel.dataread(i,4)
				puts "Action Name :" + action
				@obj_action.method_trail2
			else
				puts "Execution Flag :" + execution_flag

			end

		end

	end
end
obj_driver = Driver.new
obj_driver.test_execution