#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)
taxa <- readRDS("taxa.rds")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Functional Elements
  
  
  output$leng <- renderUI({
    if (input$taxa=="") {
      paste( " ") 
    }
    else {
      nev=input$taxa
      ac=filter(taxa,Taxon==nev)
      numericInput("Lenght", "Lenght (µm):", ac$L, min = 1,width = 150)
      }
    
  })
  
  
  # Render width------------
  output$width <- renderUI({
    req(input$Lenght)
    if (input$taxa=="") {
      paste( " ") 
    }
    else {
      nev=input$taxa
      ac=filter(taxa,Taxon==nev)
      if (is.na(ac$R_U)){
        sliderInput("Width", "Width (µm):",width='100%',
                  max =1, min = 1,
                   value = 1, step = 0.5)
      }
      else {
      sliderInput("Width", "Width (µm):",width='100%',
                  max =round( input$Lenght/ac$R_L,2), min = round(input$Lenght/ac$R_U,2),
                  value = (ac$L), step = 0.01)
   }}
    
  })  
  
  # Render depth------------
  output$depth <- renderUI({
    req(input$Lenght)
    if (input$taxa=="") {
      paste( " ") 
    }
    else {
      nev=input$taxa
      ac=filter(taxa,Taxon==nev)
      if (is.na(ac$R_D)){
        paste( " ") 
      }
      else {
        numericInput("Depth", "Depth (µm):", ac$D, min = 1, width = 150)
      }}
    
  })  
  
  
  
  #Render taxa list-------------
    output$fun_list <- renderUI({
        
        req(input$checkbox_1)
		 if(input$checkbox_1=="all"){
          
          list_fun=as.data.frame((taxa$Taxon[order(taxa$Taxon)]))
		  names(list_fun)="taxa"
        
        selectInput('taxa', ' ', c(Choose='', list_fun) ,selectize=TRUE)
        }     
        else {
          tb= taxa  %>%  filter(taxa$Shape=="Species specific shape")
          list_fun=as.data.frame((tb$Taxon[order(tb$Taxon)]))
		  names(list_fun)="taxa"
        
        selectInput('taxa', ' ', c(Choose='', list_fun) ,selectize=TRUE)
          
        }    
        
        
		#selectInput(inputId  = "taxa",                       label    = "Select a taxa:",  choice = split(taxa$Taxon[order(taxa$Taxon)], taxa$Shape))
		
		
		
    })
#Calculation------------
#  Volume--------------    
    output$volu <- renderUI({
        req(input$Lenght,input$Width)
        if (input$taxa=="") {
            paste( "Select a taxon first") 
        }
    else {
        nev=input$taxa
        q=input$Lenght/input$Width
        a=filter(taxa,Taxon==nev)
        
				if(is.na(a$Vc)){
				  CV=a$CV_actual
				  V=CV*input$Lenght*input$Lenght*input$Lenght
				  
				   } 
					else{
					
						if(a$Shape=="Spindle"){
						
						 CV=((a$Vc*q**a$Vb))
						 V=CV*input$Lenght*input$Lenght*input$Lenght
						 
						}
							else {
						  
							  CV=((a$Va*q*q+a$Vb*q+a$Vc))
													
							if(is.na(a$R_D)){
								  V=CV*input$Lenght*input$Lenght*input$Lenght
										  }
							else {
								  V=CV*input$Lenght*input$Lenght*input$Lenght*(a$R_D/(input$Lenght/input$Depth))
								  }
						} }		#else vege diatom  		
				
				
				
				V=round(V,3) 
				lab=paste("<h4>","Volume (µm", "<sup>",3,"</sup>):","<b>",V,"<b>", "</h4>")
				
				HTML(paste(lab))
					
		} #else vege inputcheck  
    })    
