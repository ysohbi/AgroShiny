### ui shinydashboard
library(shinydashboard)
library(shiny)
dashboardPage(skin="red",
              dashboardHeader(title="Energy crops database"),
              dashboardSidebar(width=180,
                               sidebarMenu(
                                 menuItem("Welcome",tabName="accueil",icon=icon("home")),
                                 menuItem("Yield distribution",tabName="boxplot",icon=icon("leaf")),
                                 menuItem("Nitrogen fertilization",tabName="ferti",icon=icon("bug")),
                                 menuItem("Network",tabName="network",icon=icon("arrows")),
                                 menuItem("Direct comparisons",tabName="CD",icon=icon("line-chart")))),
              
              dashboardBody(
                
                
                tabItems(
                  tabItem("accueil",
                          fluidRow((
                            box(width=8, status="warning",solidHeader = TRUE,title="Information",
                                tags$b("Welcome!"), 
tags$p("This application presents interactive visualizations of an energy crop dataset including 801 yield data expressed in tons of dry matter per ha and per year. 
       This dataset covers 34 crop species and 12 countries. 
       For annual crops harvested several times per year (as Medicago sativa) a yield value corresponds to the sum of each cut during one year. For short rotation coppice crops not harvested every year, each yield value was divided by the number of years of growth."), 

tags$p("The item « Boxplot yield » generates a boxplot of dry biomass by crop category and region."),

tags$p("The item « Boxplot N fertilization» generates a boxplot of N fertilizer rates by crop category and region."), 

tags$p("The item « network » shows the pairs of crop species compared in the same experimental site(s). The thickness of the link is proportional to the number of sites. The network can be generated for the whole dataset or for some species and region of interest."), 

tags$p("The item « CD » generates yield ratios for all crop species directly compared to a reference crop of your choice."),
tags$p("Crop categories include the annual crops, perennial crops, intercrops and short rotation coppice (called SRC) "),
tags$p("When the combination crop categorie and region is empty, an error message appears (Error: invalid first argument)"),

tags$p("Details about our method can be found in Laurent. A, Pelzer. E, Loyce. C, Makowski.D. Ranking yields of energy crops : a meta-analysis using direct and indirect comparisons. Renewable review 2015, 46:41-50."), 


tags$b("Legend for the items Boxplot yield and Boxplot N fertilization:"),
tags$p(""),
tags$p("A.donax: Arundo donax"),                                  
tags$p("C.sativa: Cannabis sativa"),
tags$p("C.cardunculus: Cynara cardunculus"),
tags$p("C.dactylon: C.dactylon"),
tags$p("D.glomerata: Dactylis glomerata"),
tags$p("E.curvula: Eragrostris.curvula"),
tags$p("F.arundinacea : Festuca arundinacea "),
tags$p("H.tuberosus: Helianthus tuberosis"),
tags$p("M.sativa: Medicago sativa "),
tags$p("M.sacchariflorus: Miscanthus sacchariflorus "),
tags$p("M.sinensis: Miscanthus sinensis"),
tags$p("M.giganteus: Miscanthus x giganteus "),
tags$p("P.amarum: Panicum amarum "),
tags$p("P.virgatum: Panicum virgatum"),
tags$p("P.flaccidum: Pennisetum flaccidum"),
tags$p("P.purpureum: Pennisetum purpureum"),
tags$p("P.arundinacea: Phalaris arundinacea"),
tags$p("P.pratense: Phleum pratense"),
tags$p("S.officinarum: Saccharum officinarum "),
tags$p("S.spp: Saccharum spp"),
tags$p("S.cereale: Secale cereale"),
tags$p("S.montanum: Secale montanum"),
tags$p("S.hermaphrodita: Sida hermaphrodita"),
tags$p("S.bicolor: Sorghum bicolor"),
tags$p("S.halepense: Sorghum halepense"),
tags$p("S.cynosuroides: Spartina cynosuroides"),
tags$p("T.pratense: Trifolium pratense"),
tags$p("T.aestivum: Triticum aestivum"),
tags$p("T.latifolia: Typha latifolia"),
tags$p("Z.mays: Zea mays")


)
                          ))),

                  tabItem("boxplot",
                          box(width = 3,status="warning",solidHeader = TRUE,background = "black",title="inputs",
                              uiOutput("categorie"),
                              uiOutput("region")),
                          fluidRow((
                            box(width=8, status="warning",solidHeader = TRUE,title="yield",
                                plotOutput("boxplot",height = 600))))
                          
                  ),
                  
                  tabItem("ferti",
                          box(width = 3,status="warning",solidHeader = TRUE,background = "black",title="inputs",
                              uiOutput("categorie1"),
                              uiOutput("region1")),
                          fluidRow((
                            box(width=8, status="warning",solidHeader = TRUE,title="Fertilization",
                                plotOutput("ferti",height = 600))))
                  ),
                  
                  tabItem("network",
                          box(width = 3,status="warning",solidHeader = TRUE,background = "black",title="inputs",
                              uiOutput("categorie2"),
                              uiOutput("region2")),
                          fluidRow((
                            box(width=8, status="warning",solidHeader = TRUE,title="Network",
                                plotOutput("network",height = 600))))
                  ),
                  
                  
                  tabItem("CD",
                          box(width = 3,status="warning",solidHeader = TRUE,background = "black",title="inputs",
                              uiOutput("categorie3"),
                              uiOutput("region3")),
                          
                          fluidRow((
                            box(width=12, status="warning",solidHeader = TRUE,title="Direct comparisons",
                                plotOutput("CD",height = 600))))
                  )
                  
                  
                )
              )
)














