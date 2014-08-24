library(shiny)
library(ggplot2)

# Define a server for the Shiny app
shinyServer(function(input, output) {
			
			# Fill in the spot we created for a plot
			output$hivPlot <- renderPlot({
						
						ds2 <- ds[ds$country == input$country,]
						mn <- min(ds2$year)
						mx <- max(ds2$year)
						
						# Render a barplot
						eval(parse(text = paste0("print(ggplot(ds2, aes(x = year, y = hiv.prevalence, fill = pop.type, color = pop.type)) 
							+ geom_bar(stat = 'identity', position=position_dodge()) + labs(title = 'HIV Prevalence, ", input$country, " (", mn, " - ", mx, ")') 
							+ geom_text(aes(y = hiv.prevalence, ymax = 70.00, label = hiv.prevalence), position = position_dodge(width = 0.9), vjust = -.5, color = 'black') 
							+ scale_x_continuous('Year') + scale_y_continuous('HIV Prevalence (%)'))")))

					})
		})
