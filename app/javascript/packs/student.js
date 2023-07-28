var age = document.getElementById('age');
var date_of_birth = document.getElementById('date-of-birth').addEventListener('change', updateStudentAge);

var classCategorySelect = $('#class-category-select');
var sectionSelect = $('#section-select');
updateSections();
classCategorySelect.on('change', function () {
	updateSections();
});

function updateSections() {
	var selectedClassCategoryId = classCategorySelect.val();
	$.ajax({
		url: `/class_categories/${selectedClassCategoryId}/sections`,
		method: 'GET',
		data: { class_category_id: selectedClassCategoryId },
		success: function (data) {
			sectionSelect.empty();
			data.forEach(function (section) {
				sectionSelect.append($('<option>', {
					value: section.id,
					text: section.section
				}));
			});
		},
		error: function () {
		}
	});
}

function updateStudentAge() {
	var date_of_birth = document.getElementById('date-of-birth').value;

	var diffDate = new Date(new Date() - new Date(date_of_birth));
	age.value = (diffDate.toISOString().slice(0, 4) - 1970);
}

