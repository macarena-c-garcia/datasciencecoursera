library(shiny)
load("hiv_data.RData")

# Define the overall UI
shinyUI(
		
		# Use a fluid Bootstrap layout
		fluidPage(    
				
				# Give the page a title
				titlePanel("HIV Prevalence by Country"),
				
				# Generate a row with a sidebar
				sidebarLayout(      
						
						# Define the sidebar with one input
						sidebarPanel(
								selectInput("country",
											"Country:",
											choices = ds$country,
											selected = 'Botswana'),
								hr(),
								helpText("Data source: AIDSInfo Online Database"),
								helpText("Developed by Macarena C. García 2014")
						),
						
						# Create a spot for the barplot
						mainPanel(
								plotOutput("hivPlot")  
						)
				
				)
		)
)