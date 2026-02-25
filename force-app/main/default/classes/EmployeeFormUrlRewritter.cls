global with sharing class EmployeeFormUrlRewritter implements Site.UrlRewriter {
    
    global PageReference mapRequestUrl(PageReference yourFriendlyUrl)
    {
    
    try
    {
        String trimmedPageName=yourFriendlyUrl.getUrl().substringAfterLast('/');
        String parameters;
        
        if(trimmedPageName.contains('?'))
        {
            parameters=trimmedPageName.substringAfter('?');            
            trimmedPageName=trimmedPageName.substringBefore('?');     
        }
        
        list<urlForRedirect__c> urllist =[select Redirect_URL__c,fullVfPage__c,Pass_parameter__c from urlForRedirect__c where fullVfPage__c=:trimmedPageName];
        
        if(urllist.size()>0)
        {
            if(urllist[0].fullVfPage__c!=null && urllist[0].fullVfPage__c==trimmedPageName)
            {
                system.debug('The checkbox value is-'+urllist[0].Pass_parameter__c);
                //To generate a new URL with Parameters
                if(urllist[0].Pass_parameter__c=true && parameters!=null)
                {
                    String finalReDirectUrl;
                    if(urllist[0].Redirect_URL__c.contains('?')){
                        finalReDirectUrl=urllist[0].Redirect_URL__c+'&';
                    }
                    else
                    {
                        finalReDirectUrl=urllist[0].Redirect_URL__c+'?'; 
                    }
                    yourFriendlyUrl= new PageReference(finalReDirectUrl+parameters);
                }
                else{
                    yourFriendlyUrl= new PageReference(urllist[0].Redirect_URL__c);
                    
                    system.debug('the friendly url'+yourFriendlyUrl);
                }
            }
         }   
        
         system.debug('the friendly url final '+yourFriendlyUrl);
         
         }
         
         Catch(Exception e)
         {
             System.debug('##### Exception '+e+'Line # '+e.getLineNumber());
             //WCT_ExceptionUtility.logException('EmployeeFormUrlRewritter','NA','Line #'+e.getLineNumber()+' Error'+e.getMessage() );
             
         }
        
        return yourFriendlyUrl;
    }     
    
    global List<PageReference> generateUrlFor(List<PageReference> mySalesforceUrls)
    {
        mySalesforceUrls = new List<PageReference>();
        return null;
    }
          
}