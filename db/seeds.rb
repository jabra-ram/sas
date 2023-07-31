# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Admin.create(email: 'admin@gmail.com', password: '123456', password_confirmation: '123456')

section1 = Section.create(section: 'A')
section2 = Section.create(section: 'B')
Section.create(section: 'C')
Section.create(section: 'D')

class1 = ClassCategory.create(classname: '1')
class2 = ClassCategory.create(classname: '2')
class3 = ClassCategory.create(classname: '3')
class4 = ClassCategory.create(classname: '4')

class1.sections << section1
class1.sections << section2
class2.sections << section1
class2.sections << section2
class3.sections << section1
class4.sections << section1

FeeStructure.create(admission_fees: 1000, annual_admission_fees: 500, caution_money: 500, quarterly_tuition_fees: 400,
                    id_card_fees: 100, total: 2600, class_category_id: 1)
FeeStructure.create(admission_fees: 2000, annual_admission_fees: 700, caution_money: 700, quarterly_tuition_fees: 400,
                    id_card_fees: 200, total: 4000, class_category_id: 2)

AgeCriterium.create(date_of_birth_after: '31-03-2017', date_of_birth_before: '01-04-2018', age: 5,
                    date_as_on: '01-04-2023', class_category_id: 1)
AgeCriterium.create(date_of_birth_after: '31-03-2016', date_of_birth_before: '01-04-2017', age: 6,
                    date_as_on: '01-04-2023', class_category_id: 2)

s1 = Student.create(name: 'Rahul Gupta', email: 'rahul23@gmail.com', date_of_birth: '01-07-2017', age: 5,
                    academic_year: 2023, father_name: 'Vivek Gupta', mother_name: 'Geeta Gupta',
                    address: 'Sector-5, Kolkata',
                    contact_number: 1_234_567_890, class_category_id: 1, section_id: 1)
s2 = Student.create(name: 'Rakesh Pareek', email: 'rakesh123@gmail.com', date_of_birth: '14-04-2017', age: 5,
                    academic_year: 2023, father_name: 'Manish Pareek', mother_name: 'Riya Pareek',
                    address: 'Nabapally, Sector-4, Kolkata',
                    contact_number: 369_635_334, class_category_id: 1, section_id: 1)
s3 = Student.create(name: 'Arvind Kumar', email: 'arvind43@gmail.com', date_of_birth: '18-03-2016', age: 6,
                    academic_year: 2023, father_name: 'Raj Kumar', mother_name: 'Shreya Kumar',
                    address: 'Chingarighata, Sector-4, Kolkata',
                    contact_number: 3_695_635_390, class_category_id: 2, section_id: 1)
s4 = Student.create(name: 'Azad Singh', email: 'azad90@gmail.com', date_of_birth: '08-03-2017', age: 6,
                    academic_year: 2023, father_name: 'Manoj Singh', mother_name: 'Priya Singh',
                    address: 'Bali, Kolkata',
                    contact_number: 9_675_635_782, class_category_id: 2, section_id: 2)
s5 = Student.create(name: 'Megha Yadav', email: 'megha432@gmail.com', date_of_birth: '24-10-2016', age: 6,
                    academic_year: 2023, father_name: 'Presh Yadav', mother_name: 'Sita Yadav',
                    address: 'Sector-4, Kolkata',
                    contact_number: 9_500_635_390, class_category_id: 2, section_id: 1)
path = Rails.root.join('app', 'assets', 'images')
path2 = Rails.root.join('app', 'assets', 'docs')
s1.photo.attach(io: File.open(path.join('profile.webp')), filename: 'profile.webp')
s2.photo.attach(io: File.open(path.join('profile.webp')), filename: 'profile.webp')
s3.photo.attach(io: File.open(path.join('profile.webp')), filename: 'profile.webp')
s4.photo.attach(io: File.open(path.join('profile.webp')), filename: 'profile.webp')
s5.photo.attach(io: File.open(path.join('profile.webp')), filename: 'profile.webp')

s1.docs.attach(io: File.open(path2.join('dummy.pdf')), filename: 'dummy.pdf')
s2.docs.attach(io: File.open(path2.join('dummy.pdf')), filename: 'dummy.pdf')
s3.docs.attach(io: File.open(path2.join('dummy.pdf')), filename: 'dummy.pdf')
s4.docs.attach(io: File.open(path2.join('dummy.pdf')), filename: 'dummy.pdf')
s5.docs.attach(io: File.open(path2.join('dummy.pdf')), filename: 'dummy.pdf')

Payment.create(mode_of_payment: 1, amount: 2500, status: 2, notes: 'All Clear', student_id: 1)
Payment.create(mode_of_payment: 2, amount: 2500, status: 2, notes: 'All Clear', student_id: 2)
