var backpackModule = angular.module('backpackApp', []);

backpackModule.controller('backpackController', ['$scope', '$http', '$window', function($scope, $http, $window) {

	'use strict';

 	$scope.getData = function() {
        $http({
            method : "GET",
            url : "/get_data",
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(function mySucces(response) {
        	debugger;
        	console.log(JSON.parse(response.data).message);
        }, function myError(response) {

        });
	};     

	var init = function() {
		$scope.getData();		
	}; 	

	init();

}]);
