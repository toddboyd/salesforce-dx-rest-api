@RestResource(urlMapping='/House/*')
global with sharing class HouseService {
    public HouseService() {
    }

    /*
        Method:         POST /House
        Status Codes:   201 Created
                        400 Bad Request
                        500 Internal Server Error

    */
    @HttpPost
    global static void createHouse() {
        RestResponse response = RestContext.response;
        String requestBody = System.RestContext.request.requestBody.toString();
        House__c house = (House__c)JSON.deserialize(requestBody, House__c.class);
        try {
            insert house;
            response.statusCode = 201;
            response.responseBody = Blob.valueOf(house.Id);
        } 
        catch(DmlException e) {
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(e.getMessage());
        } 
        catch(Exception e) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(e.getMessage());
        }        
    }
    
    /*
        Method:         GET /House/{Id}
        Status Codes:   200 Success
                        404 Not Found
                        500 Internal Server ERror
    */
    @HttpGet
    global static House__c getHouseById() {
        RestResponse response = RestContext.response;        
        House__c house;
        try {
            String Id = System.RestContext.request.requestURI.substringAfterLast('/');
            house = [SELECT Id, 
                            Address__c, 
                            City__C, 
                            State__C, 
                            Zip_Code__c,
                            Square_Feet__c,
                            Bedrooms__c,
                            Bathrooms__c,
                            Fireplace__c,
                            Pool__c
                    FROM    House__c 
                    WHERE   Id = :Id LIMIT 1];            
        } catch(QueryException e) {
            response.statusCode = 404;
            response.responseBody = Blob.valueOf(e.getMessage());
        } catch(Exception e) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(e.getMessage());
        }         
        return house;
    }

    /*
        Method:         PATCH /House/{Id}
        Status Codes:   204 No Content
                        400 Bad Request
                        404 Not Found

    */
    @HttpPatch
    global static void updateExistingHouse() {
        RestResponse response = RestContext.response;
        String Id = System.RestContext.request.requestURI.substringAfterLast('/');
        String requestBody = System.RestContext.request.requestBody.toString();
        House__c newHouse = (House__c)JSON.deserialize(requestBody, House__c.class);
        try {
            House__c oldHouse = [SELECT Id
                        FROM   House__c 
                        WHERE  Id = :Id LIMIT 1];
            oldHouse.Address__c = newHouse.Address__c;
            oldHouse.City__c = newHouse.City__c;
            oldHouse.State__c = newHouse.State__c;
            oldHouse.Zip_Code__c = newHouse.Zip_Code__c;
            oldHouse.Square_Feet__c = newHouse.Square_Feet__c;
            oldHouse.Bedrooms__c = newHouse.Bedrooms__c;
            oldHouse.Bathrooms__c = newHouse.Bathrooms__c;
            update oldHouse;
            response.statusCode = 204;
        } catch(DmlException e) {
            System.debug(e.getMessage());
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(e.getMessage());
        } catch(Exception e) {
            response.statusCode = 404;
            response.responseBody = Blob.valueOf(e.getMessage());
        }        
    }

    /*
        Method:         DELETE /House/{Id}
        Status Codes:   204 No Content
                        400 Bad Request
                        500 Internal Server Error

    */
    @HttpDelete
    global static void deleteHouseById() {
        RestResponse response = RestContext.response;        
        try {
            String Id = System.RestContext.request.requestURI.substringAfterLast('/');
            House__c house = [SELECT Id FROM House__c WHERE Id = :Id LIMIT 1];
            delete house;
            response.statusCode = 204;
        } catch(QueryException e) {
            response.statusCode = 204;
        } catch(DmlException e) {
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(e.getMessage());
        } catch(Exception e) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(e.getMessage());
        }        
    }
}
