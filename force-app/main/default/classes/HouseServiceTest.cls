@isTest
public class HouseServiceTest {
  @isTest
  static void getShouldReturn200() {
    // GET request with a valid Id should
    // return 200 and the House__c object

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/' + house.Id;
    RestContext.request.httpMethod = 'GET';

    //Act
    Test.startTest();
    HouseService.getHouseById();
    Test.stopTest();

    // Assert
    House__c restHouse = (House__c) JSON.deserialize(
      RestContext.response.responseBody.toString(),
      House__c.class
    );
    System.assertEquals(200, RestContext.response.statusCode);
    System.assertEquals(house.Id, restHouse.Id);
  }

  @isTest
  static void getShouldReturn404() {
    // GET request with an invalid Id
    // should return 404

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/abcdefg';
    RestContext.request.httpMethod = 'GET';

    //Act
    Test.startTest();
    HouseService.getHouseById();
    Test.stopTest();

    // Assert
    System.assertEquals(404, RestContext.response.statusCode);
  }

  @IsTest
  static void postShouldCreateHouseAndReturn201() {
    // POST request with valid request body should
    // Create a new House__c object and return 201

    // Arrange
    String requestJson = '{"attributes": {"type": "House__c"},"Address__c": "234 Main St.","City__c":"Phoenix","State__c":"AZ","Zip_Code__c":"85018","Square_Feet__c":"2000","Bathrooms__c":"2.5","Bedrooms__c":"3"}';
    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House';
    RestContext.request.httpMethod = 'POST';
    RestContext.request.requestBody = Blob.valueOf(requestJson);

    // Act
    Test.startTest();
    HouseService.createHouse();
    Test.stopTest();

    // Assert
    Integer houseCount = [SELECT COUNT() FROM House__c];
    System.assertEquals(1, houseCount);
    System.assertEquals(201, RestContext.response.statusCode);
  }

  @isTest
  static void postShouldReturn400() {
    // POST request with nonsense in the request body
    // should return 400 Bad Request.

    // Arrange
    String requestJson = '{"bad": "json"}';
    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House';
    RestContext.request.httpMethod = 'POST';
    RestContext.request.requestBody = Blob.valueOf(requestJson);

    //Act
    Test.startTest();
    HouseService.createHouse();
    Test.stopTest();

    // Assert
    Integer houseCount = [SELECT COUNT() FROM House__c];
    System.assertEquals(0, houseCount);
    System.assertEquals(400, RestContext.response.statusCode);
  }

  @isTest
  static void patchShouldUpdateHouseAndReturn204() {
    // PATCH request with valid request body
    // and Id should return update House__c and
    // return 204

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    String requestJson = '{"attributes": {"type": "House__c"},"Address__c": "234 Main St.","City__c":"Phoenix","State__c":"AZ","Zip_Code__c":"85018","Square_Feet__c":"2000","Bathrooms__c":"2.5","Bedrooms__c":"3"}';
    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/' + house.Id;
    RestContext.request.httpMethod = 'PATCH';
    RestContext.request.requestBody = Blob.valueOf(requestJson);

    //Act
    Test.startTest();
    HouseService.updateExistingHouse();
    Test.stopTest();

    // Assert
    List<House__c> newHouses = [SELECT Id, Address__c FROM House__c];
    System.assertEquals(1, newHouses.size());
    System.assertEquals(204, RestContext.response.statusCode);
    System.assertEquals('234 Main St.', newHouses[0].Address__c);
  }

  @isTest
  static void patchWithBadIdShouldReturn404() {
    // PATCH request with valid request body
    // but an invalid Id should return 404

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    String requestJson = '{"attributes": {"type": "House__c"},"Address__c": "234 Main St.","City__c":"Phoenix","State__c":"AZ","Zip_Code__c":"85018","Square_Feet__c":"2000","Bathrooms__c":"2.5","Bedrooms__c":"3"}';
    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/abcdefg';
    RestContext.request.httpMethod = 'PATCH';
    RestContext.request.requestBody = Blob.valueOf(requestJson);

    //Act
    Test.startTest();
    HouseService.updateExistingHouse();
    Test.stopTest();

    // Assert
    List<House__c> newHouses = [SELECT Id, Address__c FROM House__c];
    System.assertEquals(1, newHouses.size());
    System.assertEquals(404, RestContext.response.statusCode);
    System.assertEquals('1 N. Test Ave.', newHouses[0].Address__c);
  }

  @isTest
  static void Patch_Should_Return_400() {
    // PATCH request with invalid request body
    // but a valid Id should return 400

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    String requestJson = '{"bad": "json"}';
    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/' + house.Id;
    RestContext.request.httpMethod = 'PATCH';
    RestContext.request.requestBody = Blob.valueOf(requestJson);

    //Act
    Test.startTest();
    HouseService.updateExistingHouse();
    Test.stopTest();

    // Assert
    List<House__c> newHouses = [SELECT Id, Address__c FROM House__c];
    System.assertEquals(1, newHouses.size());
    System.assertEquals(400, RestContext.response.statusCode);
    System.assertEquals('1 N. Test Ave.', newHouses[0].Address__c);
  }

  @isTest
  static void Delete_Should_Return_204() {
    // DELETE request with a valid Id
    // should return 204

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/' + house.Id;
    RestContext.request.httpMethod = 'DELETE';

    //Act
    Test.startTest();
    HouseService.deleteHouseById();
    Test.stopTest();

    // Assert
    Integer houseCount = [SELECT COUNT() FROM House__c];
    System.assertEquals(204, RestContext.response.statusCode);
    System.assertEquals(0, houseCount);
  }

  @isTest
  static void Delete_With_Bad_Id_Should_Return_204() {
    // DELETE request with an invalid Id
    // should return 204

    // Arrange
    House__c house = new House__c();
    house.Address__c = '1 N. Test Ave.';
    house.City__c = 'Phoenix';
    house.State__c = 'AZ';
    house.Zip_Code__c = '85004';
    insert house;

    RestContext.request = new RestRequest();
    RestContext.response = new RestResponse();
    RestContext.request.requestURI = '/services/apexrest/House/abcdef';
    RestContext.request.httpMethod = 'DELETE';

    //Act
    Test.startTest();
    HouseService.deleteHouseById();
    Test.stopTest();

    // Assert
    Integer houseCount = [SELECT COUNT() FROM House__c];
    System.assertEquals(204, RestContext.response.statusCode);
    System.assertEquals(1, houseCount);
  }
}
