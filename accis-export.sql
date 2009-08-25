USE Medadmin
select
	-- appointment.type,
	-- appointment_id,
	'888827' AS delivery_site,
	'' AS site_code,
	'9079' as accs_program_number,
	'71355650001' as functional_centre_number,
	lower(person.fname) as first_name,
	lower(person.lname) as last_name,
	person.carecard AS PHN,
	'' AS ULI,
	patient.file_number,
	REPLACE(person.postalzip, ' ', '') AS postal_code,
	convert(varchar(8), person.birthdate, 112) as birth_date,
	sex.sex as gender,
	'01 / Provincial' as responsibility_for_payment,
	CONVERT(varchar(8), CAST(convert(varchar(5), appointment.year) + '-' + convert(varchar(5), appointment.month) + '-' + convert(varchar(5), appointment.day) AS datetime), 112) as service_visit_date,
	'N' as admit_via_ambulance,
	'1' as mode_of_service,
	'' as main_diagnosis,
	'' as secondary_diagnosis,
	'' as main_intervention,
	'' as main_intervention_status_attribute,
	'DI' as main_intevention_locaion_attribute,
	'' as main_intervention_extent_attribute,
	'' as other_intervention,	
	'' as other_intervention_status_attribute,
	'' as other_intevention_locaion_attribute,
	'' as other_intervention_extent_attribute,
	'03112' as provider_type,
	person_1.fname,
	person_1.lname,
	'' AS visit_disposition
 
FROM appointment
	INNER JOIN patient on appointment.patient_id = patient.patient_id
	INNER JOIN person on patient.person_id = person.person_id
	INNER JOIN sex ON dbo.person.sex_id = dbo.sex.sex_id
	INNER JOIN appt_type on appointment.type = appt_type.type
	INNER JOIN physician on appointment.physician_id = physician.physician_id
	INNER JOIN person as person_1 on physician.person_id = person_1.person_id

WHERE appointment.year = '2009' and appointment.month = '7'
AND appointment.type IN ('F/U Knee', 'F/U Hip', 'Initial Hip', 'Initial Knee', 'Teaching Class') -- this filters out only central intake patient types.  Not the best way to do this, but the only working way we have
AND appointment.physician_id IN (67516, 7229, 7214, 3518, 7199, 643, 7460) -- physician_id's for Paul Duffy Allan McDonald, Donna Shewchuck, Stephen Miller, Ed Rendall, Brian Burkart and Dr. Case Manager

ORDER BY appointment.day, appointment.physician_id, appointment.start_time

-- SELECT * from appointment where year = Year(getdate()) and month = Month(getdate())
-- SELECT * FROM Physician