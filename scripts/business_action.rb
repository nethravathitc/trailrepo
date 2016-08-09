require '/home/styletag/QAnew/hybrid_framework/funtional_lib/readexceldata.rb'
include Read
require "selenium-webdriver"
require '/home/styletag/QAnew/hybrid_framework/ui_obj_info/ui_objects.rb'
include Css
require '/home/styletag/QAnew/hybrid_framework/funtional_lib/utils.rb'
include Utils

class BusinessAction
	def initialize
		super('/home/styletag/QAnew/hybrid_framework/test_case/inputdata.xls')
		#@obj = Read.new('/home/styletag/QAnew/hybrid_framework/test_case/inputdata.xls')
	end
	def method_trail1
		puts "Inside Third class func3"
		for i in 2..6
			email= dataread(i,0)
			pass = dataread(i,1)
			name = dataread(i,2)
			puts "Email : "+email + "  Password : " +pass +"  Name : " + name

		end
	end
	def method_trail2
		puts "method_trail2"
	end
	
	# LOGIN FUNCTIONALITY
	def login_positive_scenarios 
		puts "Login_positive_scenarios... "
    	wait_for_spinner
    	
    	login_link.click

    	wait_for_spinner  

    	for i in 1..20
      		login=dataread(i,0)
      		if login=="Login"
        		#puts login
        		#puts "#{i}"
        		i=i+1 #to point to the index to the next row
        		break
      		end
    	end
     	 #puts Read.dataread(i,0)
    	login_email.send_keys dataread(i,0)
    	#puts Read.dataread(i,1)
    	login_password.send_keys dataread(i,1)
    	login_btn.click

    	wait_for_spinner
    	sleep(2)
    	loggedin_name = account_member_name.text
    	wait_for_spinner
    	if loggedin_name.include? "Hello"
      	puts "user logged into styletag: PASS"
    	else
      	puts "user not logged into styletag: FAIL"
    	end

	end	

	# LOGOUT FUNCTIONALITY
  	def logout
    	menu = account_member_name
   		$driver.action.move_to(menu).perform
   		sleep(1)
    	inner_logout.click
  	end

  	# ADDING PRODUCT TO CART--HOME PAGE-->SALE-->PRODUCT CATALOG-->PRODUCT--> BUTTON CLICK
  	def adding_to_cart
    
    	sleep(2)
    	puts "click c1..."
    	best_seller.click
    	wait_for_spinner
	    puts "click first sale..."
    	first_sale.click
    	wait_for_spinner
    	sleep(3)
    	first_product.click
    	sleep(3)
    	puts "click first product ..."
    	wait_for_spinner
	    puts @prod1 = productviewpage_productname.text.downcase
    	sleep(3)
   
    	begin    
      		puts "select size add to cart ..."
      		size.click
      		sleep(3)
      		add_to_cart_button.click
        rescue   
        	begin    
          		sleep(3)
          		puts "no size found. add to cart ..."
          		add_to_cart_button.click
        	rescue
          		puts "product got soldout (or) product not available"
          		wait_for_spinner
        	end 
      	end
  	end

  	# CHECKING MINICART--CLICK MINICART--> CHECK PRODUCT ADDED IN CART PAGE
  	def cart_check
    	puts "cart"
    	sleep(2)
	    mini_cart_text.click
    	wait_for_spinner
    	puts @prod2 = cartpage_productname.text.downcase
    	if(@prod1 == @prod2)
    		puts "product is added to the cart: Pass"
    	else
      		puts "product is not added to the cart: Fail"
    	end
    	wait_for_spinner
    	puts "Proceed to checkoout ..." 
    	proceed_to_checkout.click  
    	wait_for_spinner
  	end

end

#launch_styletag
#obj3=BusinessAction.new
#obj3.login_positive_scenarios
#obj3.adding_to_cart
#obj3.cart
#obj3.logout
