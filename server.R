#
# File: ui.R
# Author: Makenzie Whitener (whitenmr@wfu.edu)
# Date: 07/18/16
# Last Revision: 07/18/16
# Version: 0.42
# 
# 
# Some code taken from Shiny.io and modified to fit the purpose of the Web application. 
# 
# This program contains the server for the RShiny application. The purpose of this web application is to provide a simple to use interface from the web that allows the user to compare their data to other sets of publically available data. 
# It shpould be particularly useful for Labs that have a smaller data set and do not want tot pay for a cluster. The webpage will allow for the upload of a data set which can then be used in comparasion to datasets from the 1000 genomes 
# data set. The user can then select from a variety of options in regards to how they want to run the data for comparison. 
#

library(shiny)

#This is the server
shinyServer(function(input, output) {
  #This outputs the contents of the file PROBABLY WONT BE KEPT IN
  
panelFile <- download.file("ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel", "ALL.panel")
  
 output$contents <- renderTable({
    

    
   inFile <- input$file1
    
   if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath,  sep =input$dataType, header =input$header
           )
   
  })
output$chrom <- reactive({ 
  chromData <- input$select
  
  if(chromData == "3")
  {
   download.file("https://dahl.byu.edu/software/rscala/rscala-jss.pdf", "dest"<- "rscala.txt")
   
   
    
  }
  
  if(chromData == "4")
  {
   download.file("https://dahl.byu.edu/software/rscala/rscala-jss.pdf", "dest"<- "what1.txt")
    
  }
  
  if(chromData == "5")
  {
    download.file("https://dahl.byu.edu/software/rscala/rscala-jss.pdf", "dest"<- "what2.txt")
    
  }
    
 
   
 })
outputOptions(output, "chrom", suspendWhenHidden=FALSE)

output$text<- renderText({
  paste("Command:", input$command2)
})
adam<- "adam-submit"

output$commandtext <- reactive({
  
  commandData <- input$command
  yarnData <- input$yarn

    if(commandData == "dep")
    {
      com<- "depth"
    }

    if(commandData == "ck")
    {
      com<- "count_kmers"
    }

    if(commandData == "cck")
    {
      com<- "count_contig_kmers"
    }


    if(commandData == 'tr')
    {
      com<- "transform"
    }

    if(commandData == "a2q")
    {
      com<- "adam2fastq"
    }

    if(commandData == "p")
    {
      com<- "plugin"
    }

    if(commandData == "flat")
    {
      com<- "flatten"
    }

    if(commandData == 'va')
    {
      com<- "vcf2adam"
    }

    if(commandData == "a2a")
    {
      com<- "anno2adam"
    }

    if(commandData == "a2v")
    {
      com<- "adam2vcf"
      print(com)
    }

    if(commandData == "f2a")
    {
      com<- "fasta2adam"
    }

    if(commandData == "a2f")
    {
      com<- "adam2fasta"
    }

    if(commandData == "w2b")
    {
      com<- "wigfix2bed"
    }

    if(commandData =="f2r")
    {
      com<- "fragments2reads"
    }

    if(commandData =="r2f")
    {
      com<- "reads2fragments"
    }

    if(commandData =="print")
    {
      com<- "print"
    }

    if(commandData =="p_g")
    {
      com<- "print_genes"
    }

    if(commandData =="flagstat")
    {
      com<- "flagstat"
    }

    if(commandData =="p_t")
    {
      com<- "print_tags"
    }


    if(commandData =="ld")
    {
      com<- "listdict"
    }


    if(commandData =="ac")
    {
      com<- "allecount"
    }


    if(commandData =="view")
    {
      com<- "view"
    }
  
  if(yarnData == "y")
  {
    yd <- "--master-yarn client"
  }
  else{
    yd<- NULL
  }
  
  exeData <- paste("--num-executors" ,input$executors)
  
  gigs <- paste("--executor-memory" ,input$memory, "G ")
  
  inFile<- input$file1
  
  if(is.null(yd))
  {
    final<- paste("Command:", adam,  exeData, gigs,"--", com, inFile$name, input$saveFile)
    
  }
  else
  {
    final<- paste("Command:", adam, yd, exeData, gigs,"--", com, inFile$name, input$saveFile)
  }
  
  

  return(final)
  
})







#In this section of code I have created a way to tell which button was pressed and then how to handle how that button was pressed. I will have to pick the brains of a better R coder so see if there is a more efficient way.


#outputOptions(output, "adam", suspendWhenHidden=FALSE)
 
 
 
 #This outputs the file file name
  #  output$file1 <- renderPrint({ in1File <- input$file1
  # if(is.null(in1File))
  #    return(NULL)
  #  })
  #output$file2 <- renderPrint({input$file2})
  
  #this outputs the number of executors that have been selected.
  #output$exe <- renderPrint({input$executors    })
  
  #outputs the command to be used

   
})

