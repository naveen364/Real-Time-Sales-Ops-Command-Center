public without sharing class Frontdoor_CTRL{
  
  public boolean isAuthRequired{get; set;}
  public boolean isError{get; set;}
  public String key{get; set;}
  public FrontDoorURLs__c mappedURL{get; set;}
  public string dynamicParams{get; set;}
    public string email{get;set;}
    public string deloitte_Email{get;set;}
   
    public string Conid{get;set;}
    public string Verbiage{get;set;}
    public Contact[] con{get; set;}
  
public Frontdoor_CTRL()
{
  
  /*Initialization variabels*/
  
  dynamicParams= '';
  isAuthRequired=false;
  isError=false;
  Verbiage='';
  
  System.debug('Constructor !!!! ');
  
  /*Query the frontdoor mapping based on Key */
  key = apexpages.currentpage().getparameters().get('Key') ;
  List<FrontDoorURLs__c> lstTODPref=new List<FrontDoorURLs__c>();
  lstTODPref=[select Id,Name, Final_URL__c, Site_Final_URL__c,Site_Page_Verbiage__c,  Is_Active_Employee_Check__c from FrontDoorURLs__c where Name=:key];
  
  if(!lstTODPref.IsEmpty())
   {
       
  /*Mapped Front Door URL */
    mappedURL=lstTODPref[0];
  isAuthRequired=mappedURL.Is_Active_Employee_Check__c;
    Verbiage=mappedURL.Site_Page_Verbiage__c;
    /*
      Identify the dynamic params passed from frontdoor URL. This needs to be passed to redirected URL. 
    */
      Map<string, string> allParams= apexpages.currentpage().getparameters();
    for(String params : allParams.keySet())
        {
            if(params!='Key'&& params!='type'&params!=null)
            {
                dynamicParams=dynamicParams!=''?dynamicParams+'&'+params+'='+allParams.get(params):params+'='+allParams.get(params);
            }
        }
    
   }
   else
   {
     isError=true;
   }
}

public PageReference goTalantOnDemand() {
  
  PageReference objPageRef =null;
  
   try
   {
  
    if(isAuthRequired==false && isError==false)
    {
      String URL=  mappedURL.Final_URL__c.contains('?')?mappedURL.Final_URL__c+'&'+dynamicParams:mappedURL.Final_URL__c+'?'+dynamicParams;
      objPageRef = new PageReference(URL);
      objPageRef.setRedirect(true);
    }
       else
       {
           
       }
       
  }   
    catch(Exception ex)
  {
    system.debug('----Exception----'+ex.getMessage()+'----at Line #---'+ex.getLineNumber());
    }
    return objPageRef;
    }
}