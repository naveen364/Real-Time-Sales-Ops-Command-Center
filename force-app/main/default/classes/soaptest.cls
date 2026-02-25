public class soaptest {
    private static final String SE_NAMESPACE = 'http://schemas.xmlsoap.org/soap/envelope/';
    private static final String SE_PREFIX = 'se';

    private static final String FT_NAMESPACE = 'http://fasttrackrtw.com/services/';
    private static final String FT_PREFIX = 'te';
    public static Dom.Document sample(){
        
        Dom.Document docFile;
        Dom.XMLNode createNode;
        
        RequestBuilder sc = new RequestBuilder();
        sc.add('BOB', 'The');
        sc.add('Builder', 'Null');
		System.debug('doc==>'+sc.getDocument());	
        return sc.getDocument();
    }
    private class RequestBuilder {

        Dom.Document doc;
        Dom.XMLNode create;

        RequestBuilder() {

            // Created SOAP envelope, header and body and create elements
            doc = new Dom.Document();
            Dom.XMLNode envelope = doc.createRootElement('Envelope', SE_NAMESPACE, SE_PREFIX);
            create = envelope
                .addChildElement('Body', SE_NAMESPACE, SE_PREFIX)
                .addChildElement('fileName', FT_NAMESPACE, FT_PREFIX);
        }

        Dom.Document getDocument() {
            return doc;
        }

        RequestBuilder add(String name, Object value) {
            createElementAndTextNode(name, value);
            return this;
        }

        RequestBuilder add(String name, SObject sob, SObjectField field) {
            if (sob != null) {
                createElementAndTextNode(name, sob.get(field));
            }
            return this;
        }

        private void createElementAndTextNode(String name, Object value) {
            if (value != null) {
                if (value instanceof String) {
                    create.addChildElement(name, FT_NAMESPACE, FT_PREFIX).addTextNode((String) value);
                } else if (value instanceof Date) {
                    Date d = (Date) value;
                    DateTime dt = DateTime.newInstance(d.year(), d.month(), d.day());
                    create.addChildElement(name, FT_NAMESPACE, FT_PREFIX).addTextNode(dt.format('yyyy-MM-dd\'T\'HH:mm:ss'));
                } else if (value instanceof Decimal) {
                    Decimal d = (Decimal) value;
                    create.addChildElement(name, FT_NAMESPACE, FT_PREFIX).addTextNode(String.valueOf(d));
                }
            }
        }
    }
}