#  Area--------------       
    output$surf <- renderUI({
        req(input$Lenght,input$Width)
        if (input$taxa=="") {
        paste( " ") 
    }
    else {
        nev=input$taxa
        q=input$Lenght/input$Width
        a=filter(taxa,Taxon==nev)
        
        if(is.na(a$Vc)){
          CA=a$CA_actual
          A=CA*input$Lenght*input$Lenght
        } 
		
		else{
					
						if(a$Shape=="Spindle"){
						
						 CA=((a$Ac*q**a$Ab))
						 A=CA*input$Lenght*input$Lenght
						 
						}
		
        else{
          CA=(a$Aa*q*q+a$Ab*q+a$Ac)
          
        }
    
    if(is.na(a$R_D)){
        A=CA*input$Lenght*input$Lenght
        }
        else {
        per= 1.172*q^2+2.002
        A=CA*input$Lenght*input$Lenght+per*(a$R_D-input$Lenght/input$Depth)
        }}
        
        
        
        A=round(A,3)
        lab=paste("<h4>","Surface (µm", "<sup>",2,"</sup>):","<b>",A,"<b>", "</h4>")
		HTML(paste(lab))
    } 
    })
 
    # Diameter for spherical equivalent Volume------------
    output$sphereV <- renderUI({
        req(input$Lenght,input$Width)
        if (input$taxa=="") {
            paste( " ") 
        }
        else {
            nev=input$taxa
            q=input$Lenght/input$Width
            a=filter(taxa,Taxon==nev)
            if(is.na(a$Vc)){
				  CV=a$CV_actual
				  V=CV*input$Lenght*input$Lenght*input$Lenght
				  
				   } 
					else{
					
						if(a$Shape=="Spindle"){
						
						 CV=((a$Vc*q**a$Vb))
						 V=CV*input$Lenght*input$Lenght*input$Lenght
						 
						}
							else {
						  
							  CV=((a$Va*q*q+a$Vb*q+a$Vc))
													
							if(is.na(a$R_D)){
								  V=CV*input$Lenght*input$Lenght*input$Lenght
										  }
							else {
								  V=CV*input$Lenght*input$Lenght*input$Lenght*(a$R_D/(input$Lenght/input$Depth))
								  }
						} }		#else vege diatom
            
            
            VA=(V/0.523)^(1/3)
            VA=round(VA,3)
            
			lab=paste("<h4> Diameter for spherical equivalent Volume (µm): ","<b>",round(VA,4),"<b>","</h4>")
		HTML(paste(lab))
        } 
    })
    
    
    # Diameter for spherical equivalent Area------------  
    output$sphereA <- renderUI({
        req(input$Lenght,input$Width)
        if (input$taxa=="") {
            paste( " ") 
        }
        else {
            nev=input$taxa
            q=input$Lenght/input$Width
            a=filter(taxa,Taxon==nev)
              if(is.na(a$Vc)){
          CA=a$CA_actual
          A=CA*input$Lenght*input$Lenght
        } 
		
		else{
					
						if(a$Shape=="Spindle"){
						
						 CA=((a$Ac*q**a$Ab))
						 A=CA*input$Lenght*input$Lenght
						 
						}
		
        else{
          CA=(a$Aa*q*q+a$Ab*q+a$Ac)
          
        }
    
    if(is.na(a$R_D)){
        A=CA*input$Lenght*input$Lenght
        }
        else {
        per= 1.172*q^2+2.002
        A=CA*input$Lenght*input$Lenght+per*(a$R_D-input$Lenght/input$Depth)
        }}
            
           
            SA=(A/03.14)^(1/2)
            SA=round(SA,3)
            
			lab=paste("<h4>","Diameter for spherical equivalent Surface (µm)","<b>",round(SA,4),"<b>","</h4>")
		HTML(paste(lab))
            
        } 
    })
#image--------------------   
    output$szoveg_ki  <- renderText({
        if (input$taxa=="") {
            paste( "Select a taxon first") 
        }
        else {
         nev=input$taxa
         a=filter(taxa,Taxon==nev)
        nev2= sub(" ", "_", nev)
         paste( h4("You have selected : "),
                   "<b>",nev,"</b>",
                   br(),
                   h5("Shape of the taxa :"),
                   "<b>",a$Shape,"</b>",
                   br())
        
        }
        
        
            })
    
    
    output$kepek_ki  <- renderText({
        if (input$taxa=="") {
            paste( "Select a taxon first") 
        }
        else {
         nev=input$taxa
         a=filter(taxa,Taxon==nev)
        nev2= sub(" ", "_", nev)
        path=paste0("./algae/",a$pic_name)
       
         
            # Display text
            paste( 
                   br(),
                   tags$img(src=path, height="250",alt="No such 3D image file in the database: "))
        
        
        
        }
        
        
            })
    
    
     
})
