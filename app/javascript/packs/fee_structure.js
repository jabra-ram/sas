
function updateTotal() {
  var admissionFees = parseFloat(document.getElementById('admission-fees').value) || 0;
  var annualAdmissionFees = parseFloat(document.getElementById('annual-admission-fees').value) || 0;
  var cautionMoney = parseFloat(document.getElementById('caution-money').value) || 0;
  var quarterlyTuitionFees = parseFloat(document.getElementById('quarterly-tuition-fees').value) || 0;
  var idCardFees = parseFloat(document.getElementById('id-card-fees').value) || 0;

  var total = admissionFees + annualAdmissionFees + cautionMoney + quarterlyTuitionFees + idCardFees;

  document.getElementById('total-fees').value = total;
}

document.getElementById('admission-fees').addEventListener('keyup', updateTotal);
document.getElementById('annual-admission-fees').addEventListener('keyup', updateTotal);
document.getElementById('caution-money').addEventListener('keyup', updateTotal);
document.getElementById('quarterly-tuition-fees').addEventListener('keyup', updateTotal);
document.getElementById('id-card-fees').addEventListener('keyup', updateTotal);
