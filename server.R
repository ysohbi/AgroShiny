##server shinydashboard
library(shinydashboard)
library(shiny)
setwd(".")


function(input, output) {
  
  toto<-read.csv("toto2.csv",sep=";")
  
  output$categorie<-renderUI({
    selectInput("categorie", " Please choose a crop categorie:",c("all",unique(as.character(toto$categorie))))
  })
  output$region<-renderUI({
    selectInput("region", " Please choose a region:",c("all",unique(as.character(toto$region))))
  })
  output$boxplot = renderPlot( {
    
    par(mar=c(10, 4, 4, 10) + 0.1) #pour ne pas couper la borne inferieure de la fenetre
    
    if (input$categorie=="all" ){
      pdata=toto    
    } else {     
      pdata=subset(toto, categorie==input$categorie)
    } 
    
    if (input$region=="all" ){
      pdata=pdata
      med <- sort(with(pdata, tapply(yield, crop, median))) 
      
      
      
      boxplot(yield ~ factor(crop, levels = names(med)),data = pdata,range=0,las=2,cex.axis=1,ylab="Dry biomass (tn.ha-1.year-1)") 
    } else {   
      
      
      pdata=subset(pdata, region==input$region)
      
      pdata$crop<-factor(pdata$crop,exclude=NULL)
      pdata$region<-factor(pdata$region,exclude=NULL)
      med <- sort(with(pdata, tapply(yield, crop, median))) 
      
      boxplot(yield ~ factor(crop, levels = names(med)),data = pdata,range=0,las=2,cex.axis=1,ylab="Dry biomass (tn.ha-1.year-1)") 
    } 
    
  },height=600,width=750) #fin script pour boxplot yield
  
  
  
  
  #debut script pour boxplot ferti
  dosefertiN_shiny<- read.csv("dosefertiN_shiny.csv", sep=";")
  
  output$categorie1<-renderUI({
    selectInput("categorie1", " choose a crop categorie:",c("all",unique(as.character(dosefertiN_shiny$categorie))))
  })
  output$region1<-renderUI({
    selectInput("region1", " choose a region:",c("all",unique(as.character(dosefertiN_shiny$region))))
  })
  output$ferti = renderPlot( {
    
    par(mar=c(10, 4, 4, 10) + 0.1) #pour ne pas couper la borne inferieure de la fenetre
    
    if (input$categorie1=="all" ){
      pdata=dosefertiN_shiny    
    } else {     
      pdata=subset(dosefertiN_shiny, categorie==input$categorie1)
    } 
    
    if (input$region1=="all" ){
      pdata=pdata
      med <- sort(with(pdata, tapply(doseN, crop, median))) 
      boxplot(doseN ~ factor(crop, levels = names(med)),data = pdata,range=0,las=2,cex.axis=1,ylab="N rate") 
    } else {     
      pdata=subset(pdata, region==input$region1)
      pdata$crop<-factor(pdata$crop,exclude=NULL)
      pdata$region<-factor(pdata$region,exclude=NULL)
      med <- sort(with(pdata, tapply(doseN, crop, median))) 
      boxplot(doseN ~ factor(crop, levels = names(med)),data = pdata,range=0,las=2,cex.axis=1,ylab="N rate")  
    } 
    
  },height=600,width=750) #fin script pour boxplot ferti

  

  #debut script pour network
  
  TAB<- read.csv("fichierdebase.csv",sep=";")
  
  output$categorie2<-renderUI({
    selectInput("categorie2", " choose a categorie:",c("Arundo donax",
                                                       "Miscanthus x giganteus",
                                                       "Salix",
                                                       "Triticosecale",
                                                       "Medicago sativa",
                                                       "Panicum virgatum",
                                                       "Zea mays",
                                                       "Festuca arundinacea",
                                                       "Phragmites austalis",
                                                       "Miscanthus sinensis",
                                                       "Pennisetum purpureum",
                                                       "Sorghum bicolor",
                                                       "Cannabis sativa",
                                                       "Populus",
                                                       "Sida hermaphrodita",
                                                       "Triticum aestivum",
                                                       "Secale cereale",
                                                       "Triticum aestivum",
                                                       "Phalaris arundinacea",
                                                       "Phragmites australis"))
  })
  
  output$network = renderPlot( {
    
    
    sites<-unique(TAB$IDSite); names(sites)<-sites
    garde<-sapply(sites, function(a) {
      toto<-TAB[TAB$IDSite==a,]
      return(input$categorie2 %in% toto$Crop & length(unique(toto$Crop)>1))
    })
    
    networkselection<-TAB[TAB$IDSite %in% names(garde)[garde], ]
    
    nom_culture<-unique(networkselection$Crop)
    MAT<-matrix(ncol=length(nom_culture),nrow=length(nom_culture))
    colnames(MAT)<-nom_culture
    
    k<-0
    for (i in nom_culture [1:(length(nom_culture)-1)]) {
      culture1<-i 
      k<-k+1
      p<-k
      for (j in nom_culture [(k+1):(length(nom_culture))]) {
        p<-p+1
        culture2<-j
        nom1<-networkselection$IDSite[networkselection$Crop==culture1]
        nom1<-unique(nom1)
        nom2<-networkselection$IDSite[networkselection$Crop==culture2]    
        nom2<-unique(nom2)
        print(nom1)
        print(nom2)
        MAT[k,p]<-length(nom1[nom1%in%nom2==TRUE])  
        MAT[p,k]<-MAT[k,p]
        MAT[k,k]<-0
        MAT[p,p]<-0  
      }
    }
    
    library(qgraph)
    g<-qgraph(MAT,layout="spring",labels=names(MAT),label.color="black",
              label.scale=FALSE,label.cex=0.8,posCol="red")
    
    
  },height=600,width=750)
  
  
  #debut script CD
  
  TAB<- read.csv("fichierdebase.csv",sep=";")
 
  output$categorie3<-renderUI({
    selectInput("categorie3", " choose a categorie:",c("Arundo donax",
                                                       "Miscanthus x giganteus",
                                                       "Salix",
                                                       "Triticosecale",
                                                       "Medicago sativa",
                                                       "Panicum virgatum",
                                                       "Zea mays",
                                                       "Festuca arundinacea",
                                                       "Phragmites austalis",
                                                       "Miscanthus sinensis",
                                                       "Pennisetum purpureum",
                                                       "Sorghum bicolor",
                                                       "Cannabis sativa",
                                                       "Populus",
                                                       "Sida hermaphrodita",
                                                       "Triticum aestivum",
                                                       "Secale cereale",
                                                       "Triticum aestivum",
                                                       "Phalaris arundinacea",
                                                       "Phragmites australis"))
  })
  
   output$CD = renderPlot( {
    
    #on veut tous les articles ou il y a Mxg et autre culture
    sites<-unique(TAB$IDSite); names(sites)<-sites
    garde<-sapply(sites, function(a) {
      toto<-TAB[TAB$IDSite==a,]
      return(input$categorie3 %in% toto$Crop & length(unique(toto$Crop)>1))
    })
    
    TAB<-TAB[TAB$IDSite %in% names(garde)[garde], ]
    #write.table(maselection,"~/Documents/Mes documents/R/Results_R/programmation_Anabelle/MxG_allcrop.csv",sep=",")
    
    #on prend le fichier MxG_allcrop
    
    TAB$Crop<-as.character(TAB$Crop)
    TAB$Crop[TAB$Crop==input$categorie3]<-"aa"
    lyield<-log(TAB$Yield)
    TAB<-cbind(TAB,lyield)
    library(nlme)
    DATA<-groupedData(lyield~Crop|SiteYear, data=TAB)
    Mod3<-lme(lyield~Crop,random=~1,data=DATA) #AIC du lme est plus petit donc on garde lme
    summary(Mod3)
    g<-exp(Mod3$coefficient$fixed)
    Sd<-sqrt(diag(Mod3$varFix)) #ecart type = racine carre de la variance
    gLo<-exp(Mod3$coefficient$fixed-1.96*Sd) #pour interval inferieur de confiance 
    gUp<-exp(Mod3$coefficient$fixed+1.96*Sd) #interval de confiance superieur
    #on cree le vecteur donnant le rendement d une culture par rapport au temoin
    #c est a dire exponentienne de alpha. alpha etant la valeur de Value
    g<-g[-1] #on supprime la premiere valeur qui est la valeur de l intercept
    gLo<-gLo[-1]
    gUp<-gUp[-1]
    go<-g[order(g)] #on ordonne
    gLo<-gLo[order(g)]
    gUp<-gUp[order(g)]
    #on cree un vecteur contenant le nom des cultures sauf celui du temoin
    NAME<-names(g)
    NAME<-gsub("Crop","",NAME)
    NAME<-NAME[order(g)]
    #attention utiliser order et pas sort pour ne pas attribuer une mauvaise valeur ? un nom
    #dotchart(go,labels=NAME,xlim=c(0,2.2), xlab="Yield ratio", pch=19,cex=0.8) 
    par(family="serif",mar=c(5,3, 2,4),oma=c(2,15,2,1))
    dotchart(go,labels=NA,xlim=c(0,max(gUp)), xlab="Yield ratio", pch=19,cex=0.5,cex.lab=2) 
    mtext(NAME, side=2, at=1:(length(unique(TAB$Crop))-1), las=1, line=0, adj=1, cex=NA,outer=FALSE)
    #boucle pour avoir interval de confiance inferieur(Lo) et superieur (Up)
    for (i in 1:length(go)) {
      lines(c(gLo[i],gUp[i]),c(i,i))
    }
    abline(v=1,col="black")
    
  },height=600,width=750)
  
  
  #fin script CD
  
  
} #derniere accolade

