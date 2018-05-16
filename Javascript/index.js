var $tbody = document.querySelector("tbody");
var $dateInput = document.querySelector("#datetime");
var $cityInput = document.querySelector("#city");
var $stateInput = document.querySelector("#state");
var $countryInput = document.querySelector("#country");
var $shapeInput = document.querySelector("#shape");
var $searchBtn = document.querySelector("#search");

$searchBtn.addEventListener("click", handleSearchButtonClick);

var filteredAliens = dataSet;

function handleSearchButtonClick(){

    var filterDate = $dateInput.value;
    var filterCity = $cityInput.value.trim().toLowerCase();
    var filterState = $stateInput.value.trim().toLowerCase();
    var filterCountry = $countryInput.value.trim().toLowerCase();
    var filterShape = $shapeInput.value.trim().toLowerCase();

    if ((filterDate !="") && (filterDate >="1/1/2010") && (filterDate <="5/8/2014")) {
        filteredAliens = dataSet.filter(function(aliens){
        var aliensDate = aliens.datetime
        return aliensDate === filterDate;
        }); 
    }
//    else {alert("No UFOs were sighted on this date. Please enter a date between 1/1/2010 and 5/8/2014")};

    if (filterCity !=""){
            filteredAliens = dataSet.filter(function(aliens){
            var aliensCity = aliens.city
            return aliensCity === filterCity;
        });
        
    }
 
    if (filterState !=""){
        filteredAliens = dataSet.filter(function(aliens){
        var aliensState = aliens.state
        return aliensState === filterState;
        });
    }
    
    if (filterCountry !=""){
        filteredAliens = dataSet.filter(function(aliens){
        var aliensCountry = aliens.country;
        return aliensCountry === filterCountry;
        });
    }

    if (filterShape !=""){
        filteredAliens = dataSet.filter(function(aliens){
        var aliensShape = aliens.shape
        return aliensShape === filterShape;
        });
    }
   renderTable();
}

function renderTable(){
    $tbody.innerHTML = "";
    for (var i = 0; i < filteredAliens.length; i++){
        var aliens = filteredAliens[i];
        var fields = Object.keys(aliens);     
        var $row = $tbody.insertRow(i);
        for (var j = 0; j < fields.length; j++){
            var field = fields[j];
            var $cell = $row.insertCell(j);
            $cell.innerText = aliens[field];
        }
    }
}

function clearFields() {
    document.getElementById("datetime").value="";
    document.getElementById("city").value="";
    document.getElementById("state").value="";
    document.getElementById("country").value="";
    document.getElementById("shape").value="";
}

$(document).ready( function () {
    $('#table').DataTable();
} );

renderTable();
