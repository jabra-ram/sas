function updateStudentAge(){
    var date_of_birth = document.getElementById('date-of-birth').value;
  
    var diffDate = new Date(new Date() - new Date(date_of_birth));
    age.value = (diffDate.toISOString().slice(0, 4) - 1970);
}
var age = document.getElementById('age');
var date_of_birth = document.getElementById('date-of-birth').addEventListener('change', updateStudentAge);

