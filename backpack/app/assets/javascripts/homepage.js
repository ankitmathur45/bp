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
        	console.log(response.data.message);
        	var infoRows = response.data.info;
        	for(var i=0; i<infoRows.length; i++) {
        		infoRows[i]["date"] = moment(infoRows[0].date_time).format("D MMM, YYYY");
        		infoRows[i]["time"] = moment(infoRows[0].date_time).format("HH:mm");
        	};
        	//debugger;
        	$scope.infos = response.data.info;
        	$scope.rowSpan = response.data.length;
        }, function myError(response) {
        	console.log("Error");
        });
	};

 	$scope.getInfo = function(index) {
        $http({
            method : "POST",
            url : "/get_info",
            headers: {
                'Content-Type': 'application/json'
            },
            data: {
            	id: $scope.infos[index].id
            }
        }).then(function mySucces(response) {
        	console.log(response.data.message);
        	//$scope.imageValue = atob(response.data.info.info_value);
        	var info_type = response.data.info.info_type;
        	if(info_type=='Image') {
        		$scope.imageValue = "data:image/png;base64," + response.data.info.info_value;
        	}
        	if(info_type=='Audio') {
				var Sound = (function () {
				    var df = document.createDocumentFragment();
				    return function Sound(src) {
				        var snd = new Audio(src);
				        df.appendChild(snd); // keep in fragment until finished playing
				        snd.addEventListener('ended', function () {df.removeChild(snd);});
				        snd.play();
				        return snd;
				    }
				}());

				var snd = Sound("data:audio/wav;base64," + response.data.info.info_value);
        	}        	
        	if(info_type=='GPS') {
        		$scope.lat_long = response.data.info.info_value;
        	}
        }, function myError(response) {
        	console.log("Error");
        });
	};


	var init = function() {
		
		var members = [
		  {name: "john", team: 1},
		  {name: "kevin", team: 1},
		  {name: "rob", team: 2},
		  {name: "matt", team: 2},
		  {name: "clint", team: 3},
		  {name: "will", team: 3}
		];
		var groups = members.reduce(function(obj,item){
		    obj[item.team] = obj[item.team] || [];
		    obj[item.team].push(item.name);
		    return obj;
		}, {});
		debugger;


		$scope.getData();		
	}; 	

	init();

}]);