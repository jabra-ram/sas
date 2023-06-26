function updateAge(){
    var date_as_on = document.getElementById('date-as-on').value;
    var date_of_birth_after = document.getElementById('date-of-birth-after').value;
  
    var diffDate = new Date(new Date(date_as_on) - new Date(date_of_birth_after));
    age.value = (diffDate.toISOString().slice(0, 4) - 1970);
}

var age = document.getElementById('age');
var date_as_on = document.getElementById('date-as-on').addEventListener('change', updateAge);
var date_of_birth_after = document.getElementById('date-of-birth-after').addEventListener('change', updateAge);

