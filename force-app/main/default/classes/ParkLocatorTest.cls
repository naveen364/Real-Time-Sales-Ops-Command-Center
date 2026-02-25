@isTest
public class ParkLocatorTest {
    @isTest
    public static void res(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        ParkLocator.country('Germany');
    }
}