var backpackModule = angular.module('backpackApp', []);

backpackModule.controller('backpackController', ['$scope', '$http', '$window', function($scope, $http, $window) {

	'use strict';

	$scope.infos = [];

 	$scope.getData = function() {
        $http({
            method : "GET",
            url : "/get_data",
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(function mySucces(response) {
        	debugger;
        	console.log(response.data.message);
        	$scope.infos = response.data.info;
        }, function myError(response) {
        	console.log("Error");
        });
	};

 	$scope.getData = function(index) {
        $http({
            method : "POST",
            url : "/get_info",
            headers: {
                'Content-Type': 'application/json'
            },
            data: {
            	//id: $scope.infos[index].id
            }
        }).then(function mySucces(response) {
        	console.log(response.data.message);
        	$scope.infos = response.data.info;
        }, function myError(response) {
        	console.log("Error");
        });
	};

	var init = function() {
		$scope.getData();		
	}; 	

	init();

}]);
