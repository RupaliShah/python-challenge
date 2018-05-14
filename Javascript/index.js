var $tbody = document.querySelector("tbody");
var $dateInput = document.querySelector("date");
var $searchBtn = document.querySelector("search");
var $filteredAlienData = dataSet;

$searchBtn.AddEventListener("click", handleSearchButtonClick);

function handleSearchButtonClick(){
    var filterDate = $dateInput.value.trim();
    filteredAlienData = dataSet.filter(function(alien){
        var alienDate = alien.date;
        return alienDate == filterDate;
    });
    renderTable();
}


function renderTable(){
    tbody.innerHTML = "";
    for (var i = 0; i < filteredAlienData.length; i++){
        var alien = filteredAlienData[i];
        var fields = Object.keys(alienData);
        var $row = $tbody.insertRow(i);
        for (var j = 0; j < fields.length; j++){
            var field = fields[j];
            var $cell = $row.insertCell(j);
            $cell.innerText = alien[field];
        }

    }
}
renderTable();
