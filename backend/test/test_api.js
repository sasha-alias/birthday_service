const request = require('request');
const assert = require('assert');

const api = require("../src/api.js");
const birthday_registry = require("../src/birthday_registry.js");

const PORT = process.env.BIRTHDAY_PORT || 3000;

var test_url = 'http://localhost:' + PORT;

describe("Birthday API", function(){
    it("saves new birthday with status 201", function(done){
        request({
            url: test_url+'/hello/api_test_account',
            method: 'PUT',
            json: {"dateOfBirth": "2000-01-02"}
        }, function(error, response, body){
            assert.equal(response.statusCode, 201);
            done();
        });
    });

    it("returns 500 on invalid input", function(done){
        request({
            url: test_url+'/hello/api_test_account',
            method: 'PUT',
            json: {"dateOfBirth": "blablabla"}
        }, function(error, response, body){
            assert.equal(response.statusCode, 500);
            done();
        });
    });

    it("returns the number of days till the birthday with status 200", function(done){
        request.get(test_url+'/hello?name=api_test_account', function(error, response, body){
            assert.equal(response.statusCode, 200);
            done();
        });
    })

    it("the number of days till the birthday of not existing user returns status 404", function(done){
        request.get(test_url+'/hello?name=not_existing_user', function(error, response, body){
            assert.equal(response.statusCode, 404);
            done();
        });
    })
})
