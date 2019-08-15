# Salesforce DX REST API

This code accompanies the following tutorials:

 1. [Create a REST API with Salesforce DX, part 1](https://sfdcdev.net/create-a-rest-api-with-saelsforce-dx/)
 2. [Create a REST API with Salesforce DX, part 2](https://sfdcdev.net/create-a-rest-api-with-salesforce-dx-part-2/)
 3. [Unit test a Salesforce REST API](https://sfdcdev.net/unit-test-a-salesforce-rest-api/)
 4. Test a Salesforce REST API with Postman

## Setup

 1. Clone this repo `git clone https://github.com/toddboyd/salesforce-dx-rest-api.git`
 2. Create a scratch org `sfdx force:org:create -a houseapi -f config\project-scratch-def.json --setdefaultusername`
 3. Push the code to your scratch org `sfdx force:source:push`

## API Documentation

### Create House
___
Method: `POST` 

URL :  `/House/` 

Request Body:
```json
{
  "attributes": {
    "type": "House__c"
  },
  "Address__c": "234 Main St.",
  "City__c":"Phoenix",
  "State__c":"AZ",
  "Zip_Code__c":"85004",
  "Square_Feet__c":"2000",
  "Bathrooms__c":"2.5",
  "Bedrooms__c":"3"
}
```

#### Success Response

Code : `201 Created` 

Response Body: `001S0000012YeslIAC`

#### Error Response

Code : `400 Bad Request`

### Update House
___

Method: `PATCH`

URL :  `/House/{Id}`

Request Body:
```json
{
  "attributes": {
    "type": "House__c"
  },
  "Address__c": "234 Main St.",
  "City__c":"Phoenix",
  "State__c":"AZ",
  "Zip_Code__c":"85004",
  "Square_Feet__c":"2000",
  "Bathrooms__c":"2.5",
  "Bedrooms__c":"3"
}
```

#### Success Response

Code : `204 No Content`

#### Error Response

Code : `400 Bad Request`

Code : `404 Not Found`

### Get House
___
Method: `GET`

URL :  `/House/{Id}`

#### Success Response

Code : `200 OK`

Response Body:
```json
{
  "attributes": {
    "type": "House__c"
  },
  "Address__c": "234 Main St.",
  "City__c":"Phoenix",
  "State__c":"AZ",
  "Zip_Code__c":"85004",
  "Square_Feet__c":"2000",
  "Bathrooms__c":"2.5",
  "Bedrooms__c":"3"
}
```

#### Error Response

Code : `400 Bad Request`

Code : `404 Not Found`

### Delete House
___
Method: `DELETE`

URL :  `/House/{Id}`

#### Success Response

Code : `204 No Content`

Response Body:
```json
{
  "attributes": {
    "type": "House__c"
  },
  "Address__c": "234 Main St.",
  "City__c":"Phoenix",
  "State__c":"AZ",
  "Zip_Code__c":"85004",
  "Square_Feet__c":"2000",
  "Bathrooms__c":"2.5",
  "Bedrooms__c":"3"
}
```

#### Error Response

Code : `400 Bad Request`

