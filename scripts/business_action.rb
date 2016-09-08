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
        		i=i+1 #to point to the index of the next row
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
      sleep(1)
    	menu = account_member_name
   		$driver.action.move_to(menu).perform
   		sleep(1)
    	inner_logout.click
  	end

  	# ADDING PRODUCT TO CART--HOME PAGE-->SALE-->PRODUCT CATALOG-->PRODUCT--> BUTTON CLICK
  	def adding_to_cart
    
    	sleep(2)
    	puts "click c1..."
    	women.click
    	wait_for_spinner
	    #puts "click first sale..." NO MORE SALE VIEW
    	#first_sale.click
    	#wait_for_spinner
    	sleep(3)

    	
      @flag_no_product=0 
      i=1
      begin
        #first_product.click
        #$driver.find_element(:css,"#product-container > div > ul > li.product-wrap:nth-child(#{i}) > div.products-wrapper .go-to-product").click
        
        #it will click only non-pinned product ie normal product
        $driver.find_element(:css,"#product-container > div.ng-isolate-scope > product-list > ul > li:nth-child(#{i}) > div > div.product-image > a > img").click
        sleep(3)
    	  puts "click product no #{i} ..."
    	  wait_for_spinner
	      puts @prod1 = productviewpage_productname.text.downcase  # storing the product name by down casting it
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
              @flag_no_product=1
              i++  # to select the next product
          		wait_for_spinner
        	end 
      	 end
      end while @flag_no_product==1 
  	end

  	# CHECKING MINICART--CLICK MINICART--> CHECK ADDED PRODUCT IN CART PAGE
  	def cart_check
    	puts "cart"
      if @flag_no_product==0  
    	 sleep(2)
	     mini_cart_text.click
    	 wait_for_spinner
    	 puts @prod2 = cartpage_productname.text.downcase
    	 if(@prod1 == @prod2)
    	   	puts "product is added to the cart: PASS"
    	 else
      		puts "product is not added to the cart: FAIL" # cart is invalid ie when items in the cart are sold out 
          puts "Removing sold out item present in the cart"
          remove_sold_out.click

    	 end
    	 #wait_for_spinner
    	 #puts "Proceed to checkoout ..." 
    	 #proceed_to_checkout.click  
    	 #wait_for_spinner
      
      else
        print "product is not added to cart because of non availability"
      end

  	end

    def proceed_to_pay
      sleep(1)
      #mini_cart_text.click
      #wait_for_spinner
      sleep(1)
      puts "Proceed to checkoout ..." 
      proceed_to_checkout.click  
      wait_for_spinner
      puts "continue as logged in"
      wait_for_spinner
      continue.click
      wait_for_spinner
      puts "add new address"
      # click add new address
      add_address_checkout.click
      wait_for_spinner

      for i in 1..20
        login=dataread(i,0)
         if login=="Login"
            i=i+1 #to point to the index of the next row
            break
          end
      end
      address_pincode.send_keys dataread(i,3)
      wait_for_spinner
      firstname.send_keys dataread(i,4)
      address_phone.send_keys dataread(i,5)
      address_address1.send_keys dataread(i,6)
      address_landmark.send_keys dataread(i,7)
      create_btn.click
      wait_for_spinner

      puts "selecting address"
      select_address.click
      wait_for_spinner
      continue3.click
      wait_for_spinner

      puts "clicking pay button"
      proceed_pay_btn.click
      longwait
    end

    def payment_method_cod
      puts "payment_method - COD"
      cod_payment.click
      wait_for_spinner
      if codbutton.displayed?
        puts "Order placing as COD"
        codbutton.click
      else
        puts "Sorry, no COD available"
      end
      sleep(10)
      #$driver.switch_to.alert.accept # for fire fox browser
      sleep(250)
      wait_for_spinner

       puts $driver.find_element(:css,"#order-cancel > div > section > p:nth-child(2) > span").text
      
    end

    #CLEARING CART BY CLICKING ON EMPTY_MY_CART
    def clear_cart
      sleep(1)

      element = $driver.find_element(:css,"#mini-cart-wrap > li > div.minicart-inner-div > a:nth-child(3) > span") 
      puts "moving cursor to minicart"
      $driver.action.move_to(element).perform

      sleep(2) 
      begin
         empty_my_cart = $driver.find_element(:css,"#minicart-bottom > p.pull-left > a")
         sleep(1)
         empty_my_cart.click
         sleep(1)
       rescue 
         puts "cart is already empty"
       end 
    end

end

#launch_styletag
#obj3=BusinessAction.new
#obj3.login_positive_scenarios
#obj3.adding_to_cart
#obj3.cart
#obj3.logout
