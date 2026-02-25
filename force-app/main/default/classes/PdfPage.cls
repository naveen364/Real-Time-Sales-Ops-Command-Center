public with sharing class PdfPage {
    @AuraEnabled    
    public static String getPdfFileAsBase64String() {
        PageReference pageRef = new PageReference('https://cloudanalogycom300-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=Recent');
        Blob pdfBlob = pageRef.getContent();
        System.debug('::7 blob==>'+pdfBlob.toString());
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
        System.debug('::7 blob==>'+base64Pdf);

        return pdfBlob.toString();

    }
}