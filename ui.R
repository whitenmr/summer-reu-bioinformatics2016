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
# This program contains the UI for the RShiny application. The purpose of this web application is to provide a simple to use interface from the web that allows the user to compare their data to other sets of publically available data. 
# It shpould be particularly useful for Labs that have a smaller data set and do not want tot pay for a cluster. The webpage will allow for the upload of a data set which can then be used in comparasion to datasets from the 1000 genomes 
# data set. The user can then select from a variety of options in regards to how they want to run the data for comparison. 




library(shiny)
#library(rscala)
#library(sparkR)






shinyUI(
  navbarPage( inverse= TRUE, "Comprall",
             #This is the tab panel that the page opens up to. It contains the basic instructions and the intro to what the page does as a whole. 
             tabPanel("Getting Started", 
                      fluidPage(column(8, offset= 2, h1("Welcome to the comparative data tool #RENAME.", align = "center", style= "color:#191940; font-family:  'Lucida Calligraphy',cursive"),
                                       br(),
                                       br(),
                                                     p("This webpage will allow you to do several things. The first of which is to upload your data. (DO WE WANT TO SHARE DATA?)
                                                        The second will be to compare that data to others data. Here we have provided links to all of the", a(href="http://www.1000genomes.org", "1000 Genomes data"),". You can perform a variety of actions using ADAM and 
                                                        the Popstrat class written by Neil Ferguson. For more details on ADAM and what you can do, please see the ADAM or About pages.", 
                                                       align= "center", style = "color: #1B2960; font-family: 'Times New Roman', serif ; font-size: 1.5em"),
                                       br(), 
                                       br()),
                                       
                                       column(8, offset =2, p("ADAM is a set of open source API's, formats and processing stage implementations that aim to speed up the processing of large sets of data. The project also helps to standardize
                                                             the formats of genomic data. ADAM implements a number of other platforms to provide a solid base for the computations.  ADAM utilizes Avro, Parquet, and Spark to provide a faster 
                                                              system. ADAM has shown a speed-up of up to 60X and has a prosmise of great scalability. There are no language specific libraries needed. If an application can implement an ADAM Schema
                                                              is compatible with ADAM. See the About page for official documentation of ADAM. ", align= "center", style= "color: #2F4866; font-family: 'Times New Roman', serif ; font-size: 1.5em"),
                                              br(),
                                              br()),
                                     
                              
                                       column(8, offset = 2, p("Another feature of this UI is a tool that was developed by Neil Ferguson call Popstrat. Popstrat takes advantage of deep learning and Spark with H2O and SparklingH2O to create a Scala class
                                                               that can predict population group based on genome. The class takes advantage of spark-submit and is originally made to be run with a VCF file. It will however take an .adam file as an input.",
                                                               align= "center", style= "color: #375478; font-family: 'Times New Roman', serif ; font-size: 1.5em")),
                                br(),
                                br(),
                                
                                column(8, offset = 2, p("To begin, move to the next tab page entitled 'Upload'. Then select the File Upload option.", align= "center", style= "color:#496F9E; font-family: 'Times New Roman', serif ; font-size: 2.75em")))
                      ),
#This tab panel has the upload page. This is the place where the user can upload all of their data for comparison. It will take file uploads of vcf and text files. 
navbarMenu("Upload",
             tabPanel("File Upload", 
                      sidebarLayout(position= "right",
                        sidebarPanel(
                          tags$style(".well {background-color:#C0B3FF;}"),
                          #the first file input, it accepts a csv or txt file. It modifies the vcf file to do what it needs. 
                          fileInput('file1', label=h3('Choose File 1', style = "color: 00FF41"),
                                               accept=c('text/csv')),
                          
                          #This allows you to pick whether or not there is a header on the file you are submitting.
                          checkboxInput("header", label= h4("Header", style = "color: Navy"), TRUE),
                          
                         #allows the user to select what type of file they have uploaded and the ui will parse the file accordingly. 
                          radioButtons("dataType", label= h4("Data Type", style= "color: Navy"),
                                       c("CSV"= ",", "VCF"="\t", "TXT"= " ")
                          ),
                         fileInput('file2', label=h3('Choose File 2', style ="color:Navy"), accept=c('text/csv')),
                         checkboxInput('header2', label = h4("Header", style = "color: Navy"), TRUE),
                         radioButtons("dataType2", label = h4("Data Type", style= "color:Navy"),
                                      c("CSV"=",", "VCF"="\t", "TXT"=" "))
                          
                         
                        ),
                        mainPanel(
                         h1("To begin:", align= "center"),
                       column(8, offset= 2, h3("To begin to run the comparasions, start by loading the file you would like to use. This works best if you load a file type that is supported by ADAM or a VCF file if you wish to move straight to the
                            Spark cluster. There are places to upload 2 files, only one will be used. ", align= "center")),
                       fluidRow(  br(),
                         br()),
                         column(8, offset=2, h3("The file(s) uploaded will be saved and then added to the command that is crafted on the next tab. If you have crafted your own command line you wish to use, please also upload your file here as well.", 
                            align= "center"))
                        )
                        
                      )),
           tabPanel("Dataset Upload",
                    sidebarLayout(position= "left",
                                  sidebarPanel(
                                    tags$style(".well {background-color:#BFAEFF;}"),
                                    #the first file input, it accepts a csv or txt file. It modifies the vcf file to do what it needs. 
                                    fileInput('file1', label=h3('Choose a file', style = "color: Navy"),
                                              accept=c('text/csv')),
                                    
                                    
                                    
                                    
                                    #allows the user to select what type of file they have uploaded and the ui will parse the file accordingly. 
                                    radioButtons("dataType", label= h4("Data Type", style= "color: Navy"),
                                                 c("CSV"= ",", "VCF"="\t", "TXT"= " ")
                                    )
                                  
                                    
                                    
                                  ),
                                  mainPanel(
                                    h1("Here is where you can upload your data for other people to use???????????????", align= "center"),
                                    h4("Give me all of the data", align= "center")
                                 
                                    )
                                  
                    )
                    
             
           )),
#This panel will allow the user to craft the adam command as well as the deep learning command that they would like to use via radio buttons if they don't know how to write in the command line or it will allow for them
#to input their own version of the command line into a box that will then be provided as a system() command to the R server.
             tabPanel("ADAM Options", 
                      sidebarLayout(
                        sidebarPanel(
                          #These are all of the instructions on how to use this particular part of the page
                          h2("Instructions:"),
                          p("The ADAM Options section of the webpage gives the user a way to simply pick the way that the ADAM run is run. ", style= "color:#333300"),
                             p(" 1.Start by picking a dataset to compare your data to. All sets of data can currently be found on the 1000 Genome project webpage. ", style= "color: #333300"),
                              p("2. Next select the ADAM command that you would like to run. For a reference of what all of the commands do please see further down. ", style= "color:#333300"),
                             p(" 3. Then pick the number of cores that you want the cluster to use to run your experiment."),
                            p("  4. The next step is to pick the amount of memory that you would like to run with. The more memory the faster the calculation can be run. ", style= "color:#333300"),
                          p(" 5. Make sure to hit the submit button whether using the prepicked settings or inputing your own command."),
                          br(),
                          br(),
                          #These are the commands directly from the ADAM help page that pops up when you type adam-submit in spark
                          h2("ADAM Commands"),
                          
                            h4("ADAM ACTIONS"),
                            p("depth : Calculate the depth from a given ADAM file, at each variant in a VCF"),
                            p("count_kmers : Counts the k-mers/q-mers from a read dataset."),
                            p("count_contig_kmers : Counts the k-mers/q-mers from a read dataset."),
                            p("transform : Convert SAM/BAM to ADAM format and optionally perform read pre-processing transformations"),
                            p("adam2fastq : Convert BAM to FASTQ files"),
                            p("plugin : Executes an ADAMPlugin"),
                            p("flatten : Convert a ADAM format file to a version with a flattened schema, suitable for querying with tools like Impala"),
                            
                            h4("CONVERSION OPERATIONS"),
                            p("vcf2adam : Convert a VCF file to the corresponding ADAM format"),
                            p("anno2adam : Convert a annotation file (in VCF format) to the corresponding ADAM format"),
                            p("adam2vcf : Convert an ADAM variant to the VCF ADAM format"),
                            p("fasta2adam : Converts a text FASTA sequence file into an ADAMNucleotideContig Parquet file which represents assembled sequences."),
                            p("adam2fasta : Convert ADAM nucleotide contig fragments to FASTA files"),
                            p("features2adam : Convert a file with sequence features into corresponding ADAM format"),
                            p("wigfix2bed : Locally convert a wigFix file to BED format"),
                            p("fragments2reads : Convert alignment records into fragment records."),
                            p("reads2fragments : Convert alignment records into fragment records."),
                            
                            h4("PRINT"),
                            p("print : Print an ADAM formatted file"),
                           p(" print_genes : Load a GTF file containing gene annotations and print the corresponding gene models"),
                            p("flagstat : Print statistics on reads in an ADAM file (similar to samtools flagstat)"),
                            p("print_tags : Prints the values and counts of all tags in a set of records"),
                            p("listdict : Print the contents of an ADAM sequence dictionary"),
                            p("allelecount : Calculate Allele frequencies"),
                            p("view : View certain reads from an alignment-record file.")
                          
                          
                        ),
                      
                      
                      mainPanel(
                        fluidRow(
                          column(4, h1("Data Selection",  style= "color: #142852"), offset =4)),
                                               fluidRow(column(4, selectInput("select", label = h3("Choose Data Set", align= "center"), 
                                                           choices = c("Chromosome 1" = "1", "Chromosome 2" = "2", "Chromosome 3" = "3", "Chromosome 4"= "4", "Chromosome 5"="5", "Chromosome 6"="6", "Chromosome 7"= "7"), 
                                                           selected = "1") ,
                                                           offset = 4)),
                        hr(),
                        conditionalPanel(condition = "output.chrom == 1 "),
                        conditionalPanel(condition = "output.chrom == 2 "),
                        conditionalPanel(condition = "output.chrom == 3 "),
                        conditionalPanel(condition = "output.chrom == 4"),
                        conditionalPanel(condition = "output.chrom == 5"),
                        conditionalPanel(condition = "output.chrom== 6"),
                        conditionalPanel(condition = "output.chrom == 7"),
                        
                        
                       
                       
                    
                      fluidRow(
                        column(4, radioButtons("command", "What command would you like to run?", choices= c("depth"= "dep", "count_kmers"= "ck", 
                                                                                                            "count_contig_kmers" = "cck","transform"= 'tr',"adam2fastq"="a2q", "plugin"="p", "flatten"="flat", "vcf2adam"= 'va',
                                                                                                            "anno2adam"="a2a", "adam2vcf"="a2v", "fasta2adam"="f2a", "adam2fasta"="a2f", "features2adam"="feat2a",
                                                                                                             "wigfix2bed"="w2b","fragments2reads"="f2r", "reads2fragments"="r2f", "print"="print", "print_genes"="p_g",
                                                                                                             "flagstat"="flagstat", "print_tags"="p_t", "listdict"="ld", "allecount"="ac", "view"="view" ), 
                                               selected = NULL, inline = TRUE, width= NULL)),
                        column(4, radioButtons("executors", "Number of executors", choices=c("1" = 1, "2"= 2, "3"= 3, "4"=4, "5"=5,"6"=6), selected = NULL, inline = FALSE, width = NULL)), 
                               
                        column(4, radioButtons("memory", "How many G of memory?", choices=c("1" = 1, "2"= 2, "3"= 3, "4"=4, "5"=5,"6"=6), selected = NULL, inline = FALSE, width = NULL )
                               ),
                        column(4, radioButtons("yarn", "Would you like to run with YARN?", choices= c("yes"= "y", "no"= "n"))),
                        
                        textInput("saveFile", label= h4("What would you like the output file to be named?"), value = "file name...", width = 450)
                        ),
                        fluidRow(
                          br(),
                          br()
                        ),
                       
                        verbatimTextOutput("commandtext"),
                     
                        
                        
                       
                      
                      hr(),
                      
                      column(12, textInput("command2", label = h3("If you have crafted your own ADAM command line, please enter it here"), value = "Enter command...", 
                                          width = 540, placeholder = NULL),    offset = 0
                      ),
                      
                     
                      br(),
                      fluidRow(verbatimTextOutput("text")),
                      column(10, submitButton("Submit", width= "45%"), align= "center"),
                     
                      hr(),
                      br()
                      
                      
                      
                      #whatall <- output$adam,
                      #print(whatall)
                      
                      
                      ))
      
                      
             ),
#This sets up the menu that contains hidden pages
             navbarMenu("More",
    #This is the place to give users a guide on how to better use the webpage and what to do when things go wrong
                        tabPanel("Troubleshooting", 
                             fluidPage(h2("Below you will find common issues and suggestions on how to troubleshhot if the response you are getting is not what you want to hear.", align= "center"),
                                       br(),
                                       br(),
                                       
                                       h4("Make sure that you upload the right file type", align="center"),
                                       br(),
                                       br(),
                                       h4("Another issue that you could be facing is that your class code is not correct. This can be a little more difficult to fix. Please see the erroe logs that are located under the more tab.
                                                                  This will allow you to see what errors have been thrown to hopefully allow you to fix the error. The author of this app claims no responsibility for the UI not working when the user loads their
                                                                  own comparasion code to run.", align= "center"),
                                       br(),
                                       br(),
                                       h4("PUT ISSUES HERE"))),
             #A tab about the project and ADAM and Popstrat
                        tabPanel("About",
                                 fluidPage(column(6, wellPanel( h1("Questions?"),  h3("What is ADAM?", style= "color: #08001a"), 
                                           p("ADAM is built on Spark and Avro and Parquet from Apache", style = "color: Navy "),
                                           hr(),
                                           h3("Where can I find more about ADAM?", style= "color: #08001a"),
                                           a(href = "http://www.eecs.berkeley.edu/Pubs/TechRpts/2013/EECS-2013-207.pdf", "EECS on ADAM", style= "color:#884dff"),
                                           hr(),
                                           h3("What if i want to download ADAM for myself?", style= "color: #08001a"),
                                           a(href = "https://github.com/bigdatagenomics/adam", "ADAM source Code", style= "color: #884dff"),
                                           hr(),
                                           h3("And Popstrat, where do I get that?", style= "color:#08001a"),
                                           a(href = "https://github.com/nfergu/popstrat", "Popstrat Source Code", style= "color:#884dff"))
                                           
                                           ),
                                      #At this point this is the awknowledgements part of the program lol
                                           column(6, img(src= "cofc_logo_red.jpg", align= "right", width= 250, length = 250)),
                                           br(),
                                           br(),
                                           fluidRow(column(6, img(src= "NSF_Logo.PNG", align= "right", width= 250, length= 250)))
                                 )
                          
                        )
                        
                     

                        
                        )))

    
  




  
  
