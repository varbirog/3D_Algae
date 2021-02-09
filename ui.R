#
# This is 3d_Algae app demo
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
shinyUI(dashboardPage(
    title = '3D Algae',
    header = dashboardHeader(
        titleWidth='100%',
        title = span(
            tags$img(src="cosi.png", width = '100%'), 
            column(12, class="title-box", 
                   tags$h1(class="primary-title", style='margin-top:10px;', 'Biovolume and surface area calculations for microalgae'), 
                   tags$h2(class="primary-subtitle", style='margin-top:10px;', 'using realistic 3D models')
            )
        )
        
    ),
    dashboardSidebar(
        sidebarMenu(
            menuItem("About", tabName = "about", icon = icon("desktop")),
            
            #menuItem("Database", tabName = "database", icon = icon("data")),
            menuItem("Calculation", tabName = "calculator", icon = icon("calculator"))
            
            #div
        )
    ),
    
    dashboardBody(
    tags$style(type="text/css", "
/*    Move everything below the header */
    .content-wrapper {
        margin-top: 50px;
    }
    .content {
        padding-top: 60px;
    }
/*    Format the title/subtitle text */
    .title-box {
        position: absolute;
        text-align: center;
        top: 50%;
        left: 50%;
        transform:translate(-50%, -50%);
    }
    @media (max-width: 590px) {
        .title-box {
            position: absolute;
            text-align: center;
            top: 10%;
            left: 10%;
            transform:translate(-5%, -5%);
        }
    }
    @media (max-width: 767px) {
        .primary-title {
            font-size: 1.1em;
            color: DarkOrange;
        }
        .primary-subtitle {
            font-size: 1em;
        }
    }
/*    Make the image taller */
    .main-header .logo {
        height: 125px;
    }
/*    Override the default media-specific settings */
    @media (max-width: 5000px) {
        .main-header {
            padding: 0 0;
            position: relative;
        }
        .main-header .logo,
        .main-header .navbar {
            width: 100%;
            float: none;
        }
        .main-header .navbar {
            margin: 0;
        }
        .primary-title { color:  Navy;text-shadow: 2px 2px 5px green;
        }
        .primary-subtitle {
            color:  Navy  ;text-shadow: 2px 2px 5px green;
        }
        .main-header .navbar-custom-menu {
            float: right;
        }
    }
/*    Move the sidebar down */
    .main-sidebar {
        position: absolute;
    }
    .left-side, .main-sidebar {
        padding-top: 175px;
    }"
               
               
               
    ),
    
        tabItems(
            
            
            
            # Second tab content calculator------------
            tabItem(tabName = "calculator",
                    
                    fluidRow(
                        box(
                          
                            title = "Select a taxa",status = "success",solidHeader = TRUE,collapsible=TRUE,				
                            fluidRow( style='padding:10px;',
                                h4("Select the taxa:"),
								radioButtons("checkbox_1", "Select database type:",
								c("All taxa" = "all", "Only species specific shapes" = "spec"), 
								selected = "spec"),				 
																helpText("The whole database contains approx 3.000 and 293 taxa with species specific shapes, increasing..."),
                                uiOutput("fun_list"),
                                #numericInput("xval", "Length values(µm):", 10, min = 1,width = 150),
                                #numericInput("yval", "Width values (µm):", 10, min = 1,width = 150),
                                column(3,
                                uiOutput("leng")),
                                column(3,
                                uiOutput("depth"))
                            ),
                            fluidRow(style='padding:10px;',
							column(12,
                                uiOutput("width"),
								helpText("Note: 'Width' calculated from the Uppermost & Lowermost value of the length/width ratio of the species")
														
								)),
                            h2("Steps to use the tool:"),
                            p("1. Select the alge from the list:"),
                            #tags$img(src="import.png", height=250),
                            p("2. Add the Lenght and adjust the Width measurments, in case of diatomes the depth."),
                            #tags$img(src="import2.png", height=250),
                            p("3. The tool calculates the Volume and Surface"),
                            p("So simple.........")
                        ),
                       
                    
                      widgetUserBox(
                            title ="Results of the calculation",
                            closable = FALSE,
							src = "cosi_2.png",
                            color = "aqua-active",
                            fluidRow(style='padding:10px;',
							column(width = 3, align = "center",
							htmlOutput("szoveg_ki"))							,
                            column(width = 9, align = "center",
							htmlOutput("kepek_ki")),
                            ),
							 fluidRow(style='padding:10px;',
                            htmlOutput("volu"),
							              htmlOutput("surf"),
                            htmlOutput("sphereV"),
                            htmlOutput("sphereA")),
					footer = "Cite: G. Borics, V. Lerf, E. T-Krasznai, I. Stankovic, L. Pickó, V. Béres and G. Várbíró (2021) Biovolume and surface area calculations for microalgae, using realistic 3D models 
					Science of the Total Environment (2021), https://doi.org/10.1016/j.scitotenv.2021.145538"
                       
                    ))
                    
            ),
							# Fisrt tab content Instructions------------
            tabItem(tabName = "about",
                    box(title = "Instructions",
                        tags$head(tags$style(HTML(".tab-pane { height: 70vh; overflow-y: auto; }" ))),
                        status = "primary",
                        solidHeader = T,
                        collapsible = F,
                        width = 12,
                                 
                    
                    
    div(
      fluidRow(column(width = 6,
                    h2("Biovolume and surface area calculations for microalgae, using realistic 3D models"),
					
					tags$div(
			HTML("<h4><sup>1,*</sup> Gábor Borics, 
			<sup>1</sup> Verona Lerf, 
			<sup>1</sup> Enikő T-Krasznai, 
			<sup>2</sup> Igor Stanković, 
			<sup>3</sup> Levente Pickó, 
			<sup>1</sup> Viktória Béres and 
			<sup>1</sup> Gábor Várbíró 
			</h4>
			<p><sup>1</sup> Centre for Ecological Research, Danube Research Institute,
			Department of Tisza Research, 18/c. Bem square, H-4026 Debrecen, Hungary<br>
			<sup>2</sup> Hrvatske vode, Central Water Management Laboratory, Ulica grada Vukovara 220,, Hr-10000 Zagreb, Croatia<br>
			<sup>3</sup> Mediakreator Ltd., 22 Holló str. H-7635 Pécs, Hungary <br>
			
")
					),
					HTML("Corresponding author: Gabor Varbiro"),tags$a(href="mailto:varbirog@gmail.com", "varbirog@gmail.com"),
					br(),
						   h3("Abstract"),
                    p("1.	Morphology and spatial dimensions of microalgal units (cells or colonies) are among of the most relevant traits of
					planktic algae, which have a pronounced impact on their basic functional properties, like access to nutrients or light, 
					the velocity of sinking or tolerance to grazing. Although the shape of algae can be approximated by geometric forms and thus, 
					their volume and surface area can be calculated, this approach cannot be validated and might have uncertainties especially in the case of complicated forms."),
p("2.	In this study, we report on a novel approach that uses real-like 3D mesh objects to visualise microalgae and calculates their volume and surface area. 
Knowing these dimensions and their intraspecific variabilities, we calculated specific shape and surface area constants for more than 300 forms, covering more than two thousand taxa."), 
p("3.	Using these constants, the accurate volume and surface area can be quickly computed for each taxon and having these values,
 morphology-related metrics like surface area/volume ratio, the diameter of spherical equivalent can also be given quickly and accurately."), 
p("4.	Besides their practical importance, the volume and surface area constants can be considered as size-independent morphological traits that are characteristic for the microalgal shapes, and provide new possibilities of data analyses in the field of phytoplankton ecology. 
"),
					  h3("Citation:"), 
					  p("G. Borics, V. Lerf, E. T-Krasznai, I. Stankovic, L. Pickó, V. Béres & G. Várbíró: Biovolume and surface area calculations for microalgae, using realistic 3D models 
					   2021 "),
					  tags$i("Science of the Total
Environment"),
tags$a(href="https://www.sciencedirect.com/science/article/pii/S0048969721006069", "https://doi.org/10.1016/j.scitotenv.2021.145538"),
					   h3("New shapes:"),
					img(src = "Sheet_0000.jpg", height = 200, width = 200),
					img(src = "Sheet_0001.jpg", height = 200, width = 200),   
					img(src = "Sheet_0002.jpg", height = 200, width = 200),   
					img(src = "Sheet_0003.jpg", height = 200, width = 200),   					
                    h2("Steps to use the tool:"),
                    p("1. Select the alge from the list."),
                    #tags$img(src="import.png", height=250),
                    p("2. Add the Lenght and adjust the Width measurments, in case of diatomes the Depth."),
                    #tags$img(src="import2.png", height=250),
                    p("3. The tool calculates the Volume and Surface"),
                    p("So simple.........")),
             column(width =4, align = "center",
                    tags$video(id="video2", type = "video/webm",width="400", height="400", src = "scenedesmus.webm", autoplay = NA, controls = NA))
			) 
    )#div
            ))
        )
    )
)
)

