"CREATE OR REPLACE FUNCTION public.func_admission_clg_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.admission_clg
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::BIGINT
        FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_clg_email_exist(p_id bigint, p_company_id bigint, p_email text)
 RETURNS TABLE(id bigint, email text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Check for existing email in admission_clg (case-insensitive),
    -- excluding the current record (p_id).
    RETURN QUERY
    SELECT ac.id, ac.email
    FROM public.admission_clg ac
    WHERE ac.company_id = p_company_id
      AND LOWER(TRIM(ac.email)) = LOWER(TRIM(p_email))
      AND ac.id <> p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_clg_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, company_id bigint, course_id bigint, course_name text, admission_date timestamp without time zone, course_type_id bigint, course_type_name text, entry_type text, gender text, first_name text, last_name text, user_name text, father_name text, mother_name text, dob date, category text, address text, district_id bigint, district_name text, state_id bigint, state_name text, country_id bigint, country_name text, city_name text, zip_code text, corr_address text, corr_district_id bigint, corr_district_name text, corr_state_id bigint, corr_state_name text, corr_country_id bigint, corr_country_name text, corr_city_name text, corr_zip_code text, email text, phone_no text, religion text, blood_group text, medium text, father_qualification text, father_occupation text, father_organisation text, father_designation text, father_phone_no text, father_email text, father_aadhaar_no text, mother_qualification text, mother_occupation text, mother_organisation text, mother_designation text, mother_phone_no text, mother_email text, mother_aadhaar_no text, student_aadhaar_no text, samagra_id_no text, staff_child text, sibling_in_college text, parents_ex_college text, guardian_name text, guardian_phone_no text, high_school_board text, high_school_year bigint, high_school_roll_no text, high_school_percentage numeric, intermediate_board text, intermediate_year bigint, intermediate_roll_no text, intermediate_stream text, intermediate_percentage numeric, diploma_college text, diploma_university text, diploma_registration_no text, diploma_course_id bigint, diploma_course_name text, diploma_passing_year bigint, diploma_cgpa numeric, ug_college text, ug_university text, ug_registration_no text, ug_course_id bigint, ug_course_name text, ug_passing_year bigint, ug_cgpa numeric, pg_college text, pg_university text, pg_registration_no text, pg_course_id bigint, pg_course_name text, pg_passing_year bigint, pg_cgpa numeric, undertaking text, transport_facility text, transport_route text, hostel_facility text, hostel_occupancy text, scholarship_student text, family_samagra_id text, student_pen_no text, photo text, aadhaar_card text, other_certificate text, father_aadhaar text, mother_aadhaar text, samagra_id text, transfer_certificate text, high_school_marksheet text, intermediate_marksheet text, diploma_marksheet text, ug_marksheet text, pg_marksheet text, anti_ragging text, student_undertaking text, parents_undertaking text, father_photo text, mother_photo text, status text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        a.id,
        a.company_id,
        a.course_id,
        c.course_name,
		a.admission_date,
        a.course_type_id,
		ct.course_type_name,
        a.entry_type,
        a.gender,
        a.first_name,
        a.last_name,
        a.user_name,
        a.father_name,
        a.mother_name,
        a.dob,
        a.category,
        a.address,
        a.district_id,
        d.district_name,
        a.state_id,
        s.state_name,
        a.country_id,
        cn.country_name,
        a.city_name,
        a.zip_code,
        a.corr_address,
        a.corr_district_id,
        cd.district_name,
        a.corr_state_id,
        cs.state_name,
        a.corr_country_id,
        cc.country_name,
        a.corr_city_name,
        a.corr_zip_code,
        a.email,
        a.phone_no,
        a.religion,
        a.blood_group,
        a.medium,
        a.father_qualification,
        a.father_occupation,
        a.father_organisation,
        a.father_designation,
        a.father_phone_no,
        a.father_email,
        a.father_aadhaar_no,
        a.mother_qualification,
        a.mother_occupation,
        a.mother_organisation,
        a.mother_designation,
        a.mother_phone_no,
        a.mother_email,
        a.mother_aadhaar_no,
        a.student_aadhaar_no,
        a.samagra_id_no,
        a.staff_child,
        a.sibling_in_college,
        a.parents_ex_college,
        a.guardian_name,
        a.guardian_phone_no,
        a.high_school_board,
        a.high_school_year,
        a.high_school_roll_no,
        a.high_school_percentage,
        a.intermediate_board,
        a.intermediate_year,
        a.intermediate_roll_no,
        a.intermediate_stream,
        a.intermediate_percentage,
        a.diploma_college,
        a.diploma_university,
        a.diploma_registration_no,
        a.diploma_course_id,
        dc.course_name,
        a.diploma_passing_year,
        a.diploma_cgpa,
        a.ug_college,
        a.ug_university,
        a.ug_registration_no,
        a.ug_course_id,
        uc.course_name,
        a.ug_passing_year,
        a.ug_cgpa,
        a.pg_college,
        a.pg_university,
        a.pg_registration_no,
        a.pg_course_id,
        pc.course_name,
        a.pg_passing_year,
        a.pg_cgpa,
        a.undertaking,
        a.transport_facility,
        a.transport_route,
        a.hostel_facility,
        a.hostel_occupancy,
        a.scholarship_student,
        a.family_samagra_id,
        a.student_pen_no,
        a.photo,
        a.aadhaar_card,
        a.other_certificate,
        a.father_aadhaar,
        a.mother_aadhaar,
        a.samagra_id,
		a.transfer_certificate,
        a.high_school_marksheet,
        a.intermediate_marksheet,
        a.diploma_marksheet,
        a.ug_marksheet,
        a.pg_marksheet,
        a.anti_ragging,
        a.student_undertaking,
        a.parents_undertaking,
        a.father_photo,
        a.mother_photo,
        a.status,
        a.created_by,
        a.created_at,
        a.modified_by,
        a.modified_at
    FROM public.admission_clg a
	LEFT JOIN public.coursetype ct ON a.course_type_id = ct.id
    LEFT JOIN public.course c ON a.course_id = c.id
    LEFT JOIN public.state s ON a.state_id = s.id
    LEFT JOIN public.country cn ON a.country_id = cn.id
    LEFT JOIN public.district d ON a.district_id = d.id
    LEFT JOIN public.state cs ON a.corr_state_id = cs.id
    LEFT JOIN public.country cc ON a.corr_country_id = cc.id
    LEFT JOIN public.district cd ON a.corr_district_id = cd.id
    LEFT JOIN public.course dc ON a.diploma_course_id = dc.id
    LEFT JOIN public.course uc ON a.ug_course_id = uc.id
    LEFT JOIN public.course pc ON a.pg_course_id = pc.id
    WHERE a.company_id = p_company_id AND a.id = p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_clg_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));

    total_rows := (
        SELECT COUNT(*)
        FROM public.admission_clg a
		LEFT JOIN public.coursetype ct ON a.course_type_id = ct.id
        WHERE a.company_id = p_company_id
          AND (
              LOWER(COALESCE(a.first_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(a.last_name, '')) LIKE '%' || p_filter_text || '%'
			   OR LOWER(COALESCE(a.user_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(a.email, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(a.phone_no, '')) LIKE '%' || p_filter_text || '%'
			  OR LOWER(COALESCE(ct.course_type_name)) LIKE '%' || p_filter_text || '%'
          )
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_clg_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, company_id bigint, course_id bigint, course_name text, admission_date timestamp without time zone, course_type_id bigint, course_type_name text, entry_type text, gender text, first_name text, last_name text, user_name text, father_name text, mother_name text, dob date, category text, address text, district_id bigint, district_name text, state_id bigint, state_name text, country_id bigint, country_name text, city_name text, zip_code text, corr_address text, corr_district_id bigint, corr_district_name text, corr_state_id bigint, corr_state_name text, corr_country_id bigint, corr_country_name text, corr_city_name text, corr_zip_code text, email text, phone_no text, religion text, blood_group text, medium text, father_qualification text, father_occupation text, father_organisation text, father_designation text, father_phone_no text, father_email text, father_aadhaar_no text, mother_qualification text, mother_occupation text, mother_organisation text, mother_designation text, mother_phone_no text, mother_email text, mother_aadhaar_no text, student_aadhaar_no text, samagra_id_no text, staff_child text, sibling_in_college text, parents_ex_college text, guardian_name text, guardian_phone_no text, high_school_board text, high_school_year bigint, high_school_roll_no text, high_school_percentage numeric, intermediate_board text, intermediate_year bigint, intermediate_roll_no text, intermediate_stream text, intermediate_percentage numeric, diploma_college text, diploma_university text, diploma_registration_no text, diploma_course_id bigint, diploma_course_name text, diploma_passing_year bigint, diploma_cgpa numeric, ug_college text, ug_university text, ug_registration_no text, ug_course_id bigint, ug_course_name text, ug_passing_year bigint, ug_cgpa numeric, pg_college text, pg_university text, pg_registration_no text, pg_course_id bigint, pg_course_name text, pg_passing_year bigint, pg_cgpa numeric, undertaking text, transport_facility text, transport_route text, hostel_facility text, hostel_occupancy text, scholarship_student text, family_samagra_id text, student_pen_no text, photo text, aadhaar_card text, other_certificate text, father_aadhaar text, mother_aadhaar text, samagra_id text, transfer_certificate text, high_school_marksheet text, intermediate_marksheet text, diploma_marksheet text, ug_marksheet text, pg_marksheet text, anti_ragging text, student_undertaking text, parents_undertaking text, father_photo text, mother_photo text, status text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
    p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
    p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

    RETURN QUERY
    SELECT
        a.id,
        a.company_id,
        a.course_id,
        c.course_name,
		a.admission_date,
        a.course_type_id,
		ct.course_type_name,
        a.entry_type,
        a.gender,
        a.first_name,
        a.last_name,
        a.user_name,
        a.father_name,
        a.mother_name,
        a.dob,
        a.category,
        a.address,
        a.district_id,
        d.district_name,
        a.state_id,
        s.state_name,
        a.country_id,
        cn.country_name,
        a.city_name,
        a.zip_code,
        a.corr_address,
        a.corr_district_id,
        cd.district_name,
        a.corr_state_id,
        cs.state_name,
        a.corr_country_id,
        cc.country_name,
        a.corr_city_name,
        a.corr_zip_code,
        a.email,
        a.phone_no,
        a.religion,
        a.blood_group,
        a.medium,
        a.father_qualification,
        a.father_occupation,
        a.father_organisation,
        a.father_designation,
        a.father_phone_no,
        a.father_email,
		a.father_aadhaar_no,
        a.mother_qualification,
        a.mother_occupation,
        a.mother_organisation,
        a.mother_designation,
        a.mother_phone_no,
        a.mother_email,
		a.mother_aadhaar_no,
        a.student_aadhaar_no,
        a.samagra_id_no,
        a.staff_child,
        a.sibling_in_college,
        a.parents_ex_college,
        a.guardian_name,
        a.guardian_phone_no,
        a.high_school_board,
        a.high_school_year,
        a.high_school_roll_no,
        a.high_school_percentage,
        a.intermediate_board,
        a.intermediate_year,
        a.intermediate_roll_no,
        a.intermediate_stream,
        a.intermediate_percentage,
        a.diploma_college,
        a.diploma_university,
		a.diploma_registration_no,
        a.diploma_course_id,
        dc.course_name,
        a.diploma_passing_year,
        a.diploma_cgpa,
        a.ug_college,
        a.ug_university,
		a.ug_registration_no,
        a.ug_course_id,
        uc.course_name,
        a.ug_passing_year,
        a.ug_cgpa,
        a.pg_college,
        a.pg_university,
		a.pg_registration_no,
        a.pg_course_id,
        pc.course_name,
        a.pg_passing_year,
        a.pg_cgpa,
        a.undertaking,
        a.transport_facility,
        a.transport_route,
        a.hostel_facility,
        a.hostel_occupancy,
        a.scholarship_student,
        a.family_samagra_id,
        a.student_pen_no,
        a.photo,
        a.aadhaar_card,
        a.other_certificate,
        a.father_aadhaar,
        a.mother_aadhaar,
        a.samagra_id,
		a.transfer_certificate,
        a.high_school_marksheet,
        a.intermediate_marksheet,
        a.diploma_marksheet,
        a.ug_marksheet,
        a.pg_marksheet,
        a.anti_ragging,
        a.student_undertaking,
        a.parents_undertaking,
        a.father_photo,
        a.mother_photo,
        a.status,
        a.created_by,
        a.created_at,
        a.modified_by,
        a.modified_at
    FROM public.admission_clg a
	LEFT JOIN public.coursetype ct ON a.course_type_id = ct.id
    LEFT JOIN public.course c ON a.course_id = c.id
    LEFT JOIN public.course dc ON a.diploma_course_id = dc.id
    LEFT JOIN public.course uc ON a.ug_course_id = uc.id
    LEFT JOIN public.course pc ON a.pg_course_id = pc.id
    LEFT JOIN public.state s ON a.state_id = s.id
    LEFT JOIN public.state cs ON a.corr_state_id = cs.id
    LEFT JOIN public.country cn ON a.country_id = cn.id
    LEFT JOIN public.country cc ON a.corr_country_id = cc.id
    LEFT JOIN public.district d ON a.district_id = d.id
    LEFT JOIN public.district cd ON a.corr_district_id = cd.id
    WHERE (
        LOWER(TRIM(a.first_name)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.last_name)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.user_name)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.email)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.phone_no)) LIKE '%' || p_filter_text || '%'
		OR LOWER (TRIM(ct.course_type_name)) LIKE '%' || p_filter_text || '%'
    )
    AND a.company_id = p_company_id
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id END ASC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id END DESC
    LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_clg_insert(p_company_id bigint, p_data jsonb, p_photo text, p_aadhaar_card text, p_other_certificate text, p_father_aadhaar text, p_mother_aadhaar text, p_samagra_id text, p_transfer_certificate text, p_high_school_marksheet text, p_intermediate_marksheet text, p_diploma_marksheet text, p_ug_marksheet text, p_pg_marksheet text, p_anti_ragging text, p_student_undertaking text, p_parents_undertaking text, p_father_photo text, p_mother_photo text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  INSERT INTO admission_clg (
    company_id,
    course_id,
	admission_date,
    course_type_id,
    entry_type,
    gender,
    first_name,
    last_name,
    user_name,
    father_name,
    mother_name,
    dob,
    category,
    address,
    corr_address,
    district_id,
    state_id,
    country_id,
    city_name,
    zip_code,
    corr_district_id,
    corr_state_id,
    corr_country_id,
    corr_city_name,
    corr_zip_code,
    email,
    phone_no,
    religion,
    blood_group,
    medium,
    father_qualification,
    father_occupation,
    father_organisation,
    father_designation,
    father_phone_no,
    father_email,
    father_aadhaar_no,
    mother_qualification,
    mother_occupation,
    mother_organisation,
    mother_designation,
    mother_phone_no,
    mother_email,
    mother_aadhaar_no,
    student_aadhaar_no,
    samagra_id_no,
    staff_child,
    sibling_in_college,
    parents_ex_college,
    guardian_name,
    guardian_phone_no,
    high_school_board,
    high_school_year,
    high_school_roll_no,
    high_school_percentage,
    intermediate_board,
    intermediate_year,
    intermediate_roll_no,
    intermediate_stream,
    intermediate_percentage,
    diploma_college,
    diploma_university,
    diploma_registration_no,
    diploma_course_id,
    diploma_passing_year,
    diploma_cgpa,
    ug_college,
    ug_university,
    ug_registration_no,
    ug_course_id,
    ug_passing_year,
    ug_cgpa,
    pg_college,
    pg_university,
    pg_registration_no,
    pg_course_id,
    pg_passing_year,
    pg_cgpa,
    undertaking,
    transport_facility,
    transport_route,
    hostel_facility,
    hostel_occupancy,
    scholarship_student,
    family_samagra_id,
    student_pen_no,
    photo,
    aadhaar_card,
    other_certificate,
    father_aadhaar,
    mother_aadhaar,
    samagra_id,
	transfer_certificate,
    high_school_marksheet,
    intermediate_marksheet,
    diploma_marksheet,
    ug_marksheet,
    pg_marksheet,
    anti_ragging,
    student_undertaking,
    parents_undertaking,
    father_photo,
    mother_photo,
    status,
    created_at
  )
  VALUES (
    p_company_id,
    (p_data->>'course_id')::bigint,
	(p_data->>'admission_date')::date,
    (p_data->>'course_type_id')::bigint,
    p_data->>'entry_type',
    p_data->>'gender',
    p_data->>'first_name',
    p_data->>'last_name',
    p_data->>'user_name',
    p_data->>'father_name',
    p_data->>'mother_name',
    (p_data->>'dob')::date,
    p_data->>'category',
    p_data->>'address',
    p_data->>'corr_address',
    (p_data->>'district_id')::bigint,
    (p_data->>'state_id')::bigint,
    (p_data->>'country_id')::bigint,
    p_data->>'city_name',
    p_data->>'zip_code',
    (p_data->>'corr_district_id')::bigint,
    (p_data->>'corr_state_id')::bigint,
    (p_data->>'corr_country_id')::bigint,
    p_data->>'corr_city_name',
    p_data->>'corr_zip_code',
    p_data->>'email',
    p_data->>'phone_no',
    p_data->>'religion',
    p_data->>'blood_group',
    p_data->>'medium',
    p_data->>'father_qualification',
    p_data->>'father_occupation',
    p_data->>'father_organisation',
    p_data->>'father_designation',
    p_data->>'father_phone_no',
    p_data->>'father_email',
    p_data->>'father_aadhaar_no',
    p_data->>'mother_qualification',
    p_data->>'mother_occupation',
    p_data->>'mother_organisation',
    p_data->>'mother_designation',
    p_data->>'mother_phone_no',
    p_data->>'mother_email',
    p_data->>'mother_aadhaar_no',
    p_data->>'student_aadhaar_no',
    p_data->>'samagra_id_no',
    p_data->>'staff_child',
    p_data->>'sibling_in_college',
    p_data->>'parents_ex_college',
    p_data->>'guardian_name',
    p_data->>'guardian_phone_no',
    p_data->>'high_school_board',
    (p_data->>'high_school_year')::bigint,
    p_data->>'high_school_roll_no',
    (p_data->>'high_school_percentage')::numeric,
    p_data->>'intermediate_board',
    (p_data->>'intermediate_year')::bigint,
    p_data->>'intermediate_roll_no',
    p_data->>'intermediate_stream',
    (p_data->>'intermediate_percentage')::numeric,
    p_data->>'diploma_college',
    p_data->>'diploma_university',
    p_data->>'diploma_registration_no',
    (p_data->>'diploma_course_id')::bigint,
    (p_data->>'diploma_passing_year')::bigint,
    (p_data->>'diploma_cgpa')::numeric,
    p_data->>'ug_college',
    p_data->>'ug_university',
    p_data->>'ug_registration_no',
    (p_data->>'ug_course_id')::bigint,
    (p_data->>'ug_passing_year')::bigint,
    (p_data->>'ug_cgpa')::numeric,
    p_data->>'pg_college',
    p_data->>'pg_university',
    p_data->>'pg_registration_no',
    (p_data->>'pg_course_id')::bigint,
    (p_data->>'pg_passing_year')::bigint,
    (p_data->>'pg_cgpa')::numeric,
    p_data->>'undertaking',
    p_data->>'transport_facility',
    p_data->>'transport_route',
    p_data->>'hostel_facility',
    p_data->>'hostel_occupancy',
    p_data->>'scholarship_student',
    p_data->>'family_samagra_id',
    p_data->>'student_pen_no',
    p_photo,
    p_aadhaar_card,
    p_other_certificate,
    p_father_aadhaar,
    p_mother_aadhaar,
    p_samagra_id,
	p_transfer_certificate,
    p_high_school_marksheet,
    p_intermediate_marksheet,
    p_diploma_marksheet,
    p_ug_marksheet,
    p_pg_marksheet,
    p_anti_ragging,
    p_student_undertaking,
    p_parents_undertaking,
    p_father_photo,
    p_mother_photo,
    COALESCE(p_data->>'status','Active'),
    p_created_at
  );
  RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_clg_update(p_id bigint, p_company_id bigint, p_data jsonb, p_photo text, p_aadhaar_card text, p_other_certificate text, p_father_aadhaar text, p_mother_aadhaar text, p_samagra_id text, p_transfer_certificate text, p_high_school_marksheet text, p_intermediate_marksheet text, p_diploma_marksheet text, p_ug_marksheet text, p_pg_marksheet text, p_anti_ragging text, p_student_undertaking text, p_parents_undertaking text, p_father_photo text, p_mother_photo text, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  UPDATE admission_clg
  SET
    company_id = p_company_id,
    course_id = (p_data->>'course_id')::bigint,
	admission_date = (p_data->>'admission_date')::date,
    course_type_id = (p_data->>'course_type_id')::bigint,
    entry_type = p_data->>'entry_type',
    gender = p_data->>'gender',
    first_name = p_data->>'first_name',
    last_name = p_data->>'last_name',
    user_name = p_data->>'user_name',
    father_name = p_data->>'father_name',
    mother_name = p_data->>'mother_name',
    dob = (p_data->>'dob')::date,
    category = p_data->>'category',
    address = p_data->>'address',
    corr_address = p_data->>'corr_address',
    district_id = (p_data->>'district_id')::bigint,
    state_id = (p_data->>'state_id')::bigint,
    country_id = (p_data->>'country_id')::bigint,
    city_name = p_data->>'city_name',
    zip_code = p_data->>'zip_code',
    corr_district_id = (p_data->>'corr_district_id')::bigint,
    corr_state_id = (p_data->>'corr_state_id')::bigint,
    corr_country_id = (p_data->>'corr_country_id')::bigint,
    corr_city_name = p_data->>'corr_city_name',
    corr_zip_code = p_data->>'corr_zip_code',
    email = p_data->>'email',
    phone_no = p_data->>'phone_no',
    religion = p_data->>'religion',
    blood_group = p_data->>'blood_group',
    medium = p_data->>'medium',
    father_qualification = p_data->>'father_qualification',
    father_occupation = p_data->>'father_occupation',
    father_organisation = p_data->>'father_organisation',
    father_designation = p_data->>'father_designation',
    father_phone_no = p_data->>'father_phone_no',
    father_email = p_data->>'father_email',
    father_aadhaar_no = p_data->>'father_aadhaar_no',
    mother_qualification = p_data->>'mother_qualification',
    mother_occupation = p_data->>'mother_occupation',
    mother_organisation = p_data->>'mother_organisation',
    mother_designation = p_data->>'mother_designation',
    mother_phone_no = p_data->>'mother_phone_no',
    mother_email = p_data->>'mother_email',
    mother_aadhaar_no = p_data->>'mother_aadhaar_no',
    student_aadhaar_no = p_data->>'student_aadhaar_no',
    samagra_id_no = p_data->>'samagra_id_no',
    staff_child = p_data->>'staff_child',
    sibling_in_college = p_data->>'sibling_in_college',
    parents_ex_college = p_data->>'parents_ex_college',
    guardian_name = p_data->>'guardian_name',
    guardian_phone_no = p_data->>'guardian_phone_no',
    high_school_board = p_data->>'high_school_board',
    high_school_year = (p_data->>'high_school_year')::bigint,
    high_school_roll_no = p_data->>'high_school_roll_no',
    high_school_percentage = (p_data->>'high_school_percentage')::numeric,
    intermediate_board = p_data->>'intermediate_board',
    intermediate_year = (p_data->>'intermediate_year')::bigint,
    intermediate_roll_no = p_data->>'intermediate_roll_no',
    intermediate_stream = p_data->>'intermediate_stream',
    intermediate_percentage = (p_data->>'intermediate_percentage')::numeric,
    diploma_college = p_data->>'diploma_college',
    diploma_university = p_data->>'diploma_university',
    diploma_registration_no = p_data->>'diploma_registration_no',
    diploma_course_id = (p_data->>'diploma_course_id')::bigint,
    diploma_passing_year = (p_data->>'diploma_passing_year')::bigint,
    diploma_cgpa = (p_data->>'diploma_cgpa')::numeric,
    ug_college = p_data->>'ug_college',
    ug_university = p_data->>'ug_university',
    ug_registration_no = p_data->>'ug_registration_no',
    ug_course_id = (p_data->>'ug_course_id')::bigint,
    ug_passing_year = (p_data->>'ug_passing_year')::bigint,
    ug_cgpa = (p_data->>'ug_cgpa')::numeric,
    pg_college = p_data->>'pg_college',
    pg_university = p_data->>'pg_university',
    pg_registration_no = p_data->>'pg_registration_no',
    pg_course_id = (p_data->>'pg_course_id')::bigint,
    pg_passing_year = (p_data->>'pg_passing_year')::bigint,
    pg_cgpa = (p_data->>'pg_cgpa')::numeric,
    undertaking = p_data->>'undertaking',
    transport_facility = p_data->>'transport_facility',
    transport_route = p_data->>'transport_route',
    hostel_facility = p_data->>'hostel_facility',
    hostel_occupancy = p_data->>'hostel_occupancy',
    scholarship_student = p_data->>'scholarship_student',
    family_samagra_id = p_data->>'family_samagra_id',
    student_pen_no = p_data->>'student_pen_no',
    photo = p_photo,
    aadhaar_card = p_aadhaar_card,
    other_certificate = p_other_certificate,
    father_aadhaar = p_father_aadhaar,
    mother_aadhaar = p_mother_aadhaar,
    samagra_id = p_samagra_id,
	transfer_certificate = p_transfer_certificate,
    high_school_marksheet = p_high_school_marksheet,
    intermediate_marksheet = p_intermediate_marksheet,
    diploma_marksheet = p_diploma_marksheet,
    ug_marksheet = p_ug_marksheet,
    pg_marksheet = p_pg_marksheet,
    anti_ragging = p_anti_ragging,
    student_undertaking = p_student_undertaking,
    parents_undertaking = p_parents_undertaking,
    father_photo = p_father_photo,
    mother_photo = p_mother_photo,
    status = COALESCE(p_data->>'status','Active'),
    modified_at = now()
  WHERE id = p_id AND company_id = p_company_id;
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""admission"" SET status='In-active'
    WHERE id IN (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
      AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_email_exist(p_id bigint, p_company_id bigint, p_email text)
 RETURNS TABLE(id bigint, email text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY     
    SELECT
        a.id,
        a.email
    FROM public.""admission"" a
    WHERE a.id <> p_id 
      AND LOWER(TRIM(a.email)) = LOWER(TRIM(p_email))
      AND a.company_id = p_company_id; 
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, admission_date timestamp without time zone, first_name text, last_name text, dob date, gender text, email text, phone_no text, address text, city_name text, state_id bigint, state_name text, country_id bigint, country_name text, zip_code text, highschoolname text, highschoolpercentage numeric, highersschoolname text, highersschoolpercentage numeric, graduationname text, graduationpercentage numeric, tenthproof text, twelthproof text, graduationproof text, photoidproof text, photo text, is_aadhar_req text, is_birth_certi_req text, is_tc_req text, is_samagraid_req text, status text, paid_amount numeric, total_fee numeric, payment_mode text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY     
    SELECT
        a.id,      
        a.course_id,
        cr.course_name, 
        a.admission_date,
        a.first_name,
        a.last_name,
        a.dob,
        a.gender,
        a.email,
        a.phone_no,
        a.address,
        a.city_name,
        a.state_id,
        s.state_name,
        a.country_id,
        c.country_name,
        a.zip_code,
        a.highschoolname,
        a.highschoolpercentage,
        a.highersschoolname,
        a.highersschoolpercentage,
        a.graduationname,
        a.graduationpercentage,
        a.tenthproof,
        a.twelthproof,
        a.graduationproof,
        a.photoidproof,
        a.photo,
        a.is_aadhar_req,
        a.is_birth_certi_req,
        a.is_tc_req,
        a.is_samagraid_req,
        a.status,
		a.paid_amount,
   		a.total_fee,
    	a.payment_mode,
	    a.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        a.created_at,
        a.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        a.modified_at
    FROM public.""admission"" a
    LEFT JOIN public.""country"" c ON a.country_id = c.id
    LEFT JOIN public.""state"" s ON a.state_id = s.id
    LEFT JOIN public.""course"" cr ON a.course_id = cr.id
    LEFT JOIN public.""user"" u ON a.created_by = u.id
    LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
    WHERE a.id = p_id
      AND a.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, admission_date timestamp without time zone, course_id bigint, course_name text, first_name text, last_name text, dob date, gender text, email text, phone_no text, address text, city_name text, state_id bigint, state_name text, country_id bigint, country_name text, zip_code text, highschoolname text, highschoolpercentage numeric, highersschoolname text, highersschoolpercentage numeric, graduationname text, graduationpercentage numeric, tenthproof text, twelthproof text, graduationproof text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY     
    SELECT
        a.id, 
        a.admission_date,
        a.course_id,
        a.course_name, 
        a.first_name,
        a.last_name,
        a.dob,
        a.gender,
        a.email,
        a.phone_no,
        a.address,
        a.city_name,
        a.state_id,
        s.state_name,
        a.country_id,
        c.country_name,
        a.zip_code,
        a.highschoolname,
        a.highschoolpercentage,
        a.highersschoolname,
        a.highersschoolpercentage,
        a.graduationname,
        a.graduationpercentage,
        a.tenthproof,
        a.twelthproof,
        a.graduationproof
    FROM public.""admission"" a
    LEFT JOIN public.""country"" c ON a.country_id = c.id
    LEFT JOIN public.""state"" s ON a.state_id = s.id
    WHERE a.company_id = p_company_id;  

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint; 
BEGIN    
    p_filter_text = LOWER(TRIM(p_filter_text));
    total_rows = (
        SELECT COUNT(*)    
        FROM public.""admission"" a
        WHERE (
            LOWER(TRIM(a.first_name)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(a.last_name)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(a.email)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(a.phone_no)) LIKE '%' || p_filter_text || '%'
        ) AND a.company_id = p_company_id 
    );  
    RETURN total_rows;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, admission_date timestamp without time zone, first_name text, last_name text, dob date, gender text, email text, phone_no text, address text, city_name text, state_id bigint, state_name text, country_id bigint, country_name text, zip_code text, highschoolname text, highschoolpercentage numeric, highersschoolname text, highersschoolpercentage numeric, graduationname text, graduationpercentage numeric, tenthproof text, twelthproof text, graduationproof text, photoidproof text, photo text, is_aadhar_req text, is_birth_certi_req text, is_tc_req text, is_samagraid_req text, status text, paid_amount numeric, total_fee numeric, payment_mode text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));
    
    RETURN QUERY
    SELECT
        a.id,
        a.course_id,
        cr.course_name,
        a.admission_date,
        a.first_name,
        a.last_name,
        a.dob,
        a.gender,
        a.email,
        a.phone_no,
        a.address,
        a.city_name,
        a.state_id,
        s.state_name,
        a.country_id,
        c.country_name,
        a.zip_code,
        a.highschoolname,
        a.highschoolpercentage,
        a.highersschoolname,
        a.highersschoolpercentage,
        a.graduationname,
        a.graduationpercentage,
        a.tenthproof,
        a.twelthproof,
        a.graduationproof,
        a.photoidproof,
        a.photo,
        a.is_aadhar_req,
        a.is_birth_certi_req,
        a.is_tc_req,
        a.is_samagraid_req,
        a.status,
        a.paid_amount,
        a.total_fee,
        a.payment_mode,
        a.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        a.created_at,
        a.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        a.modified_at
    FROM public.""admission"" a
    LEFT JOIN public.""country"" c ON a.country_id = c.id
    LEFT JOIN public.""state"" s ON a.state_id = s.id
    LEFT JOIN public.""course"" cr ON a.course_id = cr.id
    LEFT JOIN public.""user"" u ON a.created_by = u.id
    LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
    WHERE a.company_id = p_company_id  
      AND (
        LOWER(TRIM(a.first_name)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.last_name)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.email)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(a.phone_no)) LIKE '%' || p_filter_text || '%'
    )
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id END ASC,
        CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'desc' THEN a.first_name END DESC,
        CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'asc' THEN a.first_name END ASC,
        CASE WHEN p_sort_field = 'last_name' AND p_sort_direction = 'desc' THEN a.last_name END DESC,
        CASE WHEN p_sort_field = 'last_name' AND p_sort_direction = 'asc' THEN a.last_name END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_insert(p_company_id bigint, p_course_id bigint, p_admission_date date, p_first_name text, p_last_name text, p_dob date, p_gender text, p_email text, p_phone_no text, p_address text, p_city_name text, p_state_id bigint, p_country_id bigint, p_zip_code text, p_highschoolname text, p_highschoolpercentage numeric, p_highersschoolname text, p_highersschoolpercentage numeric, p_graduationname text, p_graduationpercentage numeric, p_tenthproof text, p_twelthproof text, p_graduationproof text, p_photoidproof text, p_photo text, p_is_aadhar_req text, p_is_birth_certi_req text, p_is_tc_req text, p_is_samagraid_req text, p_status text, p_paid_amount numeric, p_total_fee numeric, p_payment_mode text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_admission_id bigint;
    v_fee_amount numeric;
    v_fee_month int;
    v_fee_year int;
    v_installments int;
    i int;
    v_freq_label text;
BEGIN
    -- Insert into admission and capture the generated ID
    INSERT INTO public.admission (
        company_id,
        course_id,
        admission_date,
        first_name,
        last_name,
        dob,
        gender,
        email,
        phone_no,
        address,
        city_name,
        state_id,
        country_id,
        zip_code,
        highschoolname,
        highschoolpercentage,
        highersschoolname,
        highersschoolpercentage,
        graduationname,
        graduationpercentage,
        tenthproof,
        twelthproof,
        graduationproof,
        photoidproof,
        photo,
        is_aadhar_req,
        is_birth_certi_req,
        is_tc_req,
        is_samagraid_req,
        status,
        paid_amount,
        total_fee,
        payment_mode,
        created_at
    ) VALUES (
        p_company_id,
        p_course_id,
        p_admission_date,
        p_first_name,
        p_last_name,
        p_dob,
        p_gender,
        p_email,
        p_phone_no,
        p_address,
        p_city_name,
        p_state_id,
        p_country_id,
        p_zip_code,
        p_highschoolname,
        p_highschoolpercentage,
        p_highersschoolname,
        p_highersschoolpercentage,
        p_graduationname,
        p_graduationpercentage,
        p_tenthproof,
        p_twelthproof,
        p_graduationproof,
        p_photoidproof,
        p_photo,
        p_is_aadhar_req,
        p_is_birth_certi_req,
        p_is_tc_req,
        p_is_samagraid_req,
        p_status,
        p_paid_amount,
        p_total_fee,
        p_payment_mode,
        p_created_at
    ) RETURNING id INTO v_admission_id;

    v_fee_month := EXTRACT(MONTH FROM p_admission_date);
    v_fee_year := EXTRACT(YEAR FROM p_admission_date);

    -- Set installments and frequency label based on payment mode
    IF LOWER(p_payment_mode) = 'monthly' THEN
        v_installments := 12;
        v_fee_amount := ROUND(p_total_fee / 12, 2);
        v_freq_label := 'Monthly';
    ELSIF LOWER(p_payment_mode) = 'quarterly' THEN
        v_installments := 4;
        v_fee_amount := ROUND(p_total_fee / 4, 2);
        v_freq_label := 'Quarterly';
    ELSIF LOWER(p_payment_mode) = 'yearly' THEN
        v_installments := 1;
        v_fee_amount := p_total_fee;
        v_freq_label := 'Yearly';
    ELSE
        RAISE EXCEPTION 'Invalid payment mode: %', p_payment_mode;
    END IF;

    -- Insert fee records based on selected frequency
    FOR i IN 0..(v_installments - 1) LOOP
        INSERT INTO public.student_monthly_fees (
            company_id,
            admission_id,
            course_id,
            fee_frequency,
            fee_month,
            fee_year,
            fee_amount,
            created_at
        ) VALUES (
            p_company_id,
            v_admission_id,
            p_course_id,
            v_freq_label,
            ((v_fee_month + i * (12 / v_installments) - 1) % 12) + 1,
            v_fee_year + ((v_fee_month + i * (12 / v_installments) - 1) / 12),
            v_fee_amount,
            now()
        );
    END LOOP;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_insert_b(p_company_id bigint, p_course_id bigint, p_admission_date date, p_first_name text, p_last_name text, p_dob date, p_gender text, p_email text, p_phone_no text, p_address text, p_city_name text, p_state_id bigint, p_country_id bigint, p_zip_code text, p_highschoolname text, p_highschoolpercentage numeric, p_highersschoolname text, p_highersschoolpercentage numeric, p_graduationname text, p_graduationpercentage numeric, p_tenthproof text, p_twelthproof text, p_graduationproof text, p_photoidproof text, p_photo text, p_is_aadhar_req text, p_is_birth_certi_req text, p_is_tc_req text, p_is_samagraid_req text, p_status text, p_paid_amount numeric, p_total_fee numeric, p_payment_mode text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_admission_id bigint;
    v_fee_amount numeric;
    v_fee_month int;
    v_fee_year int;
    v_installments int;
    i int;
    v_freq_label text;
BEGIN
    -- Insert into admission and capture the generated ID
    INSERT INTO public.admission (
        company_id,
        course_id,
        admission_date,
        first_name,
        last_name,
        dob,
        gender,
        email,
        phone_no,
        address,
        city_name,
        state_id,
        country_id,
        zip_code,
        highschoolname,
        highschoolpercentage,
        highersschoolname,
        highersschoolpercentage,
        graduationname,
        graduationpercentage,
        tenthproof,
        twelthproof,
        graduationproof,
        photoidproof,
        photo,
        is_aadhar_req,
        is_birth_certi_req,
        is_tc_req,
        is_samagraid_req,
        status,
        paid_amount,
        total_fee,
        payment_mode,
        created_at
    ) VALUES (
        p_company_id,
        p_course_id,
        p_admission_date,
        p_first_name,
        p_last_name,
        p_dob,
        p_gender,
        p_email,
        p_phone_no,
        p_address,
        p_city_name,
        p_state_id,
        p_country_id,
        p_zip_code,
        p_highschoolname,
        p_highschoolpercentage,
        p_highersschoolname,
        p_highersschoolpercentage,
        p_graduationname,
        p_graduationpercentage,
        p_tenthproof,
        p_twelthproof,
        p_graduationproof,
        p_photoidproof,
        p_photo,
        p_is_aadhar_req,
        p_is_birth_certi_req,
        p_is_tc_req,
        p_is_samagraid_req,
        p_status,
        p_paid_amount,
        p_total_fee,
        p_payment_mode,
        p_created_at
    ) RETURNING id INTO v_admission_id;

    v_fee_month := EXTRACT(MONTH FROM p_admission_date);
    v_fee_year := EXTRACT(YEAR FROM p_admission_date);

    -- Set installments and frequency label based on payment mode
    IF LOWER(p_payment_mode) = 'monthly' THEN
        v_installments := 12;
        v_fee_amount := ROUND(p_total_fee / 12, 2);
        v_freq_label := 'Monthly';
    ELSIF LOWER(p_payment_mode) = 'quarterly' THEN
        v_installments := 4;
        v_fee_amount := ROUND(p_total_fee / 4, 2);
        v_freq_label := 'Quarterly';
    ELSIF LOWER(p_payment_mode) = 'yearly' THEN
        v_installments := 1;
        v_fee_amount := p_total_fee;
        v_freq_label := 'Yearly';
    ELSE
        RAISE EXCEPTION 'Invalid payment mode: %', p_payment_mode;
    END IF;

    -- Insert fee records based on selected frequency
    FOR i IN 0..(v_installments - 1) LOOP
        INSERT INTO public.student_monthly_fees (
            company_id,
            admission_id,
            course_id,
            fee_frequency,
            fee_month,
            fee_year,
            fee_amount,
            created_at
        ) VALUES (
            p_company_id,
            v_admission_id,
            p_course_id,
            v_freq_label,
            ((v_fee_month + i * (12 / v_installments) - 1) % 12) + 1,
            v_fee_year + ((v_fee_month + i * (12 / v_installments) - 1) / 12),
            v_fee_amount,
            now()
        );
    END LOOP;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_phone_no_exist(p_id bigint, p_company_id bigint, p_phone_no text)
 RETURNS TABLE(id bigint, phone_no text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	a.id,
	a.phone_no
	FROM public.""admission"" a
	WHERE a.id <> p_id AND a.company_id = p_company_id AND LOWER(TRIM(a.phone_no)) = LOWER(TRIM(p_phone_no));
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_receipt_get(p_id bigint, p_company_id bigint, p_company_type text)
 RETURNS TABLE(id bigint, company_id bigint, admission_date timestamp without time zone, course_name text, first_name text, last_name text, price numeric)
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF LOWER(p_company_type) = 'institute' THEN
        RETURN QUERY
        SELECT 
            a.id,
            a.company_id,
            a.admission_date,
            c.course_name,
            a.first_name,
            a.last_name,
            c.price::numeric
        FROM public.admission a
        LEFT JOIN public.course c ON a.course_id = c.id
        WHERE a.company_id = p_company_id
          AND a.id = CASE 
                        WHEN p_id = 0 THEN (SELECT MAX(a2.id) FROM public.admission a2 WHERE a2.company_id = p_company_id)
                        ELSE p_id
                    END;

    ELSIF LOWER(p_company_type) = 'college' THEN
        RETURN QUERY
        SELECT 
            a.id,
            a.company_id,
            a.admission_date,
            c.course_name,
            a.first_name,
            a.last_name,
            c.price::numeric
        FROM public.admission_clg a
        LEFT JOIN public.course c ON a.course_id = c.id
        WHERE a.company_id = p_company_id
          AND a.id = CASE 
                        WHEN p_id = 0 THEN (SELECT MAX(a2.id) FROM public.admission_clg a2 WHERE a2.company_id = p_company_id)
                        ELSE p_id
                    END;

    ELSIF LOWER(p_company_type) = 'school' THEN
        RETURN QUERY
        SELECT 
            a.id,
            a.company_id,
            a.admission_date,
            c.course_name,
            a.first_name,
            a.last_name,
            c.price::numeric
        FROM public.admission_form a
        LEFT JOIN public.course c ON a.course_id = c.id
        WHERE a.company_id = p_company_id
          AND a.id = CASE 
                        WHEN p_id = 0 THEN (SELECT MAX(a2.id) FROM public.admission_form a2 WHERE a2.company_id = p_company_id)
                        ELSE p_id
                    END;

    ELSE
        RAISE EXCEPTION 'Invalid company_type: %, expected one of: institute, college, school', p_company_type;
    END IF;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admission_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_admission_date date, p_first_name text, p_last_name text, p_dob date, p_gender text, p_email text, p_phone_no text, p_address text, p_city_name text, p_state_id bigint, p_country_id bigint, p_zip_code text, p_highschoolname text, p_highschoolpercentage numeric, p_highersschoolname text, p_highersschoolpercentage numeric, p_graduationname text, p_graduationpercentage numeric, p_tenthproof text, p_twelthproof text, p_graduationproof text, p_photoidproof text, p_photo text, p_is_aadhar_req text, p_is_birth_certi_req text, p_is_tc_req text, p_is_samagraid_req text, p_status text, p_paid_amount numeric, p_total_fee numeric, p_payment_mode text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Update the admission record
    UPDATE public.admission SET 
        company_id = p_company_id,
        course_id = p_course_id,
        admission_date = p_admission_date,	
        first_name = p_first_name,
        last_name = p_last_name,
        dob = p_dob,
        gender = p_gender,
        email = p_email,
        phone_no = p_phone_no,
        address = p_address,
        city_name = p_city_name,
        state_id = p_state_id,
        country_id = p_country_id,
        zip_code = p_zip_code,
        highschoolname = p_highschoolname,
        highschoolpercentage = p_highschoolpercentage,
        highersschoolname = p_highersschoolname,
        highersschoolpercentage = p_highersschoolpercentage,
        graduationname = p_graduationname,
        graduationpercentage = p_graduationpercentage,
        tenthproof = p_tenthproof,
        twelthproof = p_twelthproof,
        graduationproof = p_graduationproof,
        photoidproof = p_photoidproof,
        photo = p_photo,
        is_aadhar_req = p_is_aadhar_req,
        is_birth_certi_req = p_is_birth_certi_req,
        is_tc_req = p_is_tc_req,
        is_samagraid_req = p_is_samagraid_req,
        status = p_status,
        paid_amount = p_paid_amount,
        total_fee = p_total_fee,
        payment_mode = p_payment_mode,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admissionform_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.admission_form
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::BIGINT
        FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admissionform_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, company_id bigint, course_id bigint, course_name text, admission_date timestamp without time zone, gender text, first_name text, last_name text, father_name text, mother_name text, dob date, category text, address text, state_id bigint, state_name text, country_id bigint, country_name text, city_name text, zip_code text, email text, phone_no text, religion text, blood_group text, boarder_day_scholar text, current_school text, current_board text, medium text, father_qualification text, father_occupation text, father_organisation text, father_designation text, father_phone_no text, father_email text, mother_qualification text, mother_occupation text, mother_organisation text, mother_designation text, mother_phone_no text, mother_email text, student_aadhaar_no text, father_aadhaar_no text, mother_aadhaar_no text, samagra_id_no text, staff_child text, sibling_in_school text, parents_ex_school text, guardian_name text, guardian_phone_no text, undertaking text, iii_language text, ii_language text, stream text, transport_facility text, mess_facility text, family_samagra_id text, student_pen_no text, photo text, aadhaar_card text, birth_certificate text, other_certificate text, father_aadhaar text, mother_aadhaar text, samagra_id text, transfer_certificate text, prev_class_marksheet text, father_photo text, mother_photo text, status text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        a.id,
        a.company_id,
        a.course_id,
        c.course_name,
		a.admission_date,
        a.gender,
        a.first_name,
        a.last_name,
        a.father_name,
        a.mother_name,
        a.dob,
        a.category,
        a.address,
        a.state_id,
        s.state_name,
        a.country_id,
        cn.country_name,
        a.city_name,
        a.zip_code,
        a.email,
        a.phone_no,
        a.religion,
        a.blood_group,
        a.boarder_day_scholar,
        a.current_school,
        a.current_board,
        a.medium,
        a.father_qualification,
        a.father_occupation,
        a.father_organisation,
        a.father_designation,
        a.father_phone_no,
        a.father_email,
        a.mother_qualification,
        a.mother_occupation,
        a.mother_organisation,
        a.mother_designation,
        a.mother_phone_no,
        a.mother_email,
        a.student_aadhaar_no,
        a.father_aadhaar_no,
        a.mother_aadhaar_no,
        a.samagra_id_no,
        a.staff_child,
        a.sibling_in_school,
        a.parents_ex_school,
        a.guardian_name,
        a.guardian_phone_no,
        a.undertaking,
        a.iii_language,
        a.ii_language,
        a.stream,
        a.transport_facility,
        a.mess_facility,
        a.family_samagra_id,
        a.student_pen_no,
        a.photo,
        a.aadhaar_card,
        a.birth_certificate,
        a.other_certificate,
        a.father_aadhaar,
        a.mother_aadhaar,
        a.samagra_id,
		a.transfer_certificate,
        a.prev_class_marksheet,
        a.father_photo,
        a.mother_photo,
		a.status,
        a.created_by,
        a.created_at,
        a.modified_by,
        a.modified_at
    FROM public.admission_form a
    LEFT JOIN public.course c ON a.course_id = c.id
    LEFT JOIN public.state s ON a.state_id = s.id
    LEFT JOIN public.country cn ON a.country_id = cn.id
    WHERE a.company_id = p_company_id AND a.id = p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admissionform_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));

    total_rows := (
        SELECT COUNT(*)
        FROM public.admission_form a
        WHERE a.company_id = p_company_id
          AND (
              LOWER(COALESCE(a.first_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(a.last_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(a.email, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(a.phone_no, '')) LIKE '%' || p_filter_text || '%'
          )
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admissionform_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, company_id bigint, course_id bigint, course_name text, admission_date timestamp without time zone, gender text, first_name text, last_name text, father_name text, mother_name text, dob date, category text, address text, state_id bigint, state_name text, country_id bigint, country_name text, city_name text, zip_code text, email text, phone_no text, religion text, blood_group text, boarder_day_scholar text, current_school text, current_board text, medium text, father_qualification text, father_occupation text, father_organisation text, father_designation text, father_phone_no text, father_email text, mother_qualification text, mother_occupation text, mother_organisation text, mother_designation text, mother_phone_no text, mother_email text, student_aadhaar_no text, father_aadhaar_no text, mother_aadhaar_no text, samagra_id_no text, staff_child text, sibling_in_school text, parents_ex_school text, guardian_name text, guardian_phone_no text, undertaking text, iii_language text, ii_language text, stream text, transport_facility text, mess_facility text, family_samagra_id text, student_pen_no text, photo text, aadhaar_card text, birth_certificate text, other_certificate text, father_aadhaar text, mother_aadhaar text, samagra_id text, transfer_certificate text, prev_class_marksheet text, father_photo text, mother_photo text, status text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
  p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
  p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

  RETURN QUERY 
  SELECT
    a.id,
    a.company_id,
    a.course_id,
    c.course_name,
	a.admission_date,
    a.gender,
    a.first_name,
    a.last_name,
    a.father_name,
    a.mother_name,
    a.dob,
    a.category,
    a.address,
    a.state_id,
    s.state_name,
    a.country_id,
    cn.country_name,
    a.city_name,
    a.zip_code,
    a.email,
    a.phone_no,
    a.religion,
    a.blood_group,
    a.boarder_day_scholar,
    a.current_school,
    a.current_board,
    a.medium,
    a.father_qualification,
    a.father_occupation,
    a.father_organisation,
    a.father_designation,
    a.father_phone_no,
    a.father_email,
    a.mother_qualification,
    a.mother_occupation,
    a.mother_organisation,
    a.mother_designation,
    a.mother_phone_no,
    a.mother_email,
    a.student_aadhaar_no,
    a.father_aadhaar_no,
    a.mother_aadhaar_no,
    a.samagra_id_no,
    a.staff_child,
    a.sibling_in_school,
    a.parents_ex_school,
    a.guardian_name,
    a.guardian_phone_no,
    a.undertaking,
    a.iii_language,
    a.ii_language,
    a.stream,
    a.transport_facility,
    a.mess_facility,
    a.family_samagra_id,
    a.student_pen_no,
    a.photo,
    a.aadhaar_card,
    a.birth_certificate,
    a.other_certificate,
    a.father_aadhaar,
    a.mother_aadhaar,
    a.samagra_id,
	a.transfer_certificate,
    a.prev_class_marksheet,
    a.father_photo,
    a.mother_photo,
	a.status,
    a.created_by,
    a.created_at,
    a.modified_by,
    a.modified_at
  FROM public.admission_form a
  LEFT JOIN public.course c ON a.course_id = c.id
  LEFT JOIN public.state s ON a.state_id = s.id
  LEFT JOIN public.country cn ON a.country_id = cn.id
  WHERE (
    LOWER(TRIM(a.first_name)) LIKE '%' || p_filter_text || '%'
    OR LOWER(TRIM(a.last_name)) LIKE '%' || p_filter_text || '%'
    OR LOWER(TRIM(a.email)) LIKE '%' || p_filter_text || '%'
    OR LOWER(TRIM(a.phone_no)) LIKE '%' || p_filter_text || '%'
  )
    AND a.company_id = p_company_id
  ORDER BY
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id END ASC,
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id END DESC
  LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admissionform_insert(p_company_id bigint, p_course_id bigint, p_admission_date date, p_gender text, p_first_name text, p_last_name text, p_father_name text, p_mother_name text, p_dob date, p_category text, p_address text, p_state_id bigint, p_country_id bigint, p_city_name text, p_zip_code text, p_email text, p_phone_no text, p_religion text, p_blood_group text, p_boarder_day_scholar text, p_current_school text, p_current_board text, p_medium text, p_father_qualification text, p_father_occupation text, p_father_organisation text, p_father_designation text, p_father_phone_no text, p_father_email text, p_mother_qualification text, p_mother_occupation text, p_mother_organisation text, p_mother_designation text, p_mother_phone_no text, p_mother_email text, p_student_aadhaar_no text, p_father_aadhaar_no text, p_mother_aadhaar_no text, p_samagra_id_no text, p_staff_child text, p_sibling_in_school text, p_parents_ex_school text, p_guardian_name text, p_guardian_phone_no text, p_undertaking text, p_iii_language text, p_ii_language text, p_stream text, p_transport_facility text, p_mess_facility text, p_family_samagra_id text, p_student_pen_no text, p_photo text, p_aadhaar_card text, p_birth_certificate text, p_other_certificate text, p_father_aadhaar text, p_mother_aadhaar text, p_samagra_id text, p_transfer_certificate text, p_prev_class_marksheet text, p_father_photo text, p_mother_photo text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.admission_form (
        company_id,
        course_id, admission_date, gender, first_name, last_name, father_name, mother_name, dob, category,
        address, state_id, country_id, city_name, zip_code, email, phone_no, religion, blood_group, boarder_day_scholar,
        current_school, current_board, medium,
        father_qualification, father_occupation, father_organisation, father_designation, father_phone_no, father_email,
        mother_qualification, mother_occupation, mother_organisation, mother_designation, mother_phone_no, mother_email,
        student_aadhaar_no, father_aadhaar_no, mother_aadhaar_no, samagra_id_no,
        staff_child, sibling_in_school, parents_ex_school,
        guardian_name, guardian_phone_no, undertaking,
        iii_language, ii_language, stream,
        transport_facility, mess_facility, family_samagra_id, student_pen_no,
        photo, aadhaar_card, birth_certificate, other_certificate,
        father_aadhaar, mother_aadhaar, samagra_id, transfer_certificate, prev_class_marksheet,
        father_photo, mother_photo, status,
        created_by, created_at
    ) VALUES (
        p_company_id,
        p_course_id, p_admission_date, p_gender, p_first_name, p_last_name, p_father_name, p_mother_name, p_dob, p_category,
        p_address, p_state_id, p_country_id, p_city_name, p_zip_code, p_email, p_phone_no, p_religion, p_blood_group, p_boarder_day_scholar,
        p_current_school, p_current_board, p_medium,

        p_father_qualification, p_father_occupation, p_father_organisation, p_father_designation, p_father_phone_no, p_father_email,
        p_mother_qualification, p_mother_occupation, p_mother_organisation, p_mother_designation, p_mother_phone_no, p_mother_email,

        p_student_aadhaar_no, p_father_aadhaar_no, p_mother_aadhaar_no, p_samagra_id_no,

        p_staff_child, p_sibling_in_school, p_parents_ex_school,
        p_guardian_name, p_guardian_phone_no, p_undertaking,
        p_iii_language, p_ii_language, p_stream,
        p_transport_facility, p_mess_facility, p_family_samagra_id, p_student_pen_no,

        p_photo, p_aadhaar_card, p_birth_certificate, p_other_certificate,
        p_father_aadhaar, p_mother_aadhaar, p_samagra_id, p_transfer_certificate, p_prev_class_marksheet,
        p_father_photo, p_mother_photo, p_status,

        p_created_by, p_created_at
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_admissionform_update(p_id bigint, p_company_id bigint, p_course_id integer, p_admission_date date, p_gender text, p_first_name text, p_last_name text, p_father_name text, p_mother_name text, p_dob date, p_category text, p_address text, p_state_id integer, p_country_id integer, p_city_name text, p_zip_code text, p_email text, p_phone_no text, p_religion text, p_blood_group text, p_boarder_day_scholar text, p_current_school text, p_current_board text, p_medium text, p_father_qualification text, p_father_occupation text, p_father_organisation text, p_father_designation text, p_father_phone_no text, p_father_email text, p_mother_qualification text, p_mother_occupation text, p_mother_organisation text, p_mother_designation text, p_mother_phone_no text, p_mother_email text, p_student_aadhaar_no text, p_father_aadhaar_no text, p_mother_aadhaar_no text, p_samagra_id_no text, p_staff_child text, p_sibling_in_school text, p_parents_ex_school text, p_guardian_name text, p_guardian_phone_no text, p_undertaking text, p_iii_language text, p_ii_language text, p_stream text, p_transport_facility text, p_mess_facility text, p_family_samagra_id text, p_student_pen_no text, p_photo text, p_aadhaar_card text, p_birth_certificate text, p_other_certificate text, p_father_aadhaar text, p_mother_aadhaar text, p_samagra_id text, p_transfer_certificate text, p_prev_class_marksheet text, p_father_photo text, p_mother_photo text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.admission_form SET
        company_id = p_company_id,
        course_id = p_course_id,
		admission_date = p_admission_date,
        gender = p_gender,
        first_name = p_first_name,
        last_name = p_last_name,
        father_name = p_father_name,
        mother_name = p_mother_name,
        dob = p_dob,
        category = p_category,
        address = p_address,
        state_id = p_state_id,
        country_id = p_country_id,
        city_name = p_city_name,
        zip_code = p_zip_code,
        email = p_email,
        phone_no = p_phone_no,
        religion = p_religion,
        blood_group = p_blood_group,
        boarder_day_scholar = p_boarder_day_scholar,
        current_school = p_current_school,
        current_board = p_current_board,
        medium = p_medium,

        father_qualification = p_father_qualification,
        father_occupation = p_father_occupation,
        father_organisation = p_father_organisation,
        father_designation = p_father_designation,
        father_phone_no = p_father_phone_no,
        father_email = p_father_email,

        mother_qualification = p_mother_qualification,
        mother_occupation = p_mother_occupation,
        mother_organisation = p_mother_organisation,
        mother_designation = p_mother_designation,
        mother_phone_no = p_mother_phone_no,
        mother_email = p_mother_email,

        student_aadhaar_no = p_student_aadhaar_no,
        father_aadhaar_no = p_father_aadhaar_no,
        mother_aadhaar_no = p_mother_aadhaar_no,
        samagra_id_no = p_samagra_id_no,

        staff_child = p_staff_child,
        sibling_in_school = p_sibling_in_school,
        parents_ex_school = p_parents_ex_school,

        guardian_name = p_guardian_name,
        guardian_phone_no = p_guardian_phone_no,
        undertaking = p_undertaking,
        iii_language = p_iii_language,
        ii_language = p_ii_language,
        stream = p_stream,
        transport_facility = p_transport_facility,
        mess_facility = p_mess_facility,
        family_samagra_id = p_family_samagra_id,
        student_pen_no = p_student_pen_no,

        photo = p_photo,
        aadhaar_card = p_aadhaar_card,
        birth_certificate = p_birth_certificate,
        other_certificate = p_other_certificate,
        father_aadhaar = p_father_aadhaar,
        mother_aadhaar = p_mother_aadhaar,
        samagra_id = p_samagra_id,
		transfer_certificate = p_transfer_certificate,
        prev_class_marksheet = p_prev_class_marksheet,
        father_photo = p_father_photo,
        mother_photo = p_mother_photo,
		status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
	-- First delete from user table (affiliate only)
	UPDATE public.""user""
	SET status = 'In-active'
	WHERE affiliate_id IN (
		SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
	)
	AND type = 'affiliate'
	AND company_id = p_company_id;

	-- Then delete from affiliate table
	UPDATE public.""affiliate""
	SET status = 'In-active'
	WHERE id IN (
		SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
	)
	AND company_id = p_company_id;

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_email_exist(p_id bigint, p_company_id bigint, p_email text)
 RETURNS TABLE(id bigint, email text)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id bigint;
BEGIN
	-- Step 1: Find corresponding user.id using affiliate_id
	SELECT u.id
	INTO v_user_id
	FROM public.""user"" u
	WHERE u.affiliate_id = p_id
	  AND u.company_id = p_company_id
	  AND u.type = 'affiliate';

	-- Step 2: Check for existing email in other users (case-insensitive)
	RETURN QUERY
	SELECT u.id, u.email
	FROM public.""user"" u
	WHERE u.company_id = p_company_id
	  AND LOWER(TRIM(u.email)) = LOWER(TRIM(p_email))
	  AND u.id <> v_user_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, phone_no text, user_name text, password text, address text, city_name text, district_id bigint, district_name text, state_id bigint, state_name text, country_id bigint, country_name text, zip_code text, status text, photo_id_url text, conversion_rate numeric, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_type_id bigint;
BEGIN
	SELECT t.id INTO v_type_id
	FROM type t
	WHERE t.type_name = 'Affiliate';
	
	RETURN QUERY
	SELECT
		a.id,
		a.first_name,
		a.last_name,
		u.email,
		u.mobile_no AS phone_no,
		u.user_name,
		u.password,
		a.address,
		a.city_name,
		a.district_id,
		d.district_name,
		a.state_id,
		s.state_name,
		a.country_id,
		c.country_name,
		a.zip_code,
		a.status,
		a.photo_id_url,
		a.conversion_rate,
		a.created_by,
		cb.first_name AS created_by_first_name,
		cb.last_name AS created_by_last_name,
		cb.user_name AS created_by_user_name,
		a.created_at,
		a.modified_by,
		mb.first_name AS modified_by_first_name,
		mb.last_name AS modified_by_last_name,
		mb.user_name AS modified_by_user_name,
		a.modified_at
	FROM public.affiliate a
	LEFT JOIN public.""district"" d 
		ON a.district_id = d.id 
	LEFT JOIN public.""user"" u 
		ON u.affiliate_id = a.id AND u.type_id = v_type_id
	LEFT JOIN public.""user"" cb 
		ON cb.id = a.created_by
	LEFT JOIN public.""user"" mb 
		ON mb.id = a.modified_by
	LEFT JOIN public.state s 
		ON a.state_id = s.id
	LEFT JOIN public.country c 
		ON a.country_id = c.id
	WHERE a.id = p_id AND a.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_get_page(p_company_id bigint, p_userid bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, phone_no text, user_name text, address text, city_name text, district_id bigint, district_name text, state_id bigint, country_id bigint, zip_code text, status text, photo_id_url text, conversion_rate numeric, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_type_id bigint;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));
	
	SELECT t.id INTO v_type_id
	FROM type t
	WHERE t.type_name = 'Affiliate';

    RETURN QUERY
    SELECT
        a.id,
        a.first_name,
        a.last_name,
        u.email,
        u.mobile_no AS phone_no,
        u.user_name,
        a.address,
        a.city_name,
		a.district_id,
		d.district_name,
        a.state_id,
        a.country_id,
        a.zip_code,
        a.status,
        a.photo_id_url,
        a.conversion_rate,
        a.created_at,
        a.modified_by,
        a.modified_at
    FROM public.affiliate a
	LEFT JOIN public.""district"" d 
		ON a.district_id = d.id 
    LEFT JOIN public.""user"" u ON u.affiliate_id = a.id AND u.type_id = v_type_id
    WHERE a.company_id = p_company_id
      AND (
          p_filter_text IS NULL OR p_filter_text = '' OR
          LOWER(a.first_name) LIKE '%' || p_filter_text || '%' OR
          LOWER(a.last_name) LIKE '%' || p_filter_text || '%' OR
          LOWER(u.email) LIKE '%' || p_filter_text || '%' OR
          LOWER(u.mobile_no) LIKE '%' || p_filter_text || '%' OR
          LOWER(u.user_name) LIKE '%' || p_filter_text || '%' OR
          LOWER(a.status) LIKE '%' || p_filter_text || '%'
      )
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id END ASC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id END DESC,
        CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'asc' THEN a.first_name END ASC,
        CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'desc' THEN a.first_name END DESC,
        CASE WHEN p_sort_field = 'email' AND p_sort_direction = 'asc' THEN u.email END ASC,
        CASE WHEN p_sort_field = 'email' AND p_sort_direction = 'desc' THEN u.email END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN a.status END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN a.status END DESC,
        a.id DESC
    OFFSET p_offset
    LIMIT p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_insert(p_company_id bigint, p_first_name text, p_last_name text, p_email text, p_phone_no text, p_user_name text, p_password text, p_address text, p_city_name text, p_district_id bigint, p_state_id bigint, p_country_id bigint, p_zip_code text, p_status text, p_photo_id_url text, p_role_id bigint, p_conversion_rate numeric, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	affiliate_id bigint;
	v_type_id bigint;
	v_role_id bigint;
BEGIN
	-- Fetch role_id and type_id for 'Affiliate'
	SELECT r.id INTO v_role_id
	FROM role r
	INNER JOIN type t ON r.type_id = t.id
	WHERE t.type_name = 'Affiliate' AND r.company_id = p_company_id
	LIMIT 1;

	SELECT t.id INTO v_type_id
	FROM type t
	WHERE t.type_name = 'Affiliate';

	-- Step 1: Insert into affiliate table
	INSERT INTO public.""affiliate"" (
		company_id,
		first_name,
		last_name,
		address,
		city_name, 
		district_id,
		state_id,
		country_id,		
		zip_code, 
		status,
		photo_id_url,
		conversion_rate,
		created_by,
		created_at
	) VALUES (
		p_company_id,
		p_first_name,
		p_last_name,
		p_address,
		p_city_name, 
		p_district_id,
		p_state_id,
		p_country_id,
		p_zip_code,  
		p_status,	
		p_photo_id_url,	
		p_conversion_rate,
		p_created_by,
		p_created_at
	)
	RETURNING id INTO affiliate_id;

	-- Step 2: Insert into user table using affiliate_id
	INSERT INTO public.""user"" (
		company_id,
		first_name,
		last_name,
		email,
		mobile_no,
		user_name,
		password,
		status,	   
		role_id,
		affiliate_id,
		type_id,
		image_url,	
		created_by,
		created_at	
	) VALUES (
		p_company_id,
		p_first_name,
		p_last_name,
		p_email,
		p_phone_no,
		p_user_name,
		p_password,
		p_status,
		v_role_id,
		affiliate_id,
		v_type_id,
		p_photo_id_url,
		p_created_by,
		p_created_at		
	);

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_payment_calculate(p_company_id bigint, p_created_by bigint, p_affiliate_id bigint DEFAULT NULL::bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    aff RECORD;
    referral_count INTEGER;
    total_earning NUMERIC := 0;
    something_paid BOOLEAN := false;
BEGIN
    FOR aff IN 
        SELECT id, conversion_rate
        FROM affiliate
        WHERE company_id = p_company_id
          AND (p_affiliate_id IS NULL OR id = p_affiliate_id)
    LOOP
        SELECT COUNT(*) INTO referral_count
        FROM referral r
        WHERE r.referred_by = aff.id
          AND r.company_id = p_company_id
          AND r.is_paid = false
          AND NOT EXISTS (
              SELECT 1 FROM referral_payments rp WHERE rp.referral_id = r.id
          );

        IF referral_count > 0 THEN
            -- Updated calculation: sum of (amount_paid * conversion_rate / 100)
            SELECT SUM(r.amount_paid * aff.conversion_rate / 100)
            INTO total_earning
            FROM referral r
            WHERE r.referred_by = aff.id
              AND r.company_id = p_company_id
              AND r.is_paid = false
              AND r.amount_paid > 0
              AND NOT EXISTS (
                  SELECT 1 FROM referral_payments rp WHERE rp.referral_id = r.id
              );

            INSERT INTO affiliate_payment (
                affiliate_id, total_referrals, total_earning, deduction, amount_paid,
                status, remarks, created_by, company_id
            ) VALUES (
                aff.id, referral_count, total_earning, 0, total_earning,
                'pending', 'Generated by func_affiliate_payment_calculate()', p_created_by, p_company_id
            );

            UPDATE referral
            SET is_paid = true
            WHERE referred_by = aff.id
              AND company_id = p_company_id
              AND is_paid = false
              AND NOT EXISTS (
                  SELECT 1 FROM referral_payments rp WHERE rp.referral_id = referral.id
              );

            INSERT INTO referral_payments (
                referral_id, affiliate_id, amount, company_id, remarks
            )
            SELECT
                r.id,
                aff.id,
                (r.amount_paid * aff.conversion_rate / 100),
                p_company_id,
                'Paid via func_affiliate_payment_calculate()'
            FROM referral r
            WHERE r.referred_by = aff.id
              AND r.company_id = p_company_id
              AND r.is_paid = true
              AND NOT EXISTS (
                  SELECT 1 FROM referral_payments rp WHERE rp.referral_id = r.id
              );

            something_paid := true;
        END IF;
    END LOOP;

    RETURN something_paid;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_phone_no_exist(p_id bigint, p_company_id bigint, p_phone_no text)
 RETURNS TABLE(id bigint, mobile_no text)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id bigint;
BEGIN
	-- Step 1: Get user.id corresponding to this affiliate
	SELECT u.id
	INTO v_user_id
	FROM public.""user"" u
	WHERE u.affiliate_id = p_id
	  AND u.company_id = p_company_id
	  AND u.type = 'affiliate';

	-- Step 2: Check if any other user in this company has the same mobile_no
	RETURN QUERY
	SELECT u.id, u.mobile_no
	FROM public.""user"" u
	WHERE u.company_id = p_company_id
	  AND LOWER(TRIM(u.mobile_no)) = LOWER(TRIM(p_phone_no))
	  AND u.id <> v_user_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_report(p_company_id bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, phone_no text, user_name text, address text, city_name text, state_id bigint, country_id bigint, zip_code text, status text, photo_id_url text, conversion_rate numeric, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone, modified_by_name text)
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_type_id bigint;
BEGIN
	SELECT t.id INTO v_type_id
	FROM type t
	WHERE t.type_name = 'Affiliate';
	
    RETURN QUERY
    SELECT 
        a.id,
        a.first_name,
        a.last_name,
        au.email,
        au.mobile_no AS phone_no,
        au.user_name,
        a.address,
        a.city_name,
        a.state_id,
        a.country_id,
        a.zip_code,
        a.status,
        a.photo_id_url,
        a.conversion_rate,
        a.created_at,
        a.modified_by,
        a.modified_at,
        CONCAT(mu.first_name, ' ', mu.last_name) AS modified_by_name
    FROM public.affiliate a
    LEFT JOIN public.""user"" au 
        ON au.affiliate_id = a.id AND au.type_id = v_type_id
    LEFT JOIN public.""user"" mu 
        ON mu.id = a.modified_by
    WHERE (p_user_id IS NULL OR a.modified_by = p_user_id)
      AND a.created_at::date BETWEEN p_from_date AND p_to_date
      AND a.company_id = p_company_id
    ORDER BY a.created_at DESC;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_review_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_modified_by bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
    v_from_date DATE := p_from_date::date;
    v_to_date DATE := p_to_date::date;
BEGIN	
    p_filter_text := LOWER(TRIM(p_filter_text));

    total_rows := (
        SELECT COUNT(*)
        FROM public.affiliate a
        LEFT JOIN public.""user"" u 
            ON u.affiliate_id = a.id AND u.type = 'affiliate'
        WHERE a.company_id = p_company_id
          AND (p_modified_by IS NULL OR a.modified_by = p_modified_by)
          AND a.created_at::date BETWEEN v_from_date AND v_to_date
          AND (
              p_filter_text IS NULL OR p_filter_text = '' OR
              LOWER(a.first_name) LIKE '%' || p_filter_text || '%' OR
              LOWER(a.last_name) LIKE '%' || p_filter_text || '%' OR
              LOWER(u.email) LIKE '%' || p_filter_text || '%' OR
              LOWER(u.mobile_no) LIKE '%' || p_filter_text || '%' OR
              LOWER(u.user_name) LIKE '%' || p_filter_text || '%' OR
              LOWER(a.status) LIKE '%' || p_filter_text || '%' OR
			  LOWER(a.city_name) LIKE '%' || p_filter_text || '%'
          )
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_review_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_modified_by bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, phone_no text, user_name text, address text, city_name text, state_id bigint, country_id bigint, zip_code text, status text, photo_id_url text, conversion_rate numeric, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone, modified_by_name text)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_from_date DATE := p_from_date;
	v_to_date DATE := p_to_date;
	v_type_id bigint;

BEGIN
	p_filter_text := LOWER(TRIM(p_filter_text));
	p_sort_field := LOWER(TRIM(p_sort_field));
	p_sort_direction := LOWER(TRIM(p_sort_direction));
	
	SELECT t.id INTO v_type_id
	FROM type t
	WHERE t.type_name = 'Affiliate';

	RETURN QUERY
	SELECT
		a.id,
		a.first_name,
		a.last_name,
		u.email,
		u.mobile_no AS phone_no,
		u.user_name,
		a.address,
		a.city_name,
		a.state_id,
		a.country_id,
		a.zip_code,
		a.status,
		a.photo_id_url,
		a.conversion_rate,
		a.created_at,
		a.modified_by,
		a.modified_at,
		CONCAT(um.first_name, ' ', um.last_name) AS modified_by_name
	FROM public.affiliate a
	LEFT JOIN public.""user"" u ON u.affiliate_id = a.id AND u.type_id = v_type_id
	LEFT JOIN public.""user"" um ON um.id = a.modified_by
	WHERE a.company_id = p_company_id
	  AND (p_modified_by IS NULL OR a.modified_by = p_modified_by)
	  AND a.created_at::date BETWEEN v_from_date AND v_to_date
	  AND (
		  p_filter_text IS NULL OR p_filter_text = '' OR
		  LOWER(a.first_name) LIKE '%' || p_filter_text || '%' OR
		  LOWER(a.last_name) LIKE '%' || p_filter_text || '%' OR
		  LOWER(u.email) LIKE '%' || p_filter_text || '%' OR
		  LOWER(u.mobile_no) LIKE '%' || p_filter_text || '%' OR
		  LOWER(u.user_name) LIKE '%' || p_filter_text || '%' OR
		  LOWER(a.status) LIKE '%' || p_filter_text || '%' OR
		  LOWER(a.city_name) LIKE '%' || p_filter_text || '%'
	  )
	ORDER BY
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id END ASC,
		CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'desc' THEN a.first_name END DESC,
		CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'asc' THEN a.first_name END ASC,
		CASE WHEN p_sort_field = 'last_name' AND p_sort_direction = 'desc' THEN a.last_name END DESC,
		CASE WHEN p_sort_field = 'last_name' AND p_sort_direction = 'asc' THEN a.last_name END ASC,
		CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN a.status END DESC,
		CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN a.status END ASC,
		a.id DESC
	OFFSET p_offset
	LIMIT p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_summary(p_user_id bigint, p_company_id bigint)
 RETURNS TABLE(total_referrals bigint, total_earning numeric, conversion_rate numeric, pending_payout numeric, incentive_given numeric, last_payment_date timestamp without time zone, last_payment_amount numeric)
 LANGUAGE plpgsql
AS $function$
DECLARE 
    v_affiliate_id BIGINT;
BEGIN
    SELECT u.affiliate_id INTO v_affiliate_id
    FROM public.""user"" u
    WHERE u.id = p_user_id AND u.company_id = p_company_id;
	
    RETURN QUERY
    SELECT
        -- Total referrals
        (SELECT COUNT(*) 
         FROM public.referral r 
         WHERE r.referred_by = p_user_id AND r.company_id = p_company_id) AS total_referrals,

        -- Total earnings (sum of total_earning from affiliate_payment)
        (SELECT COALESCE(SUM(ap.total_earning), 0)
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = v_affiliate_id AND ap.company_id = p_company_id) AS total_earning,

        -- Conversion rate (default to 0 if null or missing)
        COALESCE((
            SELECT a.conversion_rate
            FROM public.affiliate a
            WHERE a.id = v_affiliate_id AND a.company_id = p_company_id
        ), 0) AS conversion_rate,

        -- Pending payout
        (SELECT COALESCE(SUM(ap.amount_paid), 0)
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = v_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'pending') AS pending_payout,

        -- Incentive given (paid)
        (SELECT COALESCE(SUM(ap.amount_paid), 0)
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = v_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'paid') AS incentive_given,

        -- Last payment date
        (SELECT ap.payment_date
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = v_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'paid'
         ORDER BY ap.payment_date DESC LIMIT 1) AS last_payment_date,

        -- Last payment amount (default to 0 if null or missing)
        COALESCE((
            SELECT ap.amount_paid
            FROM public.affiliate_payment ap
            WHERE ap.affiliate_id = v_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'paid'
            ORDER BY ap.payment_date DESC LIMIT 1
        ), 0) AS last_payment_amount;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_summary_bak(p_affiliate_id bigint, p_company_id bigint)
 RETURNS TABLE(total_referrals bigint, total_earning numeric, conversion_rate numeric, pending_payout numeric, incentive_given numeric, last_payment_date timestamp without time zone, last_payment_amount numeric)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        -- Total referrals
        (SELECT COUNT(*) 
         FROM public.referral r 
         WHERE r.referred_by = p_affiliate_id AND r.company_id = p_company_id) AS total_referrals,

        -- Total earnings (sum of total_earning from affiliate_payment)
        (SELECT COALESCE(SUM(ap.total_earning), 0)
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = p_affiliate_id AND ap.company_id = p_company_id) AS total_earning,

        -- Conversion rate (default to 0 if null or missing)
        COALESCE((
            SELECT a.conversion_rate
            FROM public.affiliate a
            WHERE a.id = p_affiliate_id AND a.company_id = p_company_id
        ), 0) AS conversion_rate,

        -- Pending payout
        (SELECT COALESCE(SUM(ap.amount_paid), 0)
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = p_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'pending') AS pending_payout,

        -- Incentive given (paid)
        (SELECT COALESCE(SUM(ap.amount_paid), 0)
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = p_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'paid') AS incentive_given,

        -- Last payment date
        (SELECT ap.payment_date
         FROM public.affiliate_payment ap
         WHERE ap.affiliate_id = p_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'paid'
         ORDER BY ap.payment_date DESC LIMIT 1) AS last_payment_date,

        -- Last payment amount (default to 0 if null or missing)
        COALESCE((
            SELECT ap.amount_paid
            FROM public.affiliate_payment ap
            WHERE ap.affiliate_id = p_affiliate_id AND ap.company_id = p_company_id AND ap.status = 'paid'
            ORDER BY ap.payment_date DESC LIMIT 1
        ), 0) AS last_payment_amount;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_update(p_id bigint, p_company_id bigint, p_first_name text, p_last_name text, p_email text, p_phone_no text, p_user_name text, p_password text, p_address text, p_city_name text, p_district_id bigint, p_state_id bigint, p_country_id bigint, p_zip_code text, p_status text, p_photo_id_url text, p_role_id bigint, p_conversion_rate numeric, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_affiliate_updated integer;
	v_user_updated integer;
BEGIN
	-- 1. Update affiliate table
	UPDATE public.affiliate
	SET
		first_name = p_first_name,
		last_name = p_last_name,
		address = p_address,
		city_name = p_city_name,
		district_id=p_district_id,
		state_id = p_state_id,
		country_id = p_country_id,
		zip_code = p_zip_code,
		status = p_status,
		photo_id_url = p_photo_id_url,
		conversion_rate = p_conversion_rate,
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE id = p_id
	  AND company_id = p_company_id;

	GET DIAGNOSTICS v_affiliate_updated = ROW_COUNT;

	-- 2. Update related user (affiliate-type only)
	UPDATE public.""user""
	SET
		first_name = p_first_name,
		last_name = p_last_name,
		email = p_email,
		mobile_no = p_phone_no,
		user_name = p_user_name,
		password = TRIM(p_password),
		status = p_status,
		role_id = p_role_id,
		image_url = p_photo_id_url,
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE company_id = p_company_id
	  AND affiliate_id = p_id
	  AND type = 'affiliate';

	GET DIAGNOSTICS v_user_updated = ROW_COUNT;

	-- Optional: return false if nothing was updated
	IF v_affiliate_updated = 0 AND v_user_updated = 0 THEN
		RETURN false;
	END IF;

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_affiliate_user_name_exist(p_id bigint, p_company_id bigint, p_user_name text)
 RETURNS TABLE(id bigint, user_name text)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_user_id bigint;
BEGIN
	-- Step 1: Get the user.id linked to the given affiliate.id
	SELECT u.id
	INTO v_user_id
	FROM public.""user"" u
	WHERE u.affiliate_id = p_id
	  AND u.company_id = p_company_id
	  AND u.type = 'affiliate';

	-- Step 2: Check for duplicate user_name (case-insensitive), excluding self
	RETURN QUERY
	SELECT u.id, u.user_name
	FROM public.""user"" u
	WHERE u.company_id = p_company_id
	  AND LOWER(TRIM(u.user_name)) = LOWER(TRIM(p_user_name))
	  AND u.id <> v_user_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_bulk_get(p_company_id bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(attendance_time date, user_id bigint, user_name text, time_in text, time_out text, total_hours text, report_type text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    WITH
    all_dates AS (
        SELECT d::date AS attendance_time
        FROM   generate_series(p_from_date, p_to_date, interval '1 day') AS d
    ),
    company_users AS (
        SELECT id AS user_id,
               first_name,
               last_name
        FROM   public.""user""
        WHERE  company_id = p_company_id AND type_id=2
          AND  (p_user_id IS NULL OR id = p_user_id)
    ),
    user_dates AS (
        SELECT u.user_id,
               u.first_name,
               u.last_name,
               d.attendance_time
        FROM   company_users u
        CROSS  JOIN all_dates d
    ),
    attendance_data AS (
        SELECT
            a.user_id,
            a.attendance_time::date AS attendance_time,
            MIN(CASE WHEN a.entry_type = 'IN'  THEN a.attendance_time END) AS time_in_ts,
            MAX(CASE WHEN a.entry_type = 'OUT' THEN a.attendance_time END) AS time_out_ts
        FROM   public.attendance_bulk a
        WHERE  a.company_id = p_company_id
          AND  a.attendance_time::date BETWEEN p_from_date AND p_to_date
        GROUP  BY a.user_id, a.attendance_time::date
    ),
    merged AS (
        SELECT
            ud.attendance_time AS attendance_time,
            ud.user_id,
            ud.first_name || ' ' || ud.last_name AS user_name,
            TO_CHAR(ad.time_in_ts,  'HH24:MI:SS') AS time_in,
            TO_CHAR(ad.time_out_ts, 'HH24:MI:SS') AS time_out,
            TO_CHAR(
              ad.time_out_ts - ad.time_in_ts,
              'HH24:MI:SS'
            ) AS total_hours,
            CASE
              WHEN ad.time_in_ts  IS NOT NULL
               AND ad.time_out_ts IS NOT NULL THEN 'present'
              WHEN ad.time_in_ts  IS NULL
               AND ad.time_out_ts IS NULL THEN 'absent'
              ELSE 'incomplete'
            END AS report_type
        FROM user_dates ud
        LEFT JOIN attendance_data ad
          ON ud.user_id = ad.user_id
         AND ud.attendance_time = ad.attendance_time
    )
    SELECT
        m.attendance_time,
        m.user_id,
        m.user_name,
        m.time_in,
        m.time_out,
        m.total_hours,
        m.report_type
    FROM merged AS m
    ORDER BY m.attendance_time DESC, m.user_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_bulk_insert(p_company_id bigint, p_device_id text, p_latitude numeric, p_longitude numeric, p_distance_from_office numeric, p_is_on_campus boolean, p_device_info text, p_ip_address text, p_remarks text, p_is_locked boolean, input_json jsonb, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    item jsonb;
    v_user_id bigint;
    v_attendance_date date;
    v_time_in time;
    v_time_out time;
    v_attendance_datetime_in timestamp with time zone;
    v_attendance_datetime_out timestamp with time zone;
BEGIN
    FOR item IN SELECT * FROM jsonb_array_elements(input_json) LOOP
        -- Extract values
        v_user_id := (item ->> 'user_id')::bigint;
        v_attendance_date := (item ->> 'attendance_time')::date;
        v_time_in := (item ->> 'time_in')::time;
        v_time_out := (item ->> 'time_out')::time;

        v_attendance_datetime_in := (v_attendance_date + v_time_in);
        v_attendance_datetime_out := (v_attendance_date + v_time_out);

        -- -------------------------------
        -- Upsert IN entry
        -- -------------------------------
        IF EXISTS (
            SELECT 1
            FROM public.attendance_bulk
            WHERE user_id = v_user_id
              AND DATE(attendance_time) = v_attendance_date
              AND entry_type = 'IN'
        ) THEN
            UPDATE public.attendance_bulk
            SET attendance_time = v_attendance_datetime_in,
                latitude = p_latitude,
                longitude = p_longitude,
                distance_from_office = p_distance_from_office,
                is_on_campus = p_is_on_campus,
                device_info = TRIM(COALESCE(p_device_info, '')),
                ip_address = TRIM(COALESCE(p_ip_address, '')),
                remarks = TRIM(COALESCE(p_remarks, '')),
                modified_by = p_created_by,
                modified_at = p_created_at
            WHERE user_id = v_user_id
              AND DATE(attendance_time) = v_attendance_date
              AND entry_type = 'IN';
        ELSE
            INSERT INTO public.attendance_bulk (
                company_id,
                user_id,
                entry_type,
                attendance_time,
                latitude,
                longitude,
                distance_from_office,
                is_on_campus,
                device_info,
                ip_address,
                remarks,
                is_locked,
                created_by,
                created_at
            ) VALUES (
                p_company_id,
                v_user_id,
                'IN',
                v_attendance_datetime_in,
                p_latitude,
                p_longitude,
                p_distance_from_office,
                p_is_on_campus,
                TRIM(COALESCE(p_device_info, '')),
                TRIM(COALESCE(p_ip_address, '')),
                TRIM(COALESCE(p_remarks, '')),
                false,
                p_created_by,
                p_created_at
            );
        END IF;

        -- -------------------------------
        -- Upsert OUT entry
        -- -------------------------------
        IF EXISTS (
            SELECT 1
            FROM public.attendance_bulk
            WHERE user_id = v_user_id
              AND DATE(attendance_time) = v_attendance_date
              AND entry_type = 'OUT'
        ) THEN
            UPDATE public.attendance_bulk
            SET attendance_time = v_attendance_datetime_out,
                latitude = p_latitude,
                longitude = p_longitude,
                distance_from_office = p_distance_from_office,
                is_on_campus = p_is_on_campus,
                device_info = TRIM(COALESCE(p_device_info, '')),
                ip_address = TRIM(COALESCE(p_ip_address, '')),
                remarks = TRIM(COALESCE(p_remarks, '')),
                modified_by = p_created_by,
                modified_at = p_created_at
            WHERE user_id = v_user_id
              AND DATE(attendance_time) = v_attendance_date
              AND entry_type = 'OUT';
        ELSE
            INSERT INTO public.attendance_bulk (
                company_id,
                user_id,
                entry_type,
                attendance_time,
                latitude,
                longitude,
                distance_from_office,
                is_on_campus,
                device_info,
                ip_address,
                remarks,
                is_locked,
                created_by,
                created_at
            ) VALUES (
                p_company_id,
                v_user_id,
                'OUT',
                v_attendance_datetime_out,
                p_latitude,
                p_longitude,
                p_distance_from_office,
                p_is_on_campus,
                TRIM(COALESCE(p_device_info, '')),
                TRIM(COALESCE(p_ip_address, '')),
                TRIM(COALESCE(p_remarks, '')),
                false,
                p_created_by,
                p_created_at
            );
        END IF;

    END LOOP;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_bulk_lock(p_company_id bigint, p_date date, p_user_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_updated_count INTEGER := 0;
    v_inserted_count INTEGER := 0;
BEGIN
    -- Step 1: Lock matching attendance_bulk records
    UPDATE public.attendance_bulk
    SET is_locked = true
    WHERE user_id IN (
        SELECT unnest(string_to_array(p_user_ids, ',')::bigint[])
    )
    AND company_id = p_company_id
    AND DATE(attendance_time) = p_date
    AND is_locked = false; -- Only update if not already locked

    GET DIAGNOSTICS v_updated_count = ROW_COUNT;

    -- Step 2: Insert non-duplicate records into attendance
    WITH rows_to_insert AS (
        SELECT
            ab.*
        FROM public.attendance_bulk ab
        WHERE ab.is_locked = true
          AND ab.user_id IN (
              SELECT unnest(string_to_array(p_user_ids, ',')::bigint[])
          )
          AND ab.company_id = p_company_id
          AND DATE(ab.attendance_time) = p_date
          AND NOT EXISTS (
              SELECT 1 FROM public.attendance a
              WHERE a.user_id = ab.user_id
                AND a.entry_type = ab.entry_type
                AND DATE(a.attendance_time) = DATE(ab.attendance_time)
          )
    )
    INSERT INTO public.attendance (
        user_id,
        entry_type,
        attendance_time,
        latitude,
        longitude,
        distance_from_office,
        is_on_campus,
        device_info,
        ip_address,
        remarks,
        created_by,
        created_at,
        modified_by,
        modified_at,
        company_id,
        is_verified
    )
    SELECT
        user_id,
        entry_type,
        attendance_time,
        latitude,
        longitude,
        distance_from_office,
        is_on_campus,
        device_info,
        ip_address,
        remarks,
        created_by,
        created_at,
        modified_by,
        modified_at,
        company_id,
        is_verified
    FROM rows_to_insert;

    GET DIAGNOSTICS v_inserted_count = ROW_COUNT;

    -- Step 3: Return true only if any changes happened
    IF v_updated_count > 0 OR v_inserted_count > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_bulk_lock_back(p_company_id bigint, p_date date, p_user_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- First lock the matching records in attendance_bulk
    UPDATE public.attendance_bulk
    SET is_locked = true
    WHERE user_id IN (
        SELECT unnest(string_to_array(p_user_ids, ',')::bigint[])
    )
    AND company_id = p_company_id
    AND DATE(attendance_time) = p_date;

    -- Then insert those locked records into attendance table
    INSERT INTO public.attendance (
        user_id,
        entry_type,
        attendance_time,
        latitude,
        longitude,
        distance_from_office,
        is_on_campus,
        device_info,
        ip_address,
        remarks,
        created_by,
        created_at,
        modified_by,
        modified_at,
        company_id,
        is_verified
    )
    SELECT
        user_id,
        entry_type,
        attendance_time,
        latitude,
        longitude,
        distance_from_office,
        is_on_campus,
        device_info,
        ip_address,
        remarks,
        created_by,
        created_at,
        modified_by,
        modified_at,
        company_id,
        is_verified
    FROM public.attendance_bulk
    WHERE is_locked = true
      AND user_id IN (
          SELECT unnest(string_to_array(p_user_ids, ',')::bigint[])
      )
      AND company_id = p_company_id
      AND DATE(attendance_time) = p_date;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_bulk_update(p_id bigint, p_company_id bigint, p_user_id bigint, p_entry_type text, p_attendance_time timestamp with time zone, p_latitude numeric, p_longitude numeric, p_distance_from_office numeric, p_is_on_campus boolean, p_device_info text, p_ip_address text, p_remarks text, p_modified_by bigint, p_modified_at timestamp without time zone, p_is_verified boolean DEFAULT true)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""attendance_bulk"" SET 
      entry_type =  TRIM(p_entry_type),
      attendance_time =p_attendance_time, --  (p_attendance_time AT TIME ZONE 'UTC') AT TIME ZONE 'Asia/Kolkata',
      distance_from_office =  p_distance_from_office,
      device_info =  TRIM(p_device_info), 
      ip_address =  TRIM(p_ip_address), 
      remarks =  p_remarks,
	  is_verified = p_is_verified,
	  modified_by = p_modified_by,
	  modified_at = p_modified_at	
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_daily_summary(p_company_id bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(attendance_time date, user_id bigint, user_name text, time_in text, time_out text, total_hours text, distance_from_office numeric, device_id text, ip_address text, remarks text)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_from_date date := p_from_date::date;
	v_to_date date := p_to_date::date;
BEGIN
	RETURN QUERY
	SELECT 
		a.attendance_time::date AS attendance_date,
		a.user_id,
		CONCAT(u.first_name, ' ', u.last_name) AS user_name,

		-- Fix here: Only use IN entries
		TO_CHAR(
			MIN(CASE WHEN a.entry_type = 'IN' THEN a.attendance_time END), 
			'HH24:MI:SS'
		) AS time_in,

		-- Fix here: Only use OUT entries
		TO_CHAR(
			MAX(CASE WHEN a.entry_type = 'OUT' THEN a.attendance_time END), 
			'HH24:MI:SS'
		) AS time_out,

		-- Fix here: Only calculate total if both IN and OUT exist
		TO_CHAR(
			MAX(CASE WHEN a.entry_type = 'OUT' THEN a.attendance_time END)
			- MIN(CASE WHEN a.entry_type = 'IN' THEN a.attendance_time END),
			'HH24:MI:SS'
		) AS total_hours,

		MAX(a.distance_from_office) AS distance_from_office,
		MAX(udm.device_id) AS device_id,
		MAX(a.ip_address) AS ip_address,
		STRING_AGG(NULLIF(TRIM(a.remarks), ''), '; ') AS remarks

	FROM public.attendance a
	JOIN public.user_device_mapping udm ON a.user_id = udm.user_id
	JOIN public.""user"" u ON a.user_id = u.id
	WHERE a.company_id = p_company_id
	  AND (p_user_id IS NULL OR a.user_id = p_user_id)
	  AND a.attendance_time::date BETWEEN v_from_date AND v_to_date
	GROUP BY a.attendance_time::date, a.user_id, u.first_name, u.last_name
	ORDER BY attendance_date DESC, user_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    DELETE FROM public.attendance
    WHERE id IN (
        SELECT unnest(string_to_array(p_ids, ',')::bigint[])
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_exist(p_user_id bigint, p_company_id bigint, p_attendance_time timestamp with time zone, p_entry_type text)
 RETURNS TABLE(attendance_time timestamp with time zone, entry_type text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		a.attendance_time,
		a.entry_type
	FROM public.""attendance"" a
	WHERE a.user_id = p_user_id 
	  AND a.company_id = p_company_id 
	  AND LOWER(TRIM(a.entry_type)) = LOWER(TRIM(p_entry_type))
	  AND DATE(a.attendance_time) = DATE(p_attendance_time);
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, name text, entry_type text, attendance_time timestamp with time zone, latitude numeric, longitude numeric, distance_from_office numeric, is_on_campus boolean, device_info text, ip_address text, remarks text, is_verified boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
    a.id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    a.entry_type,
    a.attendance_time,
    a.latitude,
    a.longitude,
    a.distance_from_office, 
    a.is_on_campus, 
    a.device_info, 
    a.ip_address, 
    a.remarks, 
	a.is_verified,
	a.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    a.created_at,
    a.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    a.modified_at
	FROM public.""attendance"" a
	LEFT JOIN public.""user"" u ON a.created_by = u.id
	LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
	WHERE a.id = p_id AND a.company_id = p_company_id ;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, user_id bigint, user_name text, entry_type text, attendance_time timestamp without time zone, latitude numeric, longitude numeric, distance_from_office numeric, is_on_campus boolean, device_info text, ip_address text, remarks text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
    a.id,
    a.user_id,
    u.user_name,
    a.entry_type,
    a.attendance_time,
    a.latitude,
    a.longitude,
    a.distance_from_office, 
    a.is_on_campus, 
    a.device_info, 
    a.ip_address, 
    a.remarks, 
	a.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    a.created_at,
    a.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    a.modified_at
	FROM public.""attendance"" a
	LEFT JOIN public.""user"" u ON a.user_id = u.id
	LEFT JOIN public.""user"" u ON a.created_by = u.id
	LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
	WHERE a.company_id = p_company_id
	Order by a.attendance_time ASC;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_get_count(p_company_id bigint, p_user_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""attendance"" a
	WHERE (LOWER(TRIM(a.entry_type)) LIKE '%' || p_filter_text || '%') AND a.company_id = p_company_id and a.user_id=p_user_id
	AND a.company_id = p_company_id and a.user_id = p_user_id);  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_get_page(p_company_id bigint, p_user_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, user_id bigint, name text, entry_type text, attendance_time timestamp with time zone, latitude numeric, longitude numeric, distance_from_office numeric, is_on_campus boolean, device_info text, ip_address text, remarks text, is_verified boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
    a.id,
    a.user_id,
    u.first_name as name,
    a.entry_type,
    a.attendance_time,
    a.latitude,
    a.longitude,
    a.distance_from_office, 
    a.is_on_campus, 
    a.device_info, 
    a.ip_address, 
    a.remarks,
	a.is_verified,
	a.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    a.created_at,
    a.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    a.modified_at	
	FROM public.""attendance"" a
	LEFT JOIN public.""user"" u ON a.user_id = u.id
	LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
	WHERE (LOWER(TRIM(a.entry_type)) LIKE '%' || p_filter_text || '%') AND a.company_id = p_company_id and a.user_id=p_user_id
	ORDER BY 
		CASE 
			WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id 
		END DESC,
		CASE 
			WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id 
		END ASC,
		CASE 
			WHEN p_sort_field = 'entry_type' AND p_sort_direction = 'desc' THEN a.entry_type 
		END DESC,
		CASE 
			WHEN p_sort_field = 'entry_type' AND p_sort_direction = 'asc' THEN a.entry_type 
		END ASC,
		a.attendance_time DESC  -- ✅ Default order if none of the above conditions match
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_insert(p_company_id bigint, p_user_id bigint, p_device_id text, p_entry_type text, p_attendance_time timestamp with time zone, p_latitude numeric, p_longitude numeric, p_distance_from_office numeric, p_is_on_campus boolean, p_device_info text, p_ip_address text, p_remarks text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	device_exists BOOLEAN;
	isDeviceValidationReq BOOLEAN;
	user_exists BOOLEAN;
	attendance_exists BOOLEAN;
BEGIN
	-- Step 1: Check if user exists and is active
	SELECT EXISTS (
		SELECT 1 
		FROM public.""user""
		WHERE id = p_user_id
		  AND company_id = p_company_id
		  AND status = 'Active'
	) INTO user_exists;

	IF NOT user_exists THEN
		RAISE EXCEPTION 'Unauthorized access. Please log out and log in again.';
	END IF;

	-- Step 2: Check if device validation is required
	SELECT LOWER(TRIM(value)) = 'true'
	INTO isDeviceValidationReq
	FROM public.site_config
	WHERE key = 'IS_DEVICE_VALIDATION_REQ';

	IF isDeviceValidationReq THEN  -- START: Device Validation Block

		-- Check if this device is already mapped to the user
		device_exists := func_user_device_mapping_exist(p_company_id, p_user_id, TRIM(p_device_id));

		IF NOT device_exists THEN  -- START: Device not mapped to user

			-- Check if the user has any other active devices
			IF EXISTS (
				SELECT 1 FROM user_device_mapping
				WHERE user_id = p_user_id
				  AND company_id = p_company_id
				  AND status = 'Active'
			) THEN  -- START: User has other active devices

				-- Check if attendance already exists from this (unauthorized) device for same day/entry type
				SELECT EXISTS (
					SELECT 1
					FROM attendance 
					WHERE LOWER(device_id) = LOWER(TRIM(p_device_id))
					  AND company_id = p_company_id
					  AND (
						   attendance_time >= DATE(p_attendance_time)
						   AND attendance_time < DATE(p_attendance_time) + INTERVAL '1 day'
					  )
					  AND entry_type = TRIM(p_entry_type)
				) INTO attendance_exists;

				IF attendance_exists THEN  -- START: Unauthorized device trying to mark duplicate attendance
					RAISE EXCEPTION 'Unauthorized device. Attendance not allowed.';
				ELSE  -- ELSE of attendance_exists check

					-- Mark old device(s) inactive
					UPDATE public.user_device_mapping 
					SET status = 'In-active',
					modified_by=p_created_by,
					modified_at=p_created_at
					WHERE user_id = p_user_id AND company_id = p_company_id;

					-- Map new device
					PERFORM func_user_device_mapping_insert(
						p_company_id,
						p_user_id,
						TRIM(p_device_id),
						TRIM(p_device_info),
						p_created_by
					);

				END IF;  -- END: attendance_exists check

			ELSE  -- ELSE of check for other active devices

				-- Check if device exists and is mapped to another user
				IF EXISTS (
					SELECT 1 FROM user_device_mapping
					WHERE LOWER(device_id) = LOWER(TRIM(p_device_id))
					  AND company_id = p_company_id
					  AND status = 'Active'
				) THEN  -- START: Device exists with another user

					RAISE EXCEPTION 'Unauthorized device. Attendance not allowed.';

				ELSE  -- ELSE: Device does not exist, allow and insert mapping

					-- Just map the new device
					PERFORM func_user_device_mapping_insert(
						p_company_id,
						p_user_id,
						TRIM(p_device_id),
						TRIM(p_device_info),
						p_created_by
					);

				END IF;  -- END: Device exists with other user check

			END IF;  -- END: check for other active devices

		END IF;  -- END: check if current device is mapped to user

	END IF;  -- END: isDeviceValidationReq check

	-- Step 3: Insert attendance record
	INSERT INTO public.attendance (
		company_id,
		user_id,
		entry_type,
		attendance_time,
		latitude,
		longitude,
		distance_from_office,
		is_on_campus, 
		device_info, 
		ip_address, 
		remarks,
		created_by,
		created_at,
		device_id
	) VALUES (
		p_company_id,
		p_user_id,
		TRIM(p_entry_type),
		(now() AT TIME ZONE 'Asia/Kolkata'),
		p_latitude,
		p_longitude,
		p_distance_from_office,
		p_is_on_campus, 
		TRIM(p_device_info), 
		TRIM(p_ip_address), 
		p_remarks,
		p_created_by,
		p_created_at,
		p_device_id
	);

	RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_lock(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.attendance_bulk
    SET is_locked=true
    WHERE id IN (
        SELECT unnest(string_to_array(p_ids, ',')::bigint[])
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_presence_summary(p_company_id bigint, p_report_type text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(attendance_time date, user_id bigint, user_name text, time_in text, time_out text, total_hours text, report_type text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY
	WITH all_dates AS (
		SELECT d::date AS attendance_date
		FROM generate_series(p_from_date, p_to_date, interval '1 day') d
	),
	company_users AS (
		SELECT id AS user_id, first_name, last_name
		FROM public.""user""
		WHERE company_id = p_company_id AND status='Active' AND type_id=2
		  AND (p_user_id IS NULL OR id = p_user_id)
	),
	user_dates AS (
		SELECT u.user_id, u.first_name, u.last_name, d.attendance_date
		FROM company_users u
		CROSS JOIN all_dates d
	),
	attendance_data AS (
		SELECT 
			a.user_id, 
			a.attendance_time::date AS attendance_date,
			MIN(CASE WHEN a.entry_type = 'IN' THEN a.attendance_time END) AS time_in,
			MAX(CASE WHEN a.entry_type = 'OUT' THEN a.attendance_time END) AS time_out
		FROM public.attendance a
		WHERE a.company_id = p_company_id
		  AND a.attendance_time::date BETWEEN p_from_date AND p_to_date
		GROUP BY a.user_id, a.attendance_time::date
	),
	joined AS (
		SELECT 
			ud.attendance_date AS j_attendance_date,
			ud.user_id AS j_user_id,
			CONCAT(ud.first_name, ' ', ud.last_name) AS j_user_name,
			TO_CHAR(ad.time_in, 'HH24:MI:SS') AS j_time_in,
			TO_CHAR(ad.time_out, 'HH24:MI:SS') AS j_time_out,
			TO_CHAR(ad.time_out - ad.time_in, 'HH24:MI:SS') AS j_total_hours,
			CASE 
				WHEN ad.time_in IS NOT NULL AND ad.time_out IS NOT NULL THEN 'present'
				WHEN ad.time_in IS NULL AND ad.time_out IS NULL THEN 'absent'
				ELSE 'incomplete'
			END AS j_report_type
		FROM user_dates ud
		LEFT JOIN attendance_data ad
		  ON ud.user_id = ad.user_id AND ud.attendance_date = ad.attendance_date
	)
	SELECT 
		j_attendance_date AS attendance_time,
		j_user_id AS user_id,
		j_user_name AS user_name,
		j_time_in AS time_in,
		j_time_out AS time_out,
		j_total_hours AS total_hours,
		j_report_type AS report_type
	FROM joined
	WHERE LOWER(p_report_type) = 'all' OR LOWER(j_report_type) = LOWER(p_report_type)
	ORDER BY j_attendance_date DESC, j_user_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_report(p_company_id bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, user_id bigint, user_name text, entry_type text, attendance_time timestamp without time zone, latitude numeric, longitude numeric, distance_from_office numeric, is_on_campus boolean, device_info text, ip_address text, remarks text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone, created_by_name text, modified_by_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        a.id,
        a.user_id,
        CONCAT(u2.first_name, ' ', u2.last_name) AS user_name,
        a.entry_type,
        a.attendance_time,
        a.latitude,
        a.longitude,
        a.distance_from_office,
        a.is_on_campus,
        a.device_info,
        a.ip_address,
        a.remarks,
        a.created_by,
        a.created_at,
        a.modified_by,
        a.modified_at,
        CONCAT(u.first_name, ' ', u.last_name) AS created_by_name,
        CONCAT(u1.first_name, ' ', u1.last_name) AS modified_by_name
    FROM public.attendance a
    LEFT JOIN public.""user"" u ON a.created_by = u.id
    LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
    LEFT JOIN public.""user"" u2 ON a.user_id = u2.id
    WHERE (p_user_id IS NULL OR a.user_id = p_user_id)
      AND a.attendance_time::date BETWEEN p_from_date AND p_to_date
      AND a.company_id = p_company_id
    ORDER BY a.attendance_time DESC;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_review_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint;
	v_from_date date := p_from_date::date;
	v_to_date date := p_to_date::date;
	
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""attendance"" a
	WHERE (LOWER(TRIM(a.entry_type)) LIKE '%' || p_filter_text || '%') 
	AND a.company_id = p_company_id 
	AND (p_user_id IS NULL OR a.user_id = p_user_id)
	AND a.attendance_time::date BETWEEN v_from_date AND v_to_date);  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_review_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, user_id bigint, name text, entry_type text, attendance_time timestamp with time zone, latitude numeric, longitude numeric, distance_from_office numeric, is_on_campus boolean, device_info text, ip_address text, remarks text, is_verified boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_from_date date := p_from_date::date;
	v_to_date date := p_to_date::date;
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
    a.id,
	a.user_id,
    u.first_name as name,
    a.entry_type,
    a.attendance_time,
    a.latitude,
    a.longitude,
    a.distance_from_office, 
    a.is_on_campus, 
    a.device_info, 
    a.ip_address, 
    a.remarks,
	a.is_verified,
	a.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    a.created_at,
    a.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    a.modified_at	
	FROM public.""attendance"" a
	LEFT JOIN public.""user"" u ON a.user_id = u.id
	LEFT JOIN public.""user"" u1 ON a.modified_by = u1.id
	WHERE (LOWER(TRIM(a.entry_type)) LIKE '%' || p_filter_text || '%') 
	AND a.company_id = p_company_id 
	AND (p_user_id IS NULL OR a.user_id = p_user_id)
	AND a.attendance_time::date BETWEEN v_from_date AND v_to_date
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN a.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN a.id END ASC,
	CASE WHEN p_sort_field = 'entry_type' AND p_sort_direction = 'desc' THEN a.entry_type END DESC,
	CASE WHEN p_sort_field = 'entry_type' AND p_sort_direction = 'asc' THEN a.entry_type END ASC
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_update(p_id bigint, p_company_id bigint, p_user_id bigint, p_entry_type text, p_attendance_time timestamp with time zone, p_latitude numeric, p_longitude numeric, p_distance_from_office numeric, p_is_on_campus boolean, p_device_info text, p_ip_address text, p_remarks text, p_modified_by bigint, p_modified_at timestamp without time zone, p_is_verified boolean DEFAULT true)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""attendance"" SET 
      entry_type =  TRIM(p_entry_type),
      attendance_time =p_attendance_time, --  (p_attendance_time AT TIME ZONE 'UTC') AT TIME ZONE 'Asia/Kolkata',
      distance_from_office =  p_distance_from_office,
      device_info =  TRIM(p_device_info), 
      ip_address =  TRIM(p_ip_address), 
      remarks =  p_remarks,
	  is_verified = p_is_verified,
	  modified_by = p_modified_by,
	  modified_at = p_modified_at	
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_attendance_verify(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.attendance
    SET is_verified=true
    WHERE id IN (
        SELECT unnest(string_to_array(p_ids, ',')::bigint[])
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_chatbot_get_history(company_id bigint, session_id text)
 RETURNS TABLE(id bigint, sender text, text text, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT id, sender, text, created_at
  FROM chatbot_messages
  WHERE company_id = company_id
    AND session_id = session_id
  ORDER BY created_at ASC;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_chatbot_send_message(company_id bigint, session_id text, user_input text)
 RETURNS TABLE(id bigint, sender text, text text, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
  bot_response TEXT;
  bot_id BIGINT;
BEGIN
  -- Insert user message
  INSERT INTO chatbot_messages (company_id, session_id, sender, text, created_at)
  VALUES (company_id, session_id, 'user', user_input, NOW());

  -- Basic bot logic
  IF user_input ILIKE '%hello%' THEN
    bot_response := 'Hello! How can I assist you today?';
  ELSE
    bot_response := 'I’m not sure about that. Can you clarify?';
  END IF;

  -- Insert bot response and return it
  INSERT INTO chatbot_messages (company_id, session_id, sender, text, created_at)
  VALUES (company_id, session_id, 'bot', bot_response, NOW())
  RETURNING id, sender, text, created_at INTO bot_id, sender, text, created_at;

  RETURN NEXT;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.code_projects
	SET status = 'In-active'
    WHERE id IN (
        SELECT unnest(string_to_array(p_ids, ',')::bigint[])
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, description text, source_code jsonb, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        cp.id,
        cp.course_id,
        c.course_name,
        cp.title,
        cp.description,
        jsonb_build_object(
            'code',
            CASE 
                WHEN func_is_valid_json(cp.source_code) THEN cp.source_code::jsonb
                ELSE '{}'::jsonb
            END
        ) AS source_code,
        cp.status,
        cp.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        cp.created_at,
        cp.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        cp.modified_at
    FROM public.code_projects cp
    LEFT JOIN public.course c ON cp.course_id = c.id
    LEFT JOIN public.""user"" u ON cp.created_by = u.id
    LEFT JOIN public.""user"" u1 ON cp.modified_by = u1.id
    WHERE cp.company_id = p_company_id AND cp.id=p_id
	Order by cp.title;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, description text, source_code jsonb, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
    cp.id,
    cp.course_id,
    c.course_name,
    cp.title,
    cp.description,
      jsonb_build_object(
          'code',
          CASE 
             WHEN func_is_valid_json(cp.source_code) THEN cp.source_code::jsonb
             ELSE '{}'::jsonb
           END
        ) AS source_code,
    cp.status,
	cp.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    cp.created_at,
    cp.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    cp.modified_at
    FROM public.code_projects cp
    LEFT JOIN public.course c ON cp.course_id = c.id
    LEFT JOIN public.""user"" u ON cp.created_by = u.id
    LEFT JOIN public.""user"" u1 ON cp.modified_by = u1.id
    WHERE cp.company_id = p_company_id
	Order by cp.title;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	
	total_rows = (
		SELECT COUNT(*)
		FROM public.code_projects cp
		LEFT JOIN public.course c ON cp.course_id = c.id
		WHERE (LOWER(TRIM(cp.title)) LIKE '%' || p_filter_text || '%'
			   OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%')
	AND cp.company_id = p_company_id);
	
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, description text, source_code jsonb, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text = LOWER(TRIM(p_filter_text));
    p_sort_field = LOWER(TRIM(p_sort_field));
    p_sort_direction = LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        cp.id,
        cp.course_id,
        c.course_name,
        cp.title,
        cp.description,
        jsonb_build_object(
            'code',
            CASE 
                WHEN func_is_valid_json(cp.source_code) THEN cp.source_code::jsonb
                ELSE '{}'::jsonb
            END
        ) AS source_code,
        cp.status,
        cp.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        cp.created_at,
        cp.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        cp.modified_at
    FROM public.code_projects cp
    LEFT JOIN public.course c ON cp.course_id = c.id
    LEFT JOIN public.""user"" u ON cp.created_by = u.id
    LEFT JOIN public.""user"" u1 ON cp.modified_by = u1.id
    WHERE cp.company_id = p_company_id
      AND (LOWER(TRIM(cp.title)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%')
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN cp.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN cp.id END ASC,
        CASE WHEN p_sort_field = 'title' AND p_sort_direction = 'desc' THEN cp.title END DESC,
        CASE WHEN p_sort_field = 'title' AND p_sort_direction = 'asc' THEN cp.title END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN cp.status END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN cp.status END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_insert(p_company_id bigint, p_course_id bigint, p_title text, p_description text, p_source_code jsonb, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.code_projects (
        company_id, 
		course_id,
        title,
        description,
        source_code,
        status,
        created_by,
        created_at
    )
    VALUES (
        p_company_id,  
		p_course_id,      
        p_title,
        p_description,
        p_source_code,
        p_status,
        p_created_by,
        p_created_at
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
        cp.id,
        cp.title
    FROM public.code_projects cp
    WHERE cp.company_id = p_company_id
	AND status='Active'
    ORDER BY cp.title;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_code_projects_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_title text, p_description text, p_source_code jsonb, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.code_projects
    SET
        course_id = p_course_id,
        title = p_title,
        description = p_description,
        source_code = p_source_code,
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id
      AND company_id = p_company_id;  -- Enforced company-level scoping

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_delete(p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""company""
    SET status='In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id);

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_domain_delete(p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    Update public.company_domain_info
	Set status='In-active'
    WHERE id IN (
        SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
    );

    RETURN true;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Delete Error: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_domain_get(p_id bigint)
 RETURNS TABLE(id bigint, company_id bigint, domain_name text, company_name text, logo_url text, logo_height integer, logo_width integer, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        cd.id,
        cd.company_id,
        cd.domain_name,
        c.company_name,
        cd.logo_url,
        cd.logo_height,
        cd.logo_width,
        cd.status,
        cd.created_by,
        uc.first_name,
        uc.last_name,
        uc.user_name,
        cd.created_at,
        cd.modified_by,
        um.first_name,
        um.last_name,
        um.user_name,
        cd.modified_at
    FROM public.company_domain_info cd
    LEFT JOIN public.company c ON c.id = cd.company_id
    LEFT JOIN public.""user"" uc ON uc.id = cd.created_by
    LEFT JOIN public.""user"" um ON um.id = cd.modified_by
    WHERE cd.id = p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_domain_get_count(p_filter_text text)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM public.company_domain_info cd
        LEFT JOIN public.company c ON cd.company_id = c.id
        WHERE 
            LOWER(cd.domain_name) LIKE LOWER('%' || p_filter_text || '%') OR
            LOWER(c.company_name) LIKE LOWER('%' || p_filter_text || '%')
    );
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_domain_get_page(p_filter_text text, p_sort_field text, p_sort_direction text, p_offset integer, p_limit integer)
 RETURNS TABLE(id bigint, company_id bigint, domain_name text, company_name text, logo_url text, logo_height integer, logo_width integer, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY EXECUTE format(
        'SELECT 
            cd.id,
            cd.company_id,
            cd.domain_name,
            c.company_name,
            cd.logo_url,
            cd.logo_height,
            cd.logo_width,
            cd.status,
            cd.created_by,
            uc.first_name,
            uc.last_name,
            uc.user_name,
            cd.created_at,
            cd.modified_by,
            um.first_name,
            um.last_name,
            um.user_name,
            cd.modified_at
        FROM public.company_domain_info cd
        LEFT JOIN public.company c ON c.id = cd.company_id
        LEFT JOIN public.""user"" uc ON uc.id = cd.created_by
        LEFT JOIN public.""user"" um ON um.id = cd.modified_by
        WHERE 
            LOWER(cd.domain_name) LIKE LOWER(''%%'' || $1 || ''%%'') OR
            LOWER(c.company_name) LIKE LOWER(''%%'' || $1 || ''%%'')
        ORDER BY %I %s
        OFFSET $2 LIMIT $3',
        p_sort_field,
        CASE WHEN LOWER(p_sort_direction) = 'desc' THEN 'DESC' ELSE 'ASC' END
    )
    USING p_filter_text, p_offset, p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_domain_insert(p_company_id bigint, p_domain_name text, p_logo_url text, p_logo_height integer, p_logo_width integer, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.company_domain_info (
        company_id,
        domain_name,
        logo_url,
        logo_height,
        logo_width,
        status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        TRIM(p_domain_name),
        TRIM(p_logo_url),
        p_logo_height,
        p_logo_width,
        TRIM(p_status),
        p_created_by,
        COALESCE(p_created_at, now())
    );

    RETURN true;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Insert Error: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_domain_update(p_id bigint, p_company_id bigint, p_domain_name text, p_logo_url text, p_logo_height integer, p_logo_width integer, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.company_domain_info
    SET 
        company_id = p_company_id,
        domain_name = TRIM(p_domain_name),
        logo_url = TRIM(p_logo_url),
        logo_height = p_logo_height,
        logo_width = p_logo_width,
        status = TRIM(p_status),
        modified_by = p_modified_by,
        modified_at = COALESCE(p_modified_at, now())
    WHERE id = p_id;

    RETURN true;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Update Error: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_get(p_id bigint)
 RETURNS TABLE(id bigint, company_code text, company_name text, company_type text, email text, phone_no text, address text, logo_url text, logo_height integer, logo_width integer, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        c.id,
        c.company_code,
        c.company_name,
        c.company_type,
        c.email,
        c.phone_no,
        c.address,
        cdi.logo_url,
        cdi.logo_height,
        cdi.logo_width,
        c.status,
        c.created_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        c.created_at,
        c.modified_by,
        u2.first_name,
        u2.last_name,
        u2.user_name,
        c.modified_at
    FROM public.""company"" c
    LEFT JOIN (
        SELECT DISTINCT ON (company_id) *
        FROM public.""company_domain_info""
        ORDER BY company_id, id  -- or id DESC to get latest
    ) cdi ON c.id = cdi.company_id
    LEFT JOIN public.""user"" u1 ON c.created_by = u1.id
    LEFT JOIN public.""user"" u2 ON c.modified_by = u2.id
    WHERE c.id = p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_get_count(p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""company"" c
	WHERE (LOWER(TRIM(c.company_name)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.company_type)) LIKE '%' || p_filter_text || '%'
		  ));  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_get_page(p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, company_code text, company_name text, company_type text, email text, phone_no text, address text, logo_url text, logo_height integer, logo_width integer, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text = LOWER(TRIM(p_filter_text));
    p_sort_field = LOWER(TRIM(p_sort_field));
    p_sort_direction = LOWER(TRIM(p_sort_direction));

    RETURN QUERY 	
    SELECT
        c.id,
        c.company_code,
        c.company_name,
        c.company_type,
        c.email,
        c.phone_no,
        c.address,
        cdi.logo_url,
        cdi.logo_height,
        cdi.logo_width,
        c.status,
        c.created_by,
        u.first_name,
        u.last_name,
        u.user_name,
        c.created_at,
        c.modified_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        c.modified_at
    FROM public.""company"" c
    LEFT JOIN (
        SELECT DISTINCT ON (company_id) *
        FROM public.""company_domain_info""
        ORDER BY company_id, id  -- Adjust if you want the latest: ORDER BY company_id, id DESC
    ) cdi ON c.id = cdi.company_id
    LEFT JOIN public.""user"" u ON c.created_by = u.id
    LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
    WHERE (LOWER(TRIM(c.company_name)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.company_type)) LIKE '%' || p_filter_text || '%')
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN c.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN c.id END ASC,
        CASE WHEN p_sort_field = 'company_name' AND p_sort_direction = 'desc' THEN c.company_name END DESC,
        CASE WHEN p_sort_field = 'company_name' AND p_sort_direction = 'asc' THEN c.company_name END ASC,
        CASE WHEN p_sort_field = 'company_code' AND p_sort_direction = 'desc' THEN c.company_code END DESC,
        CASE WHEN p_sort_field = 'company_code' AND p_sort_direction = 'asc' THEN c.company_code END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_info_by_domain_get(p_domain_name text)
 RETURNS TABLE(id bigint, company_id bigint, domain_name text, company_name text, company_type text, company_email text, company_phone_no text, company_address text, logo_url text, logo_height integer, logo_width integer, status text, role_id bigint, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        cdi.id,
        cdi.company_id,
        cdi.domain_name,
        c.company_name,
        c.company_type,
        c.email AS company_email,
        c.phone_no AS company_phone_no,
        c.address AS company_address,
        cdi.logo_url,
        cdi.logo_height,
        cdi.logo_width,
        cdi.status,
        r.id AS role_id, 
        cdi.created_by,
        cdi.created_at,
        cdi.modified_by,
        cdi.modified_at
    FROM public.company_domain_info cdi
    JOIN public.company c ON c.id = cdi.company_id
    LEFT JOIN public.role r ON r.company_id = c.id AND r.role_name = 'Student'
    WHERE LOWER(cdi.domain_name) = LOWER(p_domain_name)
      AND c.status = 'Active' 
      AND cdi.status = 'Active';
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_info_by_domain_get_b(p_domain_name text)
 RETURNS TABLE(id bigint, company_id bigint, domain_name text, company_name text, company_type text, company_email text, company_phone_no text, company_address text, logo_url text, logo_height integer, logo_width integer, status text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        cdi.id,
        cdi.company_id,
        cdi.domain_name,
        c.company_name,
		c.company_type,
        c.email as company_email,
        c.phone_no as company_phone_no,
        c.address as company_address,
		cdi.logo_url,
        cdi.logo_height,
        cdi.logo_width,
        cdi.status,
        cdi.created_by,
        cdi.created_at,
        cdi.modified_by,
        cdi.modified_at
    FROM public.company_domain_info cdi
    JOIN public.company c ON c.id = cdi.company_id
    WHERE lower(cdi.domain_name) = lower(p_domain_name)
      AND c.status = 'Active' and cdi.status='Active';
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_info_by_domain_get_main(p_domain_name text)
 RETURNS TABLE(id bigint, company_id bigint, domain_name text, company_name text, company_type text, company_email text, company_phone_no text, company_address text, logo_url text, logo_height integer, logo_width integer, status text, role_id bigint, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        cdi.id,
        cdi.company_id,
        cdi.domain_name,
        c.company_name,
        c.company_type,
        c.email AS company_email,
        c.phone_no AS company_phone_no,
        c.address AS company_address,
        cdi.logo_url,
        cdi.logo_height,
        cdi.logo_width,
        cdi.status,
        r.id AS role_id, 
        cdi.created_by,
        cdi.created_at,
        cdi.modified_by,
        cdi.modified_at
    FROM public.company_domain_info cdi
    JOIN public.company c ON c.id = cdi.company_id
    LEFT JOIN public.role r ON r.company_id = c.id AND r.role_name = 'Student'
    WHERE LOWER(cdi.domain_name) = LOWER(p_domain_name)
      AND c.status = 'Active' 
      AND cdi.status = 'Active';
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_insert(p_company_code text, p_company_name text, p_company_type text, p_email text, p_phone_no text, p_address text, p_logo_url text, p_logo_height integer, p_logo_width integer, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_company_id bigint;
	v_role_id bigint;
	v_user_id bigint;
	v_type_id bigint;
BEGIN
   	SELECT t.id
	INTO v_type_id
	FROM type t
	WHERE t.type_name = 'Admin'
	LIMIT 1;
	
	-- Insert into company
	INSERT INTO public.company (
		company_code, company_name, company_type,
		email, phone_no, address, status,
		created_by, created_at
	) VALUES (
		TRIM(p_company_code),
		TRIM(p_company_name),
		p_company_type,
		p_email,
		p_phone_no,
		p_address,
		TRIM(p_status),
		p_created_by,
		p_created_at
	)
	RETURNING id INTO v_company_id;

	-- Insert default ""Admin"" role
	INSERT INTO public.role (
		role_name,type_id, created_by, created_at, company_id, status
	) VALUES (
		'Admin',
		v_type_id,
		p_created_by,
		p_created_at,
		v_company_id,
		'Active'
	)
	RETURNING id INTO v_role_id;

	-- Insert default user (username = company_code)
	INSERT INTO public.""user"" (
		first_name, last_name, email, mobile_no, user_name,
		password, status,type_id, created_by, created_at,
		role_id, company_id
	) VALUES (
		p_company_name,
		'Admin',
		p_email,
		p_phone_no,
		TRIM(p_company_code),
		'encrypted_default_password', -- replace with real encryption
		'Active',
		v_type_id,
		p_created_by,
		p_created_at,
		v_role_id,
		v_company_id	
	)
	RETURNING id INTO v_user_id;

	-- Insert default role permissions
	INSERT INTO public.role_permission
	(role_id, option_id, ""grant"", created_by, created_at, company_id)
	SELECT
		v_role_id,
		o.id,
		TRUE,
		p_created_by,
		p_created_at,
		v_company_id
	FROM public.option o
	WHERE NOT EXISTS (
		SELECT 1
		FROM public.role_permission rp
		WHERE rp.role_id = v_role_id
		  AND rp.option_id = o.id
		  AND rp.company_id = v_company_id
	);

	-- Insert default user permissions (for created Admin user only)
	INSERT INTO public.user_permission
	(user_id, option_id, ""grant"", created_by, created_at, company_id)
	SELECT
		v_user_id,
		rp.option_id,
		TRUE,
		p_created_by,
		NOW(),
		v_company_id
	FROM public.role_permission rp
	WHERE rp.role_id = v_role_id
	  AND rp.company_id = v_company_id
	ON CONFLICT (user_id, option_id, company_id)
	DO UPDATE
	SET ""grant"" = EXCLUDED.""grant"",
	    modified_by = p_created_by,
	    modified_at = NOW();

	-- Clone site_config from company_id = 1
	INSERT INTO public.site_config (
		company_id, key, value, type, description,
		status, created_by, created_at
	)
	SELECT
		v_company_id,
		key, value, type, description,
		status, p_created_by, p_created_at
	FROM public.site_config
	WHERE company_id = 1;

	RETURN TRUE;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Error occurred: %', SQLERRM;
		RAISE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_insert_b(p_company_code text, p_company_name text, p_company_type text, p_email text, p_phone_no text, p_address text, p_logo_url text, p_logo_height integer, p_logo_width integer, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_company_id bigint;
	v_role_id bigint;
BEGIN
	-- Insert into company (logo fields excluded)
	INSERT INTO public.""company"" (
		company_code,
		company_name, 
		company_type,
		email,
		phone_no,
		address,
		status,
		created_by,
		created_at
	) VALUES (
		TRIM(p_company_code),
		TRIM(p_company_name),
		p_company_type,
		p_email,
		p_phone_no,
		p_address,
		TRIM(p_status),
		p_created_by,
		p_created_at
	)
	RETURNING id INTO v_company_id;

	-- Insert default ""Admin"" role
	INSERT INTO public.""role"" (
		role_name,
		created_by,
		created_at,
		company_id,
		status
	) VALUES (
		'Admin',
		p_created_by,
		p_created_at,
		v_company_id,
		'Active'
	)
	RETURNING id INTO v_role_id;

	-- Insert default user with user_name = company_code and type = 'Admin'
	INSERT INTO public.""user"" (
		first_name,
		last_name,
		email,
		mobile_no,
		user_name,
		password,
		status,
		created_by,
		created_at,
		modified_by,
		modified_at,
		role_id,
		image_url,
		code,
		company_id,
		affiliate_id,
		type
	) VALUES (
		p_company_name,
		'Admin',
		p_email,
		p_phone_no,
		TRIM(p_company_code),
		'encrypted_default_password',
		'Active',
		p_created_by,
		p_created_at,
		NULL,
		NULL,
		v_role_id,
		NULL,
		NULL,
		v_company_id,
		NULL,
		'Admin'
	);

	-- Clone site_config from company_id = 1
	INSERT INTO public.site_config (
		company_id,
		key,
		value,
		type,
		description,
		status,
		created_by,
		created_at,
		modified_by,
		modified_at
	)
	SELECT
		v_company_id,
		key,
		value,
		type,
		description,
		status,
		p_created_by,
		p_created_at,
		NULL,
		NULL
	FROM public.site_config
	WHERE company_id = 1;

	RETURN true;

EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Error occurred: %', SQLERRM;
		RAISE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_lookup()
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	c.id,
	c.company_name
	FROM public.""company"" c
	WHERE status='Active'
	ORDER BY c.company_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_company_update(p_id bigint, p_company_code text, p_company_name text, p_company_type text, p_email text, p_phone_no text, p_address text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""company"" SET 
    company_code = TRIM(p_company_code),
	company_name = TRIM(p_company_name),
	company_type = p_company_type,
	email =	p_email,
	phone_no = p_phone_no,
	address = p_address,
	status = TRIM(p_status),
	modified_by = p_modified_by,
	modified_at = p_modified_at	
	WHERE id = p_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_contact_us_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    DELETE 
    FROM public.""contact_us""
    WHERE id IN (
        SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;  

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_contact_us_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, contact_name text, email text, phone_no text, category_name text, subject text, message text, created_at timestamp without time zone, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 	
    SELECT
        c.id,
        c.contact_name,
        c.email,
        c.phone_no,
        c.category_name,
        c.subject,
        c.message,    
        c.created_at,
        c.created_by,
        u.first_name,
        u.last_name,
        u.user_name
    FROM public.contact_us c
    LEFT JOIN public.user u ON u.id = c.created_by
    WHERE c.id = p_id
      AND c.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_contact_us_get_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_category_name text DEFAULT 'All'::text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
BEGIN
    -- Trim and sanitize inputs
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_category_name := TRIM(p_category_name);

    total_rows := (
        SELECT COUNT(*)	
        FROM public.contact_us c
        WHERE c.company_id = p_company_id
          AND (
            p_filter_text IS NULL
            OR p_filter_text = ''
            OR LOWER(TRIM(c.contact_name)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(c.email)) LIKE '%' || p_filter_text || '%'
			OR LOWER(TRIM(c.phone_no)) LIKE '%' || p_filter_text || '%'
          )
          AND (
            LOWER(p_category_name) = 'all'
            OR c.category_name = p_category_name
          )
          AND DATE(c.created_at) BETWEEN p_from_date AND p_to_date
    );  

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_contact_us_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_category_name text DEFAULT 'All'::text)
 RETURNS TABLE(id bigint, contact_name text, email text, phone_no text, category_name text, subject text, message text, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Trim and sanitize inputs
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));
    p_category_name := TRIM(p_category_name);

    RETURN QUERY 
    SELECT
        c.id,
        c.contact_name,
        c.email,
        c.phone_no,
        c.category_name,
        c.subject,
        c.message,
        c.created_at
    FROM public.contact_us c
    WHERE c.company_id = p_company_id
      AND (
        p_filter_text IS NULL
        OR p_filter_text = ''
        OR LOWER(TRIM(c.contact_name)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(c.email)) LIKE '%' || p_filter_text || '%'
		OR LOWER(TRIM(c.phone_no)) LIKE '%' || p_filter_text || '%'
      )
      AND (
        LOWER(p_category_name) = 'all'
        OR c.category_name = p_category_name
      )
      AND DATE(c.created_at) BETWEEN p_from_date AND p_to_date
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN c.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN c.id END ASC,
        CASE WHEN p_sort_field = 'contact_name' AND p_sort_direction = 'desc' THEN c.contact_name END DESC,
        CASE WHEN p_sort_field = 'contact_name' AND p_sort_direction = 'asc' THEN c.contact_name END ASC,
        CASE WHEN p_sort_field = 'email' AND p_sort_direction = 'desc' THEN c.email END DESC,
        CASE WHEN p_sort_field = 'email' AND p_sort_direction = 'asc' THEN c.email END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_contact_us_insert(p_company_id bigint, p_contact_name text, p_email text, p_phone_no text, p_category_name text, p_subject text, p_message text, p_can_contacted boolean, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""contact_us"" (
	company_id,
    contact_name,
    email,
    phone_no,
    category_name,
    subject,
    message, 
	can_contacted,
	created_at 
    ) VALUES (
    p_company_id,
    TRIM(p_contact_name),
    TRIM(p_email),
    TRIM(p_phone_no),
    TRIM(p_category_name),
    TRIM(p_subject),
    TRIM(p_message), 
	p_can_contacted,
	p_created_at 
    );
    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_country_name_exist(p_id bigint, p_company_id bigint, p_country_name text)
 RETURNS TABLE(id bigint, country_name character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.country_name
	FROM public.""country"" c
	WHERE c.company_id = p_company_id
	  AND c.id <> p_id
	  AND LOWER(TRIM(c.country_name)) = LOWER(TRIM(p_country_name));
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""country""
	SET Status='In-active'
	WHERE company_id = p_company_id
	  AND id IN (
		  SELECT id::bigint 
		  FROM unnest(string_to_array(p_ids, ',')) AS id
	  );

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, country_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.country_name,
		c.status,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at
	FROM public.""country"" c
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE c.id = p_id
	  AND c.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	
	total_rows := (
		SELECT COUNT(*)	
		FROM public.""country"" c
		WHERE c.company_id = p_company_id
		  AND LOWER(TRIM(c.country_name)) LIKE '%' || p_filter_text || '%'
	);  

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, country_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text := LOWER(TRIM(p_filter_text));
	p_sort_field := LOWER(TRIM(p_sort_field));
	p_sort_direction := LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
    SELECT
		c.id,
		c.country_name,
		c.status,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at
	FROM public.""country"" c
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE c.company_id = p_company_id
	  AND (LOWER(TRIM(c.country_name)) LIKE '%' || p_filter_text || '%')
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN c.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN c.id END ASC,
		CASE WHEN p_sort_field = 'country_name' AND p_sort_direction = 'desc' THEN c.country_name END DESC,
		CASE WHEN p_sort_field = 'country_name' AND p_sort_direction = 'asc' THEN c.country_name END ASC
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_insert(p_company_id bigint, p_country_name text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""country"" (
        company_id,
        country_name,
		status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        TRIM(p_country_name),
		p_status,
        p_created_by,
        p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 	
    SELECT
        c.id,
        c.country_name
    FROM public.""country"" c
    WHERE c.company_id = p_company_id -- Uncomment if country table is company-specific
	AND status='Active'
    ORDER BY c.country_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_country_update(p_id bigint, p_company_id bigint, p_country_name text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""country""
    SET 
        country_name = TRIM(p_country_name),
		status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    -- You may also check IF FOUND THEN RETURN TRUE ELSE RETURN FALSE
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""course""
	SET status = 'In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_name text, course_code text, price bigint, group_name text, duration text, course_type_id bigint, course_type_name text, logo_url text, documents_path text, status text, p_prev_class_marksheet boolean, is10threq boolean, is12threq boolean, isdiplomareq boolean, isgradreq boolean, ispgreq boolean, isphotoidreq boolean, is_aadhar_req boolean, is_birth_certi_req boolean, is_tc_req boolean, is_samagraid_req boolean, quiz_id bigint, quiz_name text, is_paid boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.course_name, 
		c.course_code,
		c.price,
		g.group_name,
		c.duration,
		c.course_type_id,
		ct.course_type_name,
		c.logo_url, 
		c.documents_path, 
		c.status,
		c.prev_class_marksheet,
		c.is10threq, 
		c.is12threq,
		c.isdiplomareq,
		c.isgradreq,
		c.ispgreq,
		c.isphotoidreq,
		c.is_aadhar_req,
		c.is_birth_certi_req,
		c.is_tc_req,
		c.is_samagraid_req,
		c.quiz_id,
		q.quiz_name,
		c.is_paid,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at
	FROM public.""course"" c
	LEFT JOIN public.""coursetype"" ct ON c.course_type_id = ct.id
	LEFT JOIN public.group g on g.id=ct.group_id
	LEFT JOIN public.""quiz"" q ON c.quiz_id = q.id
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE c.id = p_id AND c.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, course_name text, course_code text, price bigint, group_name text, duration text, course_type_id bigint, course_type_name text, logo_url text, documents_path text, status text, prev_class_marksheet boolean, is10threq boolean, is12threq boolean, isdiplomareq boolean, isgradreq boolean, ispgreq boolean, isphotoidreq boolean, is_aadhar_req boolean, is_birth_certi_req boolean, is_tc_req boolean, is_samagraid_req boolean, is_paid boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.course_name, 
		c.course_code,
		c.price,
		g.group_name,
		c.duration,
		c.course_type_id,
		ct.course_type_name,
		c.logo_url, 
		c.documents_path, 
		c.status,
		c.prev_class_marksheet,
		c.is10threq, 
		c.is12threq,
		c.isdiplomareq,
		c.isgradreq,
		c.ispgreq,
		c.isphotoidreq,
		c.is_aadhar_req,
		c.is_birth_certi_req,
		c.is_tc_req,
		c.is_samagraid_req,
		c.is_paid,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at
	FROM public.""course"" c	
	LEFT JOIN public.""coursetype"" ct ON c.course_type_id = ct.id
	LEFT JOIN public.group g on g.id=ct.group_id
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE c.company_id = p_company_id
	ORDER BY c.course_name ASC;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""course"" c
	LEFT JOIN public.""coursetype"" ct ON c.course_type_id = ct.id
	WHERE (LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(ct.course_type_name)) LIKE '%' || p_filter_text || '%'
		  )
	AND c.company_id = p_company_id );  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_name text, course_code text, price bigint, group_name text, duration text, course_type_id bigint, course_type_name text, logo_url text, documents_path text, status text, prev_class_marksheet boolean, is10threq boolean, is12threq boolean, isdiplomareq boolean, isgradreq boolean, ispgreq boolean, isphotoidreq boolean, is_aadhar_req boolean, is_birth_certi_req boolean, is_tc_req boolean, is_samagraid_req boolean, quiz_id bigint, quiz_name text, is_paid boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
    SELECT
		c.id, 
		c.course_name, 
		c.course_code, 
		c.price,
		g.group_name,
		c.duration,
		c.course_type_id,
		ct.course_type_name,
		c.logo_url, 
		c.documents_path,
		c.status,
		c.prev_class_marksheet,
		c.is10threq, 
		c.is12threq,
		c.isdiplomareq,
		c.isgradreq,
		c.ispgreq,
		c.isphotoidreq,
		c.is_aadhar_req,
		c.is_birth_certi_req,
		c.is_tc_req,
		c.is_samagraid_req,
		c.quiz_id,
		q.quiz_name,
		c.is_paid,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at	
	FROM public.""course"" c
	LEFT JOIN public.""quiz"" q ON c.quiz_id = q.id
	LEFT JOIN public.""coursetype"" ct ON c.course_type_id = ct.id
	LEFT JOIN public.group g on g.id=ct.group_id
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE (LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(ct.course_type_name)) LIKE '%' || p_filter_text || '%'
		  )
		AND c.company_id = p_company_id
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN c.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN c.id END ASC,
		CASE WHEN p_sort_field = 'course_name' AND p_sort_direction = 'desc' THEN c.course_name END DESC,
		CASE WHEN p_sort_field = 'course_name' AND p_sort_direction = 'asc' THEN c.course_name END ASC,
		CASE WHEN p_sort_field = 'course_code' AND p_sort_direction = 'desc' THEN c.course_code END DESC,
		CASE WHEN p_sort_field = 'course_code' AND p_sort_direction = 'asc' THEN c.course_code END ASC
	LIMIT p_limit
	OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_insert(p_company_id bigint, p_course_name text, p_course_code text, p_price bigint, p_duration text, p_course_type_id bigint, p_logo_url text, p_documents_path text, p_status text, p_prev_class_marksheet boolean, p_is10threq boolean, p_is12threq boolean, p_isdiplomareq boolean, p_isgradreq boolean, p_ispgreq boolean, p_isphotoidreq boolean, p_is_aadhar_req boolean, p_is_birth_certi_req boolean, p_is_tc_req boolean, p_is_samagraid_req boolean, p_is_paid boolean, p_thumbnail text, p_documentspath text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""course"" (
	    company_id,
        course_name,
		course_code, 
		price,
		duration,
		course_type_id,
		logo_url, 
		documents_path, 
		status,
		prev_class_marksheet,
		is10threq, 
		is12threq,
		isdiplomareq,
		isgradreq,
		ispgreq,
		isphotoidreq,
		is_aadhar_req,
		is_birth_certi_req,
		is_tc_req,
		is_samagraid_req,
	    is_paid,
		created_by,
		created_at		
    ) VALUES (
	    p_company_id,
        TRIM(p_course_name),
		TRIM(p_course_code),
		p_price,
		p_duration,
		p_course_type_id,
		p_logo_url, 
		p_documents_path, 
		TRIM(p_status),
		p_prev_class_marksheet,
		p_is10threq, 
		p_is12threq,
		p_isdiplomareq,
		p_isgradreq,
		p_ispgreq,
		p_isphotoidreq,
		p_is_aadhar_req,
		p_is_birth_certi_req,
		p_is_tc_req,
		p_is_samagraid_req,
		p_is_paid,
		p_created_by,
		p_created_at	
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_lookup(p_company_id bigint, p_group_name text DEFAULT NULL::text)
 RETURNS TABLE(id bigint, text text, price bigint, group_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
	SELECT
		c.id,
		c.course_name,
		c.price,
		g.group_name
	FROM public.""course"" c
	LEFT JOIN public.coursetype ct ON ct.id = c.course_type_id
	LEFT JOIN public.""group"" g ON g.id = ct.group_id
	WHERE c.company_id = p_company_id
	  AND c.status = 'Active'
	  AND (
	      p_group_name IS NULL OR g.group_name = p_group_name
	  )
	ORDER BY c.course_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.courseType
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::bigint
        FROM unnest(string_to_array(p_ids, ',')) AS id
    );
    --AND company_id = p_company_id;
    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_type_name text, code text, group_id bigint, group_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp with time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        ct.id,
        ct.course_type_name,
        ct.code,
		ct.group_id,
		g.group_name,
        ct.status,
        ct.created_by,
        u.first_name,
        u.last_name,
        u.user_name,
        ct.created_at,
        ct.modified_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        ct.modified_at
    FROM public.courseType ct
	LEFT JOIN public.group g on g.id=ct.group_id
    LEFT JOIN public.""user"" u ON ct.created_by = u.id
    LEFT JOIN public.""user"" u1 ON ct.modified_by = u1.id
    WHERE ct.id = p_id ;--AND ct.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));

    total_rows := (
        SELECT COUNT(*)
        FROM public.courseType ct
        WHERE (
            LOWER(TRIM(ct.course_type_name)) LIKE '%' || p_filter_text || '%' OR
            LOWER(TRIM(ct.code)) LIKE '%' || p_filter_text || '%'
        )
        --AND ct.company_id = p_company_id
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_type_name text, code text, group_id bigint, group_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp with time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
    p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
    p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

    RETURN QUERY
    SELECT
        ct.id,
        ct.course_type_name,
        ct.code,
		ct.group_id,
		g.group_name,
        ct.status,
        ct.created_by,
        COALESCE(u.first_name, '')::text AS created_by_first_name,
        COALESCE(u.last_name, '')::text AS created_by_last_name,
        COALESCE(u.user_name, '')::text AS created_by_user_name,
        ct.created_at,
        ct.modified_by,
        COALESCE(u1.first_name, '')::text AS modified_by_first_name,
        COALESCE(u1.last_name, '')::text AS modified_by_last_name,
        COALESCE(u1.user_name, '')::text AS modified_by_user_name,
        ct.modified_at
    FROM public.courseType ct
	LEFT JOIN public.group g on g.id=ct.group_id
    LEFT JOIN public.""user"" u ON ct.created_by = u.id
    LEFT JOIN public.""user"" u1 ON ct.modified_by = u1.id
    WHERE (
        LOWER(TRIM(ct.course_type_name)) LIKE '%' || p_filter_text || '%' OR
        LOWER(TRIM(ct.code)) LIKE '%' || p_filter_text || '%'
    ) --AND ct.company_id = p_company_id
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN ct.id END ASC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN ct.id END DESC,
        CASE WHEN p_sort_field = 'course_type_name' AND p_sort_direction = 'asc' THEN ct.course_type_name END ASC,
        CASE WHEN p_sort_field = 'course_type_name' AND p_sort_direction = 'desc' THEN ct.course_type_name END DESC,
        CASE WHEN p_sort_field = 'code' AND p_sort_direction = 'asc' THEN ct.code END ASC,
        CASE WHEN p_sort_field = 'code' AND p_sort_direction = 'desc' THEN ct.code END DESC
    LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_insert(p_company_id bigint, p_course_type_name text, p_code text, p_group_id bigint, p_status text, p_created_by bigint, p_created_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.courseType (
        company_id,
        course_type_name,
        code,
		group_id,
        status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        TRIM(p_course_type_name),
        TRIM(p_code),
		p_group_id,
        TRIM(p_status),
        p_created_by,
        p_created_at
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_lookup(p_company_id bigint, p_group_name text DEFAULT NULL::text)
 RETURNS TABLE(id bigint, text text, group_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        ct.id, 
        ct.course_type_name, 
        g.group_name
    FROM public.courseType ct
    LEFT JOIN public.group g ON ct.group_id = g.id
    WHERE ct.status = 'Active'
      -- AND ct.company_id = p_company_id  -- Uncomment if needed
      AND (
            p_group_name IS NULL 
            OR g.group_name = p_group_name
            OR g.group_name = 'Enrichment'
          )
    ORDER BY ct.course_type_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_lookup_b(p_company_id bigint, p_group_name text DEFAULT NULL::text)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT ct.id, ct.course_type_name
    FROM public.courseType ct
    LEFT JOIN public.group g ON ct.group_id = g.id
    WHERE ct.status = 'Active' 
      --AND ct.company_id = p_company_id
      AND (
            p_group_name IS NULL OR g.group_name = p_group_name
          )
    ORDER BY ct.course_type_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_name_exist(p_id bigint, p_company_id bigint, p_course_type_name text)
 RETURNS TABLE(id bigint, course_type_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    ct.id,
    ct.course_type_name
  FROM public.course_type ct
  WHERE ct.id <> p_id
    --AND ct.company_id = p_company_id
    AND LOWER(TRIM(ct.course_type_name)) = LOWER(TRIM(p_course_type_name));
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_type_update(p_id bigint, p_company_id bigint, p_course_type_name text, p_code text, p_group_id bigint, p_status text, p_modified_by bigint, p_modified_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.courseType
    SET
        course_type_name = TRIM(p_course_type_name),
        code = TRIM(p_code),
		group_id=p_group_id,
        status = TRIM(p_status),
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id; -- AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_course_update(p_id bigint, p_company_id bigint, p_course_name text, p_course_code text, p_price bigint, p_duration text, p_course_type_id bigint, p_logo_url text, p_documents_path text, p_status text, p_prev_class_marksheet boolean, p_is10threq boolean, p_is12threq boolean, p_isdiplomareq boolean, p_isgradreq boolean, p_ispgreq boolean, p_isphotoidreq boolean, p_is_aadhar_req boolean, p_is_birth_certi_req boolean, p_is_tc_req boolean, p_is_samagraid_req boolean, p_is_paid boolean, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""course"" SET 
		company_id = p_company_id,
		course_name = TRIM(p_course_name),
		course_code = TRIM(p_course_code), 
		price = p_price,
		duration = p_duration,
		course_type_id = p_course_type_id,
		logo_url = TRIM(p_logo_url), 
		documents_path = TRIM(p_documents_path),
		status = TRIM(p_status),
		prev_class_marksheet=p_prev_class_marksheet,
		is10threq = p_is10threq, 
		is12threq = p_is12threq,
		isdiplomareq = p_isdiplomareq,
		isgradreq = p_isgradreq,
		ispgreq = p_ispgreq,
		isphotoidreq = p_isphotoidreq,
		is_aadhar_req = p_is_aadhar_req,
		is_birth_certi_req = p_is_birth_certi_req,
		is_tc_req = p_is_tc_req,
		is_samagraid_req = p_is_samagraid_req,
		is_paid = p_is_paid,
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_currency_code_exist(p_id bigint, p_company_id bigint, p_currency_code text)
 RETURNS TABLE(id bigint, currency_code text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.currency_code
	FROM public.""currency"" c
	WHERE 
		c.id <> p_id 
		AND LOWER(TRIM(c.currency_code)) = LOWER(TRIM(p_currency_code)) 
		AND COALESCE(c.currency_code, '') <> ''
		AND c.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_currency_name_exist(p_id bigint, p_company_id bigint, p_currency_name text)
 RETURNS TABLE(id bigint, currency_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.currency_name
	FROM public.""currency"" c
	WHERE 
		c.id <> p_id 
		AND LOWER(TRIM(c.currency_name)) = LOWER(TRIM(p_currency_name))
		AND c.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""currency""
	SET Status='In-active'
	WHERE 
		id IN (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
		AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, currency_code text, currency_name text, currency_symbol text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
		c.currency_code,
		c.currency_name,
		c.currency_symbol,
		c.status,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at
	FROM public.""currency"" c
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE c.id = p_id; --AND c.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	
	total_rows = (
		SELECT COUNT(*)	
		FROM public.""currency"" c
		WHERE 
			--c.company_id = p_company_id AND
			(LOWER(TRIM(c.currency_name)) LIKE '%' || p_filter_text || '%'
			OR LOWER(TRIM(c.currency_code)) LIKE '%' || p_filter_text || '%'
			)
	);  

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, currency_code text, currency_name text, currency_symbol text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	
	RETURN QUERY 	
    SELECT
		c.id,
		c.currency_code,
		c.currency_name,
		c.currency_symbol,
		c.status,
		c.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		c.created_at,
		c.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		c.modified_at
	FROM public.""currency"" c
	LEFT JOIN public.""user"" u ON c.created_by = u.id
	LEFT JOIN public.""user"" u1 ON c.modified_by = u1.id
	WHERE 
		--c.company_id = p_company_id AND
		(LOWER(TRIM(c.currency_name)) LIKE '%' || p_filter_text || '%'
		OR LOWER(TRIM(c.currency_code)) LIKE '%' || p_filter_text || '%')
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN c.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN c.id END ASC,
		CASE WHEN p_sort_field = 'currency_name' AND p_sort_direction = 'desc' THEN c.currency_name END DESC,
		CASE WHEN p_sort_field = 'currency_name' AND p_sort_direction = 'asc' THEN c.currency_name END ASC,
		CASE WHEN p_sort_field = 'currency_code' AND p_sort_direction = 'desc' THEN c.currency_code END DESC,
		CASE WHEN p_sort_field = 'currency_code' AND p_sort_direction = 'asc' THEN c.currency_code END ASC,
		CASE WHEN p_sort_field = 'currency_symbol' AND p_sort_direction = 'desc' THEN c.currency_symbol END DESC,
		CASE WHEN p_sort_field = 'currency_symbol' AND p_sort_direction = 'asc' THEN c.currency_symbol END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_insert(p_company_id bigint, p_currency_code text, p_currency_name text, p_currency_symbol text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""currency"" (
        currency_code,
		currency_name,
		currency_symbol,
		status,
		created_by,
		created_at,
		company_id
    ) VALUES (
        TRIM(p_currency_code),
		TRIM(p_currency_name),
		TRIM(p_currency_symbol),
		p_status,
		p_created_by,
		p_created_at,
		p_company_id
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		c.id,
    	c.currency_name	
	FROM public.""currency"" c
	WHERE status='Active' --AND c.company_id = p_company_id
	ORDER BY c.currency_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_currency_update(p_id bigint, p_company_id bigint, p_currency_code text, p_currency_name text, p_currency_symbol text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""currency"" SET 
		currency_code = TRIM(p_currency_code),
		currency_name = TRIM(p_currency_name),
		currency_symbol = TRIM(p_currency_symbol),
		status=p_status,
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE id = p_id; --AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.district
    SET status = 'In-active'
    WHERE company_id = p_company_id
      AND id IN (
          SELECT id::bigint 
          FROM unnest(string_to_array(p_ids, ',')) AS id
      );

    RETURN true;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, district_name text, state_id bigint, state_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		d.id, 
		d.district_name, 
		d.state_id,
		s.state_name,
		d.status,
		d.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		d.created_at,
		d.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		d.modified_at
	FROM public.district d
	LEFT JOIN public.state s ON d.state_id = s.id
	LEFT JOIN public.""user"" u ON d.created_by = u.id
	LEFT JOIN public.""user"" u1 ON d.modified_by = u1.id
	WHERE d.id = p_id
	  AND d.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	
	total_rows = (
		SELECT COUNT(*)	
		FROM public.district d
		LEFT JOIN public.state s ON d.state_id = s.id
		WHERE d.company_id = p_company_id
		  AND (
			LOWER(TRIM(d.district_name)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(s.state_name)) LIKE '%' || p_filter_text || '%'
		  )
	);  

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, district_name text, state_id bigint, state_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
    SELECT
		d.id, 
		d.district_name, 
		d.state_id,
		s.state_name,
		d.status,
		d.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		d.created_at,
		d.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		d.modified_at	
	FROM public.district d
	LEFT JOIN public.state s ON d.state_id = s.id
	LEFT JOIN public.""user"" u ON d.created_by = u.id
	LEFT JOIN public.""user"" u1 ON d.modified_by = u1.id
	WHERE d.company_id = p_company_id
	  AND (
			LOWER(TRIM(d.district_name)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(s.state_name)) LIKE '%' || p_filter_text || '%'
	  )
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN d.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN d.id END ASC,
		CASE WHEN p_sort_field = 'district_name' AND p_sort_direction = 'desc' THEN d.district_name END DESC,
		CASE WHEN p_sort_field = 'district_name' AND p_sort_direction = 'asc' THEN d.district_name END ASC,
		CASE WHEN p_sort_field = 'state_name' AND p_sort_direction = 'desc' THEN s.state_name END DESC,
		CASE WHEN p_sort_field = 'state_name' AND p_sort_direction = 'asc' THEN s.state_name END ASC
	LIMIT p_limit
	OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_insert(p_company_id bigint, p_district_name text, p_state_id bigint, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.district (
        company_id,
        district_name,
        state_id,
        status,
        created_by,
        created_at		
    ) VALUES (
        p_company_id,
        TRIM(p_district_name),
        p_state_id,
        p_status,
        p_created_by,
        p_created_at	
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_lookup(p_company_id bigint, p_state_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 	
    SELECT
        d.id,
        d.district_name
    FROM public.district d
    WHERE d.company_id = p_company_id
      AND d.state_id = p_state_id
      AND d.status = 'Active'
    ORDER BY d.district_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_district_update(p_id bigint, p_company_id bigint, p_district_name text, p_state_id bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.district 
    SET 
		district_name = TRIM(p_district_name),
		state_id = p_state_id,
		status = p_status,
		modified_by = p_modified_by,
		modified_at = p_modified_at	
    WHERE id = p_id
      AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_due_payment_get(p_admission_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, fee_frequency text, fee_month integer, fee_year integer, fee_amount numeric, is_paid boolean, due_date date)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        f.id,
        f.course_id,
        c.course_name,
        f.fee_frequency,
        f.fee_month,
        f.fee_year,
        f.fee_amount,
        f.is_paid,
        make_date(f.fee_year, f.fee_month, 1) AS due_date
    FROM 
        public.student_monthly_fees f
    JOIN 
        public.course c ON f.course_id = c.id
    WHERE 
        f.admission_id = p_admission_id
        AND f.company_id = p_company_id
        AND f.is_paid = false
        AND make_date(f.fee_year, f.fee_month, 1) <= date_trunc('month', CURRENT_DATE);
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_insert(p_company_id bigint, p_to_address text, p_subject text, p_body text, p_template_name text, p_attachment_path text, p_status text, p_retry_count bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  INSERT INTO public.emails (
    to_address, subject, body,
    template_name, attachment_path,
    status, retry_count,sent_at, created_at, company_id
  ) VALUES (
    p_to_address, p_subject, p_body,
    p_template_name, p_attachment_path,
    p_status, p_retry_count,p_created_at, p_created_at, p_company_id
  );
  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_resend_otp(p_company_id bigint, p_to_address text, p_otp text, p_purpose text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
  existing_id BIGINT;
BEGIN
  -- Check for an existing unverified and active OTP
  SELECT id INTO existing_id
  FROM public.email_otps
  WHERE to_address = p_to_address
    AND purpose = p_purpose
    AND is_verified = FALSE
    AND expires_at > p_created_at
    AND company_id = p_company_id
    AND status = 'Active'
  LIMIT 1;

  IF FOUND THEN
    -- Mark all matching existing OTPs as inactive
    UPDATE public.email_otps
    SET status = 'In_active'
    WHERE to_address = p_to_address
      AND purpose = p_purpose
      AND is_verified = FALSE
      AND expires_at > p_created_at
      AND company_id = p_company_id
      AND status = 'Active';
  END IF;

  -- Send new OTP regardless
  RETURN func_email_send_otp(p_company_id, p_to_address, p_otp, p_purpose, p_created_at);

EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in func_email_resend_otp: %', SQLERRM;
  RETURN FALSE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_resend_otp_b(p_company_id bigint, p_to_address text, p_purpose text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
  existing_id BIGINT;
BEGIN
  SELECT id INTO existing_id
  FROM public.email_otps
  WHERE to_address = p_to_address
    AND purpose = p_purpose
    AND is_verified = FALSE
    AND expires_at > p_created_at
    AND company_id = p_company_id
  LIMIT 1;

  IF FOUND THEN
    RETURN TRUE; -- Existing OTP still valid
  ELSE
    RETURN func_email_send_otp(p_company_id, p_to_address, p_purpose, p_created_at);
  END IF;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_send_otp(p_company_id bigint, p_to_address text, p_otp text, p_purpose text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
  -- otp_value TEXT := lpad((floor(random() * 1000000))::TEXT, 6, '0');
  expires TIMESTAMP := p_created_at + INTERVAL '10 minutes';
BEGIN
  INSERT INTO public.email_otps (
    company_id, to_address, otp, purpose, expires_at, created_at
  ) VALUES (
    p_company_id, p_to_address, p_otp, p_purpose, expires, p_created_at
  );
  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
 RAISE NOTICE 'Error in func_email_send_otp: %', SQLERRM;
  RETURN FALSE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.email_template
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::bigint
        FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, email_template_name text, email_template_body text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        et.id,
        et.email_template_name,
        et.email_template_body,
        et.status,
        et.created_by,
        COALESCE(u.first_name, '')::text AS created_by_first_name,
        COALESCE(u.last_name, '')::text AS created_by_last_name,
        COALESCE(u.user_name, '')::text AS created_by_user_name,
        et.created_at,
        et.modified_by,
        COALESCE(u1.first_name, '')::text AS modified_by_first_name,
        COALESCE(u1.last_name, '')::text AS modified_by_last_name,
        COALESCE(u1.user_name, '')::text AS modified_by_user_name,
        et.modified_at
    FROM public.email_template et
    LEFT JOIN public.""user"" u ON et.created_by = u.id
    LEFT JOIN public.""user"" u1 ON et.modified_by = u1.id
    WHERE et.id = p_id AND et.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));

    total_rows := (
        SELECT COUNT(*)
        FROM public.email_template et
        WHERE (
            LOWER(TRIM(et.email_template_name)) LIKE '%' || p_filter_text || '%' OR
            LOWER(TRIM(et.email_template_body)) LIKE '%' || p_filter_text || '%'
        )
        AND et.company_id = p_company_id
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, email_template_name text, email_template_body text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
    p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
    p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

    RETURN QUERY
    SELECT
        et.id,
        et.email_template_name,
        et.email_template_body,
        et.status,
        et.created_by,
        COALESCE(u.first_name, '')::text AS created_by_first_name,
        COALESCE(u.last_name, '')::text AS created_by_last_name,
        COALESCE(u.user_name, '')::text AS created_by_user_name,
        et.created_at,
        et.modified_by,
        COALESCE(u1.first_name, '')::text AS modified_by_first_name,
        COALESCE(u1.last_name, '')::text AS modified_by_last_name,
        COALESCE(u1.user_name, '')::text AS modified_by_user_name,
        et.modified_at
    FROM public.email_template et
    LEFT JOIN public.""user"" u ON et.created_by = u.id
    LEFT JOIN public.""user"" u1 ON et.modified_by = u1.id
    WHERE (
        LOWER(TRIM(et.email_template_name)) LIKE '%' || p_filter_text || '%' OR
        LOWER(TRIM(et.email_template_body)) LIKE '%' || p_filter_text || '%'
    ) AND et.company_id = p_company_id
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN et.id END ASC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN et.id END DESC,
        CASE WHEN p_sort_field = 'email_template_name' AND p_sort_direction = 'asc' THEN et.email_template_name END ASC,
        CASE WHEN p_sort_field = 'email_template_name' AND p_sort_direction = 'desc' THEN et.email_template_name END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN et.status END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN et.status END DESC
    LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_insert(p_company_id bigint, p_email_template_name text, p_email_template_body text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.email_template (
        company_id,
        email_template_name,
        email_template_body,
        status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        TRIM(p_email_template_name),
        TRIM(p_email_template_body),
        TRIM(p_status),
        p_created_by,
        p_created_at  
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        et.id,
        et.email_template_name AS text
    FROM public.email_template et
    WHERE et.company_id = p_company_id AND status='Active'
    ORDER BY et.email_template_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_name_exist(p_id bigint, p_company_id bigint, p_email_template_name text)
 RETURNS TABLE(id bigint, email_template_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    et.id,
    et.email_template_name
  FROM public.email_template et
  WHERE et.id <> p_id
    AND et.company_id = p_company_id
    AND LOWER(TRIM(et.email_template_name)) = LOWER(TRIM(p_email_template_name));
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_template_update(p_id bigint, p_company_id bigint, p_email_template_name text, p_email_template_body text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.email_template
    SET
        company_id = p_company_id,
        email_template_name = TRIM(p_email_template_name),
        email_template_body = TRIM(p_email_template_body),
        status = TRIM(p_status),
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id and company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_email_verify_otp(p_company_id bigint, p_to_address text, p_otp text, p_purpose text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
  otp_rec RECORD;
BEGIN
  SELECT id INTO otp_rec
  FROM public.email_otps
  WHERE to_address = p_to_address
    AND otp = p_otp
    AND purpose = p_purpose
    AND is_verified = FALSE
    AND expires_at > p_created_at
    AND company_id = p_company_id
  LIMIT 1;

  IF NOT FOUND THEN
    RETURN FALSE;
  END IF;

  UPDATE public.email_otps
  SET is_verified = TRUE, verified_at = p_created_at
  WHERE id = otp_rec.id;

  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_emails_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, to_address text, subject text, body text, otp text, template_name text, attachment_path text, status text, retry_count integer, sent_at timestamp without time zone, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        e.id,
        e.to_address,
        e.subject,
        e.body,
        e.otp,
        e.template_name,
        e.attachment_path,
        e.status,
        e.retry_count,
        e.sent_at,
        e.created_at
    FROM public.emails e
    WHERE e.id = p_id
      AND e.company_id = p_company_id
    LIMIT 1;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_emails_get_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_status text DEFAULT 'All'::text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
BEGIN
    -- Trim and sanitize inputs
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_status := TRIM(p_status);

    total_rows := (
        SELECT COUNT(*)
        FROM public.emails e
        WHERE (
            p_filter_text IS NULL
            OR p_filter_text = ''
            OR LOWER(TRIM(e.to_address)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(e.subject)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(e.body)) LIKE '%' || p_filter_text || '%'
        )
		AND e.company_id = p_company_id
        AND (
            LOWER(p_status) = 'all'
            OR LOWER(e.status) = LOWER(p_status)
        )
        AND DATE(e.created_at) BETWEEN p_from_date AND p_to_date
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_emails_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_status text DEFAULT 'All'::text)
 RETURNS TABLE(id bigint, to_address text, subject text, body text, otp text, template_name text, attachment_path text, status text, retry_count integer, sent_at timestamp without time zone, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Sanitize inputs
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));
    p_status := TRIM(p_status);

    RETURN QUERY 
    SELECT
        e.id,
        e.to_address,
        e.subject,
        e.body,
        e.otp,
        e.template_name,
        e.attachment_path,
        e.status,
        e.retry_count,
        e.sent_at,
        e.created_at
    FROM public.emails e
    WHERE (
        p_filter_text IS NULL
        OR p_filter_text = ''
        OR LOWER(TRIM(e.to_address)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(e.subject)) LIKE '%' || p_filter_text || '%'
        OR LOWER(TRIM(e.body)) LIKE '%' || p_filter_text || '%'
    )
    AND (
        LOWER(p_status) = 'all'
        OR LOWER(e.status) = LOWER(p_status)
    )
    AND DATE(e.created_at) BETWEEN p_from_date AND p_to_date AND e.company_id = p_company_id
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN e.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN e.id END ASC,
        CASE WHEN p_sort_field = 'to_address' AND p_sort_direction = 'desc' THEN e.to_address END DESC,
        CASE WHEN p_sort_field = 'to_address' AND p_sort_direction = 'asc' THEN e.to_address END ASC,
        CASE WHEN p_sort_field = 'subject' AND p_sort_direction = 'desc' THEN e.subject END DESC,
        CASE WHEN p_sort_field = 'subject' AND p_sort_direction = 'asc' THEN e.subject END ASC,
        CASE WHEN p_sort_field = 'created_at' AND p_sort_direction = 'desc' THEN e.created_at END DESC,
        CASE WHEN p_sort_field = 'created_at' AND p_sort_direction = 'asc' THEN e.created_at END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.employee
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::BIGINT
        FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_email_exist(p_id bigint, p_company_id bigint, p_email text)
 RETURNS TABLE(id bigint, email text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	e.id,
	e.email
	FROM public.""employee"" e
	WHERE e.id <> p_id AND LOWER(TRIM(e.email)) = LOWER(TRIM(p_email))
	AND e.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, company_id bigint, first_name text, last_name text, user_name text, emp_code text, joining_date timestamp without time zone, department_type text, qualification text, experience numeric, designation text, salary numeric, dob date, gender text, email text, phone_no text, marital_status text, father_name text, mother_name text, husband_wife_name text, address text, aadhaar_no text, pan_card text, status text, photo text, photoidproof text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    e.id,
    e.company_id,
    e.first_name,
    e.last_name,
    e.user_name,
    e.emp_code,
    e.joining_date,
    e.department_type,
    e.qualification,
    e.experience,
    e.designation,
    e.salary,
    e.dob,
    e.gender,
    e.email,
    e.phone_no,
    e.marital_status,
    e.father_name,
    e.mother_name,
    e.husband_wife_name,
    e.address,
    e.aadhaar_no,
    e.pan_card,
    e.status,
    e.photo,
    e.photoidproof,
    e.created_by,
    COALESCE(u.first_name, '')::text AS created_by_first_name,
    COALESCE(u.last_name, '')::text AS created_by_last_name,
    COALESCE(u.user_name, '')::text AS created_by_user_name,
    e.created_at,
    e.modified_by,
    COALESCE(u1.first_name, '')::text AS modified_by_first_name,
    COALESCE(u1.last_name, '')::text AS modified_by_last_name,
    COALESCE(u1.user_name, '')::text AS modified_by_user_name,
    e.modified_at
  FROM public.employee e
  LEFT JOIN public.""user"" u ON e.created_by = u.id
  LEFT JOIN public.""user"" u1 ON e.modified_by = u1.id
  WHERE e.id = p_id AND e.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));

    total_rows := (
        SELECT COUNT(*)
        FROM public.employee e
        WHERE e.company_id = p_company_id
          AND (
              LOWER(COALESCE(e.first_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.last_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.user_name, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.emp_code, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.email, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.phone_no, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.department_type, '')) LIKE '%' || p_filter_text || '%'
              OR LOWER(COALESCE(e.designation, '')) LIKE '%' || p_filter_text || '%'
          )
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, company_id bigint, first_name text, last_name text, user_name text, emp_code text, joining_date timestamp without time zone, department_type text, qualification text, experience numeric, designation text, salary numeric, dob date, gender text, email text, phone_no text, marital_status text, father_name text, mother_name text, husband_wife_name text, address text, aadhaar_no text, pan_card text, status text, photo text, photoidproof text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
  p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
  p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

  RETURN QUERY
  SELECT
    e.id,
    e.company_id,
    e.first_name,
    e.last_name,
    e.user_name,
    e.emp_code,
    e.joining_date,
    e.department_type,
    e.qualification,
    e.experience,
    e.designation,
    e.salary,
    e.dob,
    e.gender,
    e.email,
    e.phone_no,
    e.marital_status,
    e.father_name,
    e.mother_name,
    e.husband_wife_name,
    e.address,
    e.aadhaar_no,
    e.pan_card,
    e.status,
    e.photo,
    e.photoidproof,
    e.created_by,
    COALESCE(u.first_name, '')::text AS created_by_first_name,
    COALESCE(u.last_name, '')::text AS created_by_last_name,
    COALESCE(u.user_name, '')::text AS created_by_user_name,
    e.created_at,
    e.modified_by,
    COALESCE(u1.first_name, '')::text AS modified_by_first_name,
    COALESCE(u1.last_name, '')::text AS modified_by_last_name,
    COALESCE(u1.user_name, '')::text AS modified_by_user_name,
    e.modified_at
  FROM public.employee e
  LEFT JOIN public.""user"" u ON e.created_by = u.id
  LEFT JOIN public.""user"" u1 ON e.modified_by = u1.id
  WHERE (
    LOWER(TRIM(e.first_name)) LIKE '%' || p_filter_text || '%' OR
    LOWER(TRIM(e.last_name)) LIKE '%' || p_filter_text || '%' OR
    LOWER(TRIM(e.user_name)) LIKE '%' || p_filter_text || '%' OR
    LOWER(TRIM(e.emp_code)) LIKE '%' || p_filter_text || '%'
  ) AND e.company_id = p_company_id
  ORDER BY
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN e.id END ASC,
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN e.id END DESC,
    CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'asc' THEN e.first_name END ASC,
    CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'desc' THEN e.first_name END DESC,
    CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'asc' THEN e.user_name END ASC,
    CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'desc' THEN e.user_name END DESC
  LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_insert(p_company_id bigint, p_first_name text, p_last_name text, p_user_name text, p_emp_code text, p_joining_date date, p_department_type text, p_qualification text, p_experience numeric, p_designation text, p_salary numeric, p_dob date, p_gender text, p_email text, p_phone_no text, p_marital_status text, p_father_name text, p_mother_name text, p_husband_wife_name text, p_address text, p_aadhaar_no text, p_pan_card text, p_status text, p_photo text, p_photoidproof text, p_created_by bigint, p_created_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.employee (
        company_id,
        first_name, last_name, user_name, emp_code, joining_date,
        department_type, qualification, experience, designation, salary,
        dob, gender, email, phone_no, marital_status,
        father_name, mother_name, husband_wife_name, address,
        aadhaar_no, pan_card, status,
        photo, photoidproof,
        created_by, created_at
    )
    VALUES (
        p_company_id,
        p_first_name, p_last_name, p_user_name, p_emp_code, p_joining_date,
        p_department_type, p_qualification, p_experience, p_designation, p_salary,
        p_dob, p_gender, p_email, p_phone_no, p_marital_status,
        p_father_name, p_mother_name, p_husband_wife_name, p_address,
        p_aadhaar_no, p_pan_card, COALESCE(p_status, 'Active'),
        p_photo, p_photoidproof,
        p_created_by, p_created_at
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_employee_update(p_id bigint, p_company_id bigint, p_first_name text, p_last_name text, p_user_name text, p_emp_code text, p_joining_date date, p_department_type text, p_qualification text, p_experience numeric, p_designation text, p_salary numeric, p_dob date, p_gender text, p_email text, p_phone_no text, p_marital_status text, p_father_name text, p_mother_name text, p_husband_wife_name text, p_address text, p_aadhaar_no text, p_pan_card text, p_status text, p_photo text, p_photoidproof text, p_modified_by bigint, p_modified_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.employee
    SET
        company_id = p_company_id,
        first_name = p_first_name,
        last_name = p_last_name,
        user_name = p_user_name,
        emp_code = p_emp_code,
        joining_date = p_joining_date,
        department_type = p_department_type,
        qualification = p_qualification,
        experience = p_experience,
        designation = p_designation,
        salary = p_salary,
        dob = p_dob,
        gender = p_gender,
        email = p_email,
        phone_no = p_phone_no,
        marital_status = p_marital_status,
        father_name = p_father_name,
        mother_name = p_mother_name,
        husband_wife_name = p_husband_wife_name,
        address = p_address,
        aadhaar_no = p_aadhaar_no,
        pan_card = p_pan_card,
        status = COALESCE(p_status, 'Active'),
        photo = p_photo,
        photoidproof = p_photoidproof,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_enrollment_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.enrollments
    SET status = 'In-active'
    WHERE company_id = p_company_id
      AND id IN (
          SELECT id::bigint
          FROM unnest(string_to_array(p_ids, ',')) AS id
      );

    RETURN true; -- indicate success
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_enrollment_get(p_company_id bigint, p_id bigint)
 RETURNS TABLE(id bigint, user_id bigint, user_name text, course_id bigint, course_name text, company_id bigint, enrollment_date timestamp with time zone, end_date timestamp with time zone, paid_amount numeric, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        e.id,
        e.user_id,
        u.user_name,
        e.course_id,
        c.course_name,
        e.company_id,
        e.enrollment_date,
        e.end_date,
		e.paid_amount,
        e.status,
        e.created_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        e.created_at,
        e.modified_by,
        u2.first_name,
        u2.last_name,
        u2.user_name,
        e.modified_at
    FROM public.enrollments e
    LEFT JOIN public.""user"" u  ON e.user_id     = u.id
    LEFT JOIN public.""course"" c ON e.course_id  = c.id
    LEFT JOIN public.""user"" u1 ON e.created_by  = u1.id
    LEFT JOIN public.""user"" u2 ON e.modified_by = u2.id
    WHERE e.id = p_id
      AND e.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_enrollment_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint;
BEGIN	
    p_filter_text = LOWER(TRIM(p_filter_text));
	
    total_rows = (
        SELECT COUNT(*)	
        FROM public.enrollments e
		  LEFT JOIN public.""user"" u  ON e.user_id     = u.id
			LEFT JOIN public.""course"" c ON e.course_id  = c.id
			LEFT JOIN public.""user"" u1 ON e.created_by  = u1.id
			LEFT JOIN public.""user"" u2 ON e.modified_by = u2.id
			WHERE e.company_id = p_company_id
			  AND (
					p_filter_text = '' 
					OR LOWER(u.user_name)   LIKE '%' || p_filter_text || '%'
					OR LOWER(c.course_name) LIKE '%' || p_filter_text || '%'
					OR LOWER(e.status)      LIKE '%' || p_filter_text || '%'
				  )
    );  

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_enrollment_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, user_id bigint, user_name text, course_id bigint, course_name text, company_id bigint, enrollment_date timestamp with time zone, end_date timestamp with time zone, paid_amount numeric, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        e.id,
        e.user_id,
        u.user_name,
        e.course_id,
        c.course_name,
        e.company_id,
        e.enrollment_date,
        e.end_date,
		e.paid_amount,
        e.status,
        e.created_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        e.created_at,
        e.modified_by,
        u2.first_name,
        u2.last_name,
        u2.user_name,
        e.modified_at
    FROM public.enrollments e
    LEFT JOIN public.""user"" u  ON e.user_id     = u.id
    LEFT JOIN public.""course"" c ON e.course_id  = c.id
    LEFT JOIN public.""user"" u1 ON e.created_by  = u1.id
    LEFT JOIN public.""user"" u2 ON e.modified_by = u2.id
    WHERE e.company_id = p_company_id
      AND (
            p_filter_text = '' 
            OR LOWER(u.user_name)   LIKE '%' || p_filter_text || '%'
            OR LOWER(c.course_name) LIKE '%' || p_filter_text || '%'
            OR LOWER(e.status)      LIKE '%' || p_filter_text || '%'
          )
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN e.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN e.id END ASC,
        CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'desc' THEN u.user_name END DESC,
        CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'asc' THEN u.user_name END ASC,
        CASE WHEN p_sort_field = 'course_name' AND p_sort_direction = 'desc' THEN c.course_name END DESC,
        CASE WHEN p_sort_field = 'course_name' AND p_sort_direction = 'asc' THEN c.course_name END ASC,
        CASE WHEN p_sort_field = 'enrollment_date' AND p_sort_direction = 'desc' THEN e.enrollment_date END DESC,
        CASE WHEN p_sort_field = 'enrollment_date' AND p_sort_direction = 'asc' THEN e.enrollment_date END ASC,
        CASE WHEN p_sort_field = 'end_date' AND p_sort_direction = 'desc' THEN e.end_date END DESC,
        CASE WHEN p_sort_field = 'end_date' AND p_sort_direction = 'asc' THEN e.end_date END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN e.status END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN e.status END ASC
    LIMIT p_limit
    OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_enrollment_insert(p_company_id bigint, p_user_id bigint, p_course_id bigint, p_enrollment_date timestamp with time zone, p_end_date timestamp with time zone, p_paid_amount numeric, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.enrollments (
        company_id,
        user_id,
        course_id,
        enrollment_date,
        end_date,
		paid_amount,
        status,		
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        p_user_id,
        p_course_id,
       (p_enrollment_date AT TIME ZONE 'Asia/Kolkata'),
       (p_end_date AT TIME ZONE 'Asia/Kolkata'),
		p_paid_amount,
        TRIM(p_status),
        p_created_by,
        COALESCE(p_created_at, now())
    );

    RETURN true;

EXCEPTION 
    WHEN unique_violation THEN
        -- prevent duplicate enrollment error
        RAISE NOTICE 'Enrollment already exists for user % and course %', p_user_id, p_course_id;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_enrollment_update(p_id bigint, p_company_id bigint, p_user_id bigint, p_course_id bigint, p_enrollment_date timestamp with time zone, p_end_date timestamp with time zone, p_paid_amount numeric, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.enrollments
    SET 
        company_id       = p_company_id,
        user_id          = p_user_id,
        course_id        = p_course_id,
        enrollment_date  = (p_enrollment_date AT TIME ZONE 'Asia/Kolkata'),
        end_date         = (p_end_date AT TIME ZONE 'Asia/Kolkata'),
		paid_amount      = p_paid_amount,
        status           = TRIM(p_status),
        modified_by      = p_modified_by,
        modified_at      = COALESCE(p_modified_at, now())
    WHERE id = p_id
      AND company_id = p_company_id;

    IF FOUND THEN
        RETURN true; -- update succeeded
    ELSE
        RAISE NOTICE 'No enrollment found for id % and company_id %', p_id, p_company_id;
        RETURN false;
    END IF;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
   UPDATE public.""event""
   SET status = 'In-active'
   WHERE company_id = p_company_id
     AND id IN (
       SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
     );

   -- Return true to indicate success
   RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_get(p_company_id bigint, p_id bigint)
 RETURNS TABLE(id bigint, event_name text, start_date_time timestamp without time zone, end_date_time timestamp without time zone, currency_id bigint, currency_name text, currency_symbol text, budget numeric, description text, email_template_id bigint, email_template_name text, location_id bigint, location_name text, assigned_to bigint, assigned_to_user_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		e.id,
		e.event_name, 
		e.start_date_time,
		e.end_date_time,
		e.currency_id, 
		c.currency_name, 
		c.currency_symbol,
		e.budget, 
		e.description, 
		e.email_template_id,
		e_t.email_template_name,
		e.location_id,
		l.location_name,
		e.assigned_to, 
		u.user_name,
		e.status,
		e.created_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		e.created_at,
		e.modified_by,
		u2.first_name,
		u2.last_name,
		u2.user_name,
		e.modified_at
	FROM public.""event"" e	
	LEFT JOIN public.""currency"" c ON e.currency_id = c.id
	LEFT JOIN public.""location"" l ON e.location_id = l.id
	LEFT JOIN public.""email_template"" e_t ON e.email_template_id = e_t.id	
	LEFT JOIN public.""user"" u ON e.assigned_to = u.id
	LEFT JOIN public.""user"" u1 ON e.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON e.modified_by = u2.id
	WHERE e.id = p_id
	  AND e.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, title text, start timestamp without time zone, ""end"" timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN	
	RETURN QUERY 	
    SELECT
		e.id,
		e.event_name, 
		e.start_date_time,
		e.end_date_time	
	FROM public.""event"" e
	WHERE e.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_get_by_location_id_count(p_filter_text text, p_location_id bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""event"" e
	WHERE e.location_id = p_location_id AND (LOWER(TRIM(e.event_name)) LIKE '%' || p_filter_text || '%'));  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_get_by_location_id_page(p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_location_id bigint)
 RETURNS TABLE(id bigint, event_name text, start_date_time timestamp without time zone, end_date_time timestamp without time zone, currency_id bigint, currency_name text, currency_symbol text, budget bigint, description text, location_id bigint, location_name text, email_template_id bigint, email_template_name text, assigned_to bigint, assigned_to_user_name text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	e.id,
    e.event_name, 
	e.start_date_time,
	e.end_date_time,
	e.currency_id, 
	c.currency_name,
	c.currency_symbol,
	e.budget, 
	e.description, 
	e.location_id,
	l.location_name,
	e.email_template_id,
	e_t.email_template_name,
	e.assigned_to, 
	u.user_name,
	e.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    e.created_at,
    e.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    e.modified_at
	FROM public.""event"" e	
	LEFT JOIN public.""currency"" c ON e.currency_id = c.id
	LEFT JOIN public.""location"" l ON e.location_id = l.id
	LEFT JOIN public.""email_template"" e_t ON e.email_template_id = e_t.id	
	LEFT JOIN public.""user"" u ON e.assigned_to = u.id
	LEFT JOIN public.""user"" u1 ON e.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON e.modified_by = u2.id
	WHERE e.location_id = p_location_id 
	AND (LOWER(TRIM(e.event_name)) LIKE '%' || p_filter_text || '%')
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN e.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN e.id END ASC,
	CASE WHEN p_sort_field = 'event_name' AND p_sort_direction = 'desc' THEN e.event_name END DESC,
	CASE WHEN p_sort_field = 'event_name' AND p_sort_direction = 'asc' THEN e.event_name END ASC,
	CASE WHEN p_sort_field = 'start_date_time' AND p_sort_direction = 'desc' THEN e.start_date_time END DESC,
	CASE WHEN p_sort_field = 'start_date_time' AND p_sort_direction = 'asc' THEN e.start_date_time END ASC,
	CASE WHEN p_sort_field = 'end_date_time' AND p_sort_direction = 'desc' THEN e.end_date_time END DESC,
	CASE WHEN p_sort_field = 'end_date_time' AND p_sort_direction = 'asc' THEN e.end_date_time END ASC,
	CASE WHEN p_sort_field = 'budget' AND p_sort_direction = 'desc' THEN e.budget END DESC,
	CASE WHEN p_sort_field = 'budget' AND p_sort_direction = 'asc' THEN e.budget END ASC,	
	CASE WHEN p_sort_field = 'location_name' AND p_sort_direction = 'desc' THEN l.location_name END DESC,
	CASE WHEN p_sort_field = 'location_name' AND p_sort_direction = 'asc' THEN l.location_name END ASC,	
	CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'desc' THEN u.user_name END DESC,
	CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'asc' THEN u.user_name END ASC								
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	
	total_rows = (
		SELECT COUNT(*)	
		FROM public.""event"" e
		WHERE e.company_id = p_company_id
		  AND (LOWER(TRIM(e.event_name)) LIKE '%' || p_filter_text || '%')
	);  

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, event_name text, start_date_time timestamp without time zone, end_date_time timestamp without time zone, currency_id bigint, currency_name text, currency_symbol text, budget numeric, description text, location_id bigint, location_name text, email_template_id bigint, email_template_name text, assigned_to bigint, assigned_to_user_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
    SELECT
		e.id,
		e.event_name, 
		e.start_date_time,
		e.end_date_time,
		e.currency_id, 
		c.currency_name,
		c.currency_symbol,
		e.budget, 
		e.description, 
		e.location_id,
		l.location_name,
		e.email_template_id,
		e_t.email_template_name,
		e.assigned_to, 
		u.user_name,
		e.status,
		e.created_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		e.created_at,
		e.modified_by,
		u2.first_name,
		u2.last_name,
		u2.user_name,
		e.modified_at
	FROM public.""event"" e	
	LEFT JOIN public.""currency"" c ON e.currency_id = c.id
	LEFT JOIN public.""location"" l ON e.location_id = l.id
	LEFT JOIN public.""email_template"" e_t ON e.email_template_id = e_t.id	
	LEFT JOIN public.""user"" u ON e.assigned_to = u.id
	LEFT JOIN public.""user"" u1 ON e.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON e.modified_by = u2.id
	WHERE e.company_id = p_company_id
	  AND (LOWER(TRIM(e.event_name)) LIKE '%' || p_filter_text || '%')
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN e.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN e.id END ASC,
		CASE WHEN p_sort_field = 'event_name' AND p_sort_direction = 'desc' THEN e.event_name END DESC,
		CASE WHEN p_sort_field = 'event_name' AND p_sort_direction = 'asc' THEN e.event_name END ASC,
		CASE WHEN p_sort_field = 'start_date_time' AND p_sort_direction = 'desc' THEN e.start_date_time END DESC,
		CASE WHEN p_sort_field = 'start_date_time' AND p_sort_direction = 'asc' THEN e.start_date_time END ASC,
		CASE WHEN p_sort_field = 'end_date_time' AND p_sort_direction = 'desc' THEN e.end_date_time END DESC,
		CASE WHEN p_sort_field = 'end_date_time' AND p_sort_direction = 'asc' THEN e.end_date_time END ASC,
		CASE WHEN p_sort_field = 'budget' AND p_sort_direction = 'desc' THEN e.budget END DESC,
		CASE WHEN p_sort_field = 'budget' AND p_sort_direction = 'asc' THEN e.budget END ASC,	
		CASE WHEN p_sort_field = 'location_name' AND p_sort_direction = 'desc' THEN l.location_name END DESC,
		CASE WHEN p_sort_field = 'location_name' AND p_sort_direction = 'asc' THEN l.location_name END ASC,	
		CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'desc' THEN u.user_name END DESC,
		CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'asc' THEN u.user_name END ASC								
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_insert(p_company_id bigint, p_event_name text, p_start_date_time timestamp without time zone, p_end_date_time timestamp without time zone, p_currency_id bigint, p_budget numeric, p_description text, p_location_id bigint, p_email_template_id bigint, p_assigned_to bigint, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""event"" (
        company_id,
        event_name, 
		start_date_time,
		end_date_time,
		currency_id, 	
		budget, 
		description, 
		location_id,
		email_template_id,	
		assigned_to, 	
		status,
		created_by,
		created_at
    ) VALUES (
        p_company_id,
        TRIM(p_event_name), 
		p_start_date_time,
		p_end_date_time,
		p_currency_id, 	
		p_budget, 
		TRIM(p_description), 
		p_location_id,
		p_email_template_id,	
		p_assigned_to,
		p_status,
		p_created_by,
		p_created_at
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	e.id,
    e.event_name
	FROM public.""event"" e	where company_id=p_company_id
	ORDER BY e.event_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_event_update(p_company_id bigint, p_id bigint, p_event_name text, p_start_date_time timestamp without time zone, p_end_date_time timestamp without time zone, p_currency_id bigint, p_budget numeric, p_description text, p_location_id bigint, p_email_template_id bigint, p_assigned_to bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""event"" SET 
		company_id = p_company_id,
		event_name = p_event_name, 
		start_date_time = p_start_date_time,
		end_date_time = p_end_date_time,
		currency_id = p_currency_id, 	
		budget = p_budget, 
		description = p_description, 
		location_id = p_location_id,
		email_template_id = p_email_template_id,	
		assigned_to = p_assigned_to, 
		status = p_status,
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  UPDATE public.fee_collections
  SET status = 'In-active',
      modified_at = NOW()
  WHERE id IN (
    SELECT id::bigint
    FROM unnest(string_to_array(p_ids, ',')) AS id
  )
  AND company_id = p_company_id;

  RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, payment_date timestamp with time zone, payment_mode text, cheque_number text, payment_type text, fee_amount numeric, remarks text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp with time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    fc.id,
    fc.course_id,
    c.course_name,
    fc.learner_id,
	CONCAT(u2.first_name, ' ', u2.last_name) AS student_name,
    fc.payment_date,
    fc.payment_mode,
    fc.cheque_number,
	fc.payment_type,
    fc.fee_amount,
	fc.remarks,
    fc.status,
    fc.created_by,
    u.first_name AS created_by_first_name,
    u.last_name AS created_by_last_name,
    u.user_name AS created_by_user_name,
    fc.created_at,
    fc.modified_by,
    u1.first_name AS modified_by_first_name,
    u1.last_name AS modified_by_last_name,
    u1.user_name AS modified_by_user_name,
    fc.modified_at
  FROM public.fee_collections fc
  LEFT JOIN public.""course"" c ON fc.course_id = c.id
  LEFT JOIN public.""user"" u2 ON fc.learner_id = u2.id
  LEFT JOIN public.""user"" u ON fc.created_by = u.id
  LEFT JOIN public.""user"" u1 ON fc.modified_by = u1.id
  WHERE fc.id = p_id AND fc.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_get_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_learner_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
  total_rows bigint;
  v_from_date DATE := p_from_date;
  v_to_date DATE := p_to_date;
BEGIN
  p_filter_text = LOWER(TRIM(p_filter_text));

  SELECT COUNT(*) INTO total_rows
  FROM public.fee_collections fc
  LEFT JOIN public.course c ON fc.course_id = c.id
  LEFT JOIN public.""user"" u ON fc.learner_id = u.id
  WHERE fc.company_id = p_company_id
    AND (p_learner_id IS NULL OR fc.learner_id = p_learner_id)
    AND (p_course_id IS NULL OR fc.course_id = p_course_id)
    AND fc.created_at::date BETWEEN v_from_date AND v_to_date
    AND (
      COALESCE(LOWER(TRIM(fc.payment_mode)), '') LIKE '%' || p_filter_text || '%'
	  OR COALESCE(LOWER(TRIM(fc.payment_type)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%'
      OR COALESCE(LOWER(TRIM(fc.cheque_number)), '') LIKE '%' || p_filter_text || '%'
      OR COALESCE(LOWER(TRIM(fc.status)), '') LIKE '%' || p_filter_text || '%'
      OR COALESCE(LOWER(TRIM(c.course_name)), '') LIKE '%' || p_filter_text || '%'
      OR COALESCE(LOWER(TRIM(u.first_name || ' ' || u.last_name)), '') LIKE '%' || p_filter_text || '%'
    );

  RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_get_page(p_company_id bigint, p_filter_text text, p_sort_direction text, p_sort_field text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_learner_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, payment_date timestamp with time zone, payment_mode text, cheque_number text, payment_type text, fee_amount numeric, remarks text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp with time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_from_date DATE := p_from_date;
  v_to_date DATE := p_to_date;
BEGIN
  RETURN QUERY
  SELECT
    fc.id,
    fc.course_id,
    c.course_name,
    fc.learner_id,
    CONCAT(u2.first_name, ' ', u2.last_name) AS student_name,
    fc.payment_date,
    fc.payment_mode,
    fc.cheque_number,
    fc.payment_type,
    fc.fee_amount,
	fc.remarks,
    fc.status,
    fc.created_by,
    u.first_name AS created_by_first_name,
    u.last_name AS created_by_last_name,
    u.user_name AS created_by_user_name,
    fc.created_at,
    fc.modified_by,
    u1.first_name AS modified_by_first_name,
    u1.last_name AS modified_by_last_name,
    u1.user_name AS modified_by_user_name,
    fc.modified_at
  FROM public.fee_collections fc
  LEFT JOIN public.course c ON fc.course_id = c.id
  LEFT JOIN public.""user"" u ON fc.created_by = u.id
  LEFT JOIN public.""user"" u1 ON fc.modified_by = u1.id
  LEFT JOIN public.""user"" u2 ON fc.learner_id = u2.id
  WHERE fc.company_id = p_company_id
    AND (p_learner_id IS NULL OR fc.learner_id = p_learner_id)
    AND (p_course_id IS NULL OR fc.course_id = p_course_id)
    AND fc.created_at::date BETWEEN v_from_date AND v_to_date
    AND (
      COALESCE(LOWER(TRIM(fc.payment_mode)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%' OR
	  COALESCE(LOWER(TRIM(fc.payment_type)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%' OR
      COALESCE(LOWER(TRIM(fc.cheque_number)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%' OR
      COALESCE(LOWER(TRIM(fc.status)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%' OR
      COALESCE(LOWER(TRIM(c.course_name)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%' OR
      COALESCE(LOWER(TRIM(u2.first_name || ' ' || u2.last_name)), '') LIKE '%' || LOWER(TRIM(p_filter_text)) || '%'
    )
  ORDER BY 
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN fc.id END DESC,
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN fc.id END ASC,
    CASE WHEN p_sort_field = 'payment_date' AND p_sort_direction = 'desc' THEN fc.payment_date END DESC,
    CASE WHEN p_sort_field = 'payment_date' AND p_sort_direction = 'asc' THEN fc.payment_date END ASC
  LIMIT p_limit
  OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_insert(p_company_id bigint, p_course_id bigint, p_learner_id bigint, p_payment_date timestamp with time zone, p_payment_mode text, p_cheque_number text, p_payment_type text, p_fee_amount numeric, p_remarks text, p_status text, p_created_by bigint, p_created_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_payment_id bigint;
    v_receipt_number text;
BEGIN
  -- Insert into fee_collections table
  INSERT INTO fee_collections (
    company_id,
    course_id,
    learner_id,
    payment_date,
    payment_mode,
    cheque_number,
    payment_type,
    fee_amount,
    remarks,
    status,
    created_by,
    created_at
  )
  VALUES (
    p_company_id,
    p_course_id,
    p_learner_id,
    p_payment_date,
    p_payment_mode,
    p_cheque_number,
    p_payment_type,
    p_fee_amount,
    p_remarks,
    p_status,
    p_created_by,
    p_created_at
  )
  RETURNING id INTO v_payment_id;

  -- Generate receipt number (example: ""REC"" + payment_id padded)
  v_receipt_number := 'REC' || LPAD(v_payment_id::text, 8, '0');

  -- Insert into pay_receipt table with reference to fee_collections (payment_id)
  INSERT INTO pay_receipt (
    company_id,
    payment_id,
    learner_id,
    course_id,
    receipt_number,
    amount_paid,
    payment_mode,
    payment_date,
    generated_by,
    created_by,
    created_at
  )
  VALUES (
    p_company_id,
    v_payment_id,
    p_learner_id,
    p_course_id,
    v_receipt_number,
    p_fee_amount,
    p_payment_mode,
    p_payment_date,
    p_created_by,
    p_created_by,
    p_created_at
  );

  RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_insert_bak(p_company_id bigint, p_course_id bigint, p_learner_id bigint, p_payment_date timestamp with time zone, p_payment_mode text, p_cheque_number text, p_payment_type text, p_fee_amount numeric, p_remarks text, p_status text, p_created_by bigint, p_created_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  INSERT INTO fee_collections (
    company_id,
    course_id,
    learner_id,
    payment_date,
    payment_mode,
    cheque_number,
	payment_type,
    fee_amount,
	remarks,
    status,
    created_by,
    created_at
  )
  VALUES (
    p_company_id,
    p_course_id,
    p_learner_id,
    p_payment_date,
    p_payment_mode,
    p_cheque_number,
	p_payment_type,
    p_fee_amount,
	p_remarks,
    p_status,
    p_created_by,
    p_created_at
  );
  RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_collection_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_learner_id bigint, p_payment_date timestamp with time zone, p_payment_mode text, p_cheque_number text, p_payment_type text, p_fee_amount numeric, p_remarks text, p_status text, p_modified_by bigint, p_modified_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  UPDATE fee_collections
  SET
    course_id = p_course_id,
    learner_id = p_learner_id,
    payment_date = p_payment_date,
    payment_mode = p_payment_mode,
    cheque_number = p_cheque_number,
	payment_type = p_payment_type,
    fee_amount = p_fee_amount,
	remarks = p_remarks,
    status = p_status,
    modified_by = p_modified_by,
    modified_at = p_modified_at
  WHERE id = p_id AND company_id = p_company_id;

  RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_payment_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, payment_id bigint, admission_id bigint, student_name text, course_id bigint, course_name text, frequency text, amount numeric, payment_date timestamp without time zone, transaction_id bigint, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
    fp.id,
    fp.payment_id,
    fp.admission_id,
    fp.student_name,
    fp.course_id,
    c.course_name,
    fp.frequency,
    fp.amount,
    fp.payment_date,
    fp.transaction_id,
	fp.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    fp.created_at,
    fp.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    fp.modified_at
	FROM public.""fee_payment"" fp
	LEFT JOIN public.""payment"" p ON fp.payment_id = p.id
	LEFT JOIN public.""admission"" a ON fp.payment_id = a.id
	LEFT JOIN public.""course"" c ON fp.course_id = c.id
	LEFT JOIN public.""user"" u ON fp.created_by = u.id
	LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
	WHERE fp.id = p_id AND fp.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_payment_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""fee_payment"" fp
    LEFT JOIN public.""course"" c ON fp.course_id = c.id
	WHERE (LOWER(TRIM(fp.frequency)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%')
	AND fp.company_id = p_company_id );  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_payment_get_page(p_user_id bigint, p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_selected_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, payment_id bigint, admission_id bigint, student_name text, course_id bigint, course_name text, frequency text, amount numeric, payment_date timestamp without time zone, transaction_id bigint, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
    fp.id,
    fp.payment_id,
    fp.admission_id,
    CONCAT(a.first_name, ' ', a.last_name) AS student_name,
    fp.course_id,
    c.course_name,
    fp.frequency,
    fp.amount,
    fp.payment_date,
    fp.transaction_id,
	fp.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    fp.created_at,
    fp.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    fp.modified_at	
	FROM public.""fee_payment"" fp
	LEFT JOIN public.""payment"" p ON fp.payment_id = p.id
	LEFT JOIN public.""admission"" a ON fp.admission_id = a.id
	LEFT JOIN public.""course"" c ON fp.course_id = c.id
	LEFT JOIN public.""user"" u ON fp.created_by = u.id
	LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
	WHERE  fp.company_id = p_company_id
	  AND (p_user_id IS NULL OR fp.user_id = u.id)
	  AND fp.payment_date::date BETWEEN v_from_date AND v_to_date
	  AND (LOWER(TRIM(fp.frequency)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
		  ) 
	--AND fp.company_id = p_company_id-- AND u.id=p_user_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN fp.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN fp.id END ASC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'desc' THEN fp.frequency END DESC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'asc' THEN fp.frequency END ASC
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_payment_insert(p_company_id bigint, p_user_id bigint, p_frequency text, p_course_id bigint, p_amount numeric, p_discount numeric, p_fine_amount numeric, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""fee_payment"" (
	    company_id,
		user_id,
        frequency,
        course_id,
        amount,
        discount,
        fine_amount,
		status,
		payment_date,	
		created_by,
		created_at		
    ) VALUES (
	    p_company_id,
		p_user_id,
        TRIM(p_frequency),
		p_course_id,
        p_amount,
        p_discount,
        p_fine_amount,
		p_status,
		p_created_at,
		p_created_by,
		p_created_at	
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_payment_review_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, payment_id bigint, admission_id bigint, student_name text, course_id bigint, course_name text, frequency text, amount numeric, payment_date timestamp without time zone, transaction_id bigint, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_from_date DATE := p_from_date;
	v_to_date DATE := p_to_date;
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
    fp.id,
    fp.payment_id,
    fp.admission_id,
    CONCAT(a.first_name, ' ', a.last_name) AS student_name,
    fp.course_id,
    c.course_name,
    fp.frequency,
    fp.amount,
    fp.payment_date,
    fp.transaction_id,
	fp.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    fp.created_at,
    fp.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    fp.modified_at	
	FROM public.""fee_payment"" fp
	LEFT JOIN public.""payment"" p ON fp.payment_id = p.id
	LEFT JOIN public.""admission"" a ON fp.admission_id = a.id
	LEFT JOIN public.""course"" c ON fp.course_id = c.id
	LEFT JOIN public.""user"" u ON fp.created_by = u.id
	LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
	WHERE fp.company_id = p_company_id
	  AND (p_user_id IS NULL OR fp.user_id = u.id)
	  AND (p_course_id IS NULL OR fp.course_id = p_course_id)
	  AND fp.payment_date::date BETWEEN v_from_date AND v_to_date
	  AND (LOWER(TRIM(fp.frequency)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%') 
	--AND fp.company_id = p_company_id-- AND u.id=p_user_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN fp.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN fp.id END ASC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'desc' THEN fp.frequency END DESC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'asc' THEN fp.frequency END ASC
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_payment_update(p_id bigint, p_payment_id bigint, p_assignment_id bigint, p_admission_id bigint, p_student_name text, p_course_id bigint, p_frequency text, p_amount numeric, p_payment_date timestamp without time zone, p_method text, p_transaction_id bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""fee_payment"" SET 
	company_id = p_company_id,
	payment_id = p_payment_id,
	admission_id = p_admission_id,
	assignment_id = p_assignment_id,
	student_name = p_student_name, 
	course_id = p_course_id,
	frequency = TRIM(p_frequency),
	amount = p_amount, 
	payment_date = p_payment_date,
	method = p_method,
	transaction_id = p_transaction_id,
	status = p_status,	
	is_paid =p_is_paid,
	modified_by = p_modified_by,
	modified_at = p_modified_at	
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_breakup_get(p_learner_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, payment_frequency text, fee_cycle_code text, fee_year integer, fee_amount numeric, is_paid boolean, paid_on date, payment_mode text, receipt_number text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        fb.id,
        fb.course_id,
        c.course_name,
		fp.learner_id,
		CONCAT(u2.first_name, ' ', u2.last_name) AS student_name,
        fp.payment_frequency,
        fb.fee_cycle_code,
        fb.fee_year,
        fb.amount as fee_amount,
        fb.is_paid,
        fb.paid_on,
        fb.payment_mode,
        fb.receipt_number,
        fb.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        fb.created_at,
        fb.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        fb.modified_at
    FROM public.student_fees_breakup fb
	JOIN public.""student_fee_plan"" fp ON fb.fee_plan_id = fp.id
    JOIN public.course c ON fb.course_id = c.id
	LEFT JOIN public.""user"" u2 ON fp.learner_id = u2.id
	LEFT JOIN public.""user"" u ON fb.created_by = u.id
    LEFT JOIN public.""user"" u1 ON fb.modified_by = u1.id
    WHERE 
        fp.learner_id = p_learner_id
        AND fb.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""student_fee_plan""
	SET status = 'In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, payment_frequency text, start_date text, discount numeric, fine_amount numeric, total_amount numeric, net_amount numeric, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        fp.id,
        fp.course_id,
        c.course_name,
        fp.learner_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
		fp.payment_frequency,
        fp.start_date,
        fp.discount,
        fp.fine_amount,
        fp.total_amount,
		fp.net_amount,
        fp.status,
        fp.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        fp.created_at,
        fp.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        fp.modified_at
    FROM public.""student_fee_plan"" fp
    LEFT JOIN public.""course"" c ON fp.course_id = c.id
    LEFT JOIN public.""user"" u ON fp.created_by = u.id
    LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
    LEFT JOIN public.""user"" s ON fp.learner_id = s.id
    WHERE fp.company_id = p_company_id
      AND fp.id = p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_get_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
    v_from_date DATE := p_from_date;
    v_to_date DATE := p_to_date;
BEGIN
    p_filter_text = LOWER(TRIM(p_filter_text));

    SELECT COUNT(*) INTO total_rows
    FROM public.""student_fee_plan"" fp
    LEFT JOIN public.""course"" c ON fp.course_id = c.id
    LEFT JOIN public.""user"" s ON fp.learner_id = s.id
    WHERE fp.company_id = p_company_id
      AND (p_user_id IS NULL OR fp.learner_id = p_user_id)
      AND (p_course_id IS NULL OR fp.course_id = p_course_id)
      AND fp.created_at::date BETWEEN v_from_date AND v_to_date
      AND (
	      LOWER(TRIM(fp.payment_frequency)) LIKE '%' || p_filter_text || '%'
          OR LOWER(TRIM(fp.start_date)) LIKE '%' || p_filter_text || '%'
          OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
          OR LOWER(TRIM(s.first_name || ' ' || s.last_name)) LIKE '%' || p_filter_text || '%'
      );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_insert(p_company_id bigint, p_user_id bigint, p_payment_frequency text, p_start_date text, p_course_id bigint, p_total_amount numeric, p_net_amount numeric, p_discount numeric, p_fine_amount numeric, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_fee_plan_id bigint;
    v_fee_amount numeric(10,2);
    v_fee_year integer;
    v_fee_cycle_code text;
    v_cycle_date date;
    i integer;
    start_month integer;
    month_index integer;
BEGIN
    -- Insert fee plan
    INSERT INTO public.student_fee_plan (
        company_id,
        learner_id,
        payment_frequency,
        start_date,
        course_id,
        total_amount,
        net_amount,
        discount,
        fine_amount,
        status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        p_user_id,
        TRIM(p_payment_frequency),
        TRIM(p_start_date),
        p_course_id,
        p_total_amount,
        p_net_amount,
        p_discount,
        p_fine_amount,
        p_status,
        p_created_by,
        p_created_at
    )
    RETURNING id INTO v_fee_plan_id;

    -- Handle Monthly Payment
    IF LOWER(p_payment_frequency) = 'monthly' THEN
        -- Convert month name to month number
        start_month := TO_CHAR(TO_DATE(p_start_date, 'Mon'), 'MM')::int;

        FOR i IN 0..11 LOOP
            month_index := ((start_month - 1 + i) % 12) + 1;

            -- Stop if we reach April again (start of new FY)
            IF month_index = 4 AND i != 0 THEN
                EXIT;
            END IF;

            -- Construct cycle date
            v_cycle_date := MAKE_DATE(EXTRACT(YEAR FROM p_created_at)::int, start_month, 1) + INTERVAL '1 month' * i;

            -- Determine correct financial year
            IF EXTRACT(MONTH FROM v_cycle_date) < 4 THEN
                v_fee_year := EXTRACT(YEAR FROM v_cycle_date) + 1;
            ELSE
                v_fee_year := EXTRACT(YEAR FROM v_cycle_date);
            END IF;

            v_fee_cycle_code := TO_CHAR(v_cycle_date, 'Mon');
            v_fee_amount := ROUND(p_net_amount / (12 - (start_month - 1)), 2);

            INSERT INTO public.student_fees_breakup (
                company_id, admission_id, course_id, fee_plan_id,
                fee_year, fee_cycle_code, fee_component, amount,
                is_paid, paid_on, payment_mode, receipt_number,
                created_by, created_at, modified_by, modified_at
            ) VALUES (
                p_company_id, p_user_id, p_course_id, v_fee_plan_id,
                v_fee_year, v_fee_cycle_code, 'Tuition Fee', v_fee_amount,
                false, NULL, NULL, NULL,
                p_created_by, p_created_at, NULL, NULL
            );
        END LOOP;

    -- Handle Quarterly Payment
    ELSIF LOWER(p_payment_frequency) = 'quarterly' THEN
        DECLARE
            quarter_start int;
            quarter_dates date[];
        BEGIN
            -- Map p_start_date (Q1, Q2, ...) to starting quarter
            CASE UPPER(p_start_date)
                WHEN 'Q1' THEN quarter_start := 1;
                WHEN 'Q2' THEN quarter_start := 2;
                WHEN 'Q3' THEN quarter_start := 3;
                WHEN 'Q4' THEN quarter_start := 4;
                ELSE
                    RAISE EXCEPTION 'Invalid quarterly start date: %', p_start_date;
            END CASE;

            -- Define quarter start dates
            quarter_dates := ARRAY[
                MAKE_DATE(EXTRACT(YEAR FROM p_created_at)::int, 4, 1),  -- Q1: Apr
                MAKE_DATE(EXTRACT(YEAR FROM p_created_at)::int, 7, 1),  -- Q2: Jul
                MAKE_DATE(EXTRACT(YEAR FROM p_created_at)::int, 10, 1), -- Q3: Oct
                MAKE_DATE(EXTRACT(YEAR FROM p_created_at)::int + 1, 1, 1) -- Q4: Jan next year
            ];

            FOR i IN quarter_start..4 LOOP
                v_cycle_date := quarter_dates[i];

                IF i = 4 THEN
                    v_fee_year := EXTRACT(YEAR FROM v_cycle_date); -- Q4 → Jan–Mar → same year
                ELSE
                    v_fee_year := EXTRACT(YEAR FROM v_cycle_date);
                END IF;

                v_fee_cycle_code := 'Q' || i;
                v_fee_amount := ROUND(p_net_amount / (5 - quarter_start), 2); -- Adjusted for remaining quarters

                INSERT INTO public.student_fees_breakup (
                    company_id, admission_id, course_id, fee_plan_id,
                    fee_year, fee_cycle_code, fee_component, amount,
                    is_paid, paid_on, payment_mode, receipt_number,
                    created_by, created_at, modified_by, modified_at
                ) VALUES (
                    p_company_id, p_user_id, p_course_id, v_fee_plan_id,
                    v_fee_year, v_fee_cycle_code, 'Tuition Fee', v_fee_amount,
                    false, NULL, NULL, NULL,
                    p_created_by, p_created_at, NULL, NULL
                );
            END LOOP;
        END;

    -- Handle Yearly Payment
    ELSIF LOWER(p_payment_frequency) = 'yearly' THEN
        v_cycle_date := MAKE_DATE(EXTRACT(YEAR FROM p_created_at)::int, 4, 1);  -- Apr 1
        v_fee_cycle_code := 'Year';
        v_fee_year := EXTRACT(YEAR FROM v_cycle_date);
        v_fee_amount := p_net_amount;

        INSERT INTO public.student_fees_breakup (
            company_id, admission_id, course_id, fee_plan_id,
            fee_year, fee_cycle_code, fee_component, amount,
            is_paid, paid_on, payment_mode, receipt_number,
            created_by, created_at
        ) VALUES (
            p_company_id, p_user_id, p_course_id, v_fee_plan_id,
            v_fee_year, v_fee_cycle_code, 'Tuition Fee', v_fee_amount,
            false, NULL, NULL, NULL,
            p_created_by, p_created_at
        );

    ELSE
        RAISE EXCEPTION 'Invalid payment frequency: %', p_payment_frequency;
    END IF;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_review_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, payment_frequency text, start_date text, discount numeric, fine_amount numeric, total_amount numeric, net_amount numeric, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_from_date DATE := p_from_date;
    v_to_date DATE := p_to_date;
BEGIN
    p_filter_text = LOWER(TRIM(p_filter_text));
    p_sort_field = LOWER(TRIM(p_sort_field));
    p_sort_direction = LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        fp.id,
        fp.course_id,
        c.course_name,
        fp.learner_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
		fp.payment_frequency,
        fp.start_date,
        fp.discount,
        fp.fine_amount,
        fp.total_amount,
		fp.net_amount,
        fp.status,
        fp.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        fp.created_at,
        fp.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        fp.modified_at
    FROM public.""student_fee_plan"" fp
    LEFT JOIN public.""course"" c ON fp.course_id = c.id
    LEFT JOIN public.""user"" u ON fp.created_by = u.id
    LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
    LEFT JOIN public.""user"" s ON fp.learner_id = s.id
    WHERE fp.company_id = p_company_id
      AND (p_user_id IS NULL OR fp.learner_id = p_user_id)
      AND (p_course_id IS NULL OR fp.course_id = p_course_id)
      AND fp.created_at::date BETWEEN v_from_date AND v_to_date
      AND (
	      LOWER(TRIM(fp.payment_frequency)) LIKE '%' || p_filter_text || '%'
          OR LOWER(TRIM(fp.start_date)) LIKE '%' || p_filter_text || '%'
          OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
          OR LOWER(TRIM(s.first_name || ' ' || s.last_name)) LIKE '%' || p_filter_text || '%'
      )
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN fp.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN fp.id END ASC,
        CASE WHEN p_sort_field = 'start_date' AND p_sort_direction = 'desc' THEN fp.start_date END DESC,
        CASE WHEN p_sort_field = 'start_date' AND p_sort_direction = 'asc' THEN fp.start_date END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_fee_plan_update(p_id bigint, p_company_id bigint, p_learner_id bigint, p_payment_frequency text, p_start_date text, p_course_id bigint, p_total_amount numeric, p_net_amount numeric, p_discount numeric, p_fine_amount numeric, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""student_fee_plan""
    SET
        company_id = p_company_id,
        learner_id = p_learner_id,
		payment_frequency = TRIM(p_payment_frequency),
        start_date = TRIM(p_start_date),
        course_id = p_course_id,
        total_amount = p_total_amount,
		net_amount = p_net_amount,
        discount = p_discount,
        fine_amount = p_fine_amount,
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id and company_id=p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_group_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, group_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        g.id,
        g.group_name,
        g.status,
        g.created_by,
        u.first_name,
        u.last_name,
        u.user_name,
        g.created_at,
        g.modified_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        g.modified_at
    FROM public.""group"" g
    LEFT JOIN public.""user"" u ON g.created_by = u.id
    LEFT JOIN public.""user"" u1 ON g.modified_by = u1.id
    WHERE g.id = p_id ;
      --AND g.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_group_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint;
BEGIN    
    p_filter_text := LOWER(TRIM(p_filter_text));
    
    total_rows := (
        SELECT COUNT(*)    
        FROM public.""group"" g
        WHERE --g.company_id = p_company_id  AND 
         (
              LOWER(TRIM(g.group_name)) LIKE '%' || p_filter_text || '%'
          )
    );  

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_group_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, group_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        g.id,
        g.group_name,
        g.status,
        g.created_by,
        u.first_name,
        u.last_name,
        u.user_name,
        g.created_at,
        g.modified_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        g.modified_at
    FROM public.""group"" g
    LEFT JOIN public.""user"" u ON g.created_by = u.id
    LEFT JOIN public.""user"" u1 ON g.modified_by = u1.id
    WHERE --g.company_id = p_company_id AND
       (
            LOWER(TRIM(g.group_name)) LIKE '%' || p_filter_text || '%'
         )
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN g.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN g.id END ASC,
        CASE WHEN p_sort_field = 'group_name' AND p_sort_direction = 'desc' THEN g.group_name END DESC,
        CASE WHEN p_sort_field = 'group_name' AND p_sort_direction = 'asc' THEN g.group_name END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN g.status END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN g.status END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_group_insert(p_company_id bigint, p_group_name text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.""group"" (
        company_id,
        group_name,
        status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        TRIM(p_group_name),
        p_status,
        p_created_by,
        p_created_at
    );

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_group_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		g.id,
        g.group_name
	FROM public.""group"" g
	WHERE status='Active' --AND g.company_id = p_company_id
	ORDER BY g.group_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_group_update(p_id bigint, p_company_id bigint, p_group_name text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""group""
    SET
        company_id = p_company_id,
        group_name = TRIM(p_group_name),
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_is_valid_json(input text)
 RETURNS boolean
 LANGUAGE plpgsql
 IMMUTABLE
AS $function$
BEGIN
    PERFORM input::jsonb;
    RETURN true;
EXCEPTION WHEN others THEN
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_last_admission_id_get(p_company_id bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    max_id bigint;
    v_company_type text;
BEGIN
    -- Get company_type first
    SELECT company_type INTO v_company_type
    FROM company
    WHERE id = p_company_id;

    -- Use correct table depending on company_type
    IF v_company_type = 'School' THEN
        SELECT COALESCE(MAX(id), 0)
        INTO max_id
        FROM public.admission_form
        WHERE company_id = p_company_id;
    ELSE
        SELECT COALESCE(MAX(id), 0)
        INTO max_id
        FROM public.admission
        WHERE company_id = p_company_id;
    END IF;

    RETURN max_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""location""
    SET status = 'In-active'
    WHERE id IN (
            SELECT id::bigint 
            FROM unnest(string_to_array(p_ids, ',')) AS id
        )
      AND company_id = p_company_id
      AND status = 'Active';

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_get(p_company_id bigint, p_id bigint)
 RETURNS TABLE(id bigint, location_name text, description text, capacity bigint, address text, city_name text, state_id bigint, state_code text, state_name text, country_id bigint, country_name text, zip_code text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        l.id,
        l.location_name,
        l.description,
        l.capacity,
        l.address,
        l.city_name,
        l.state_id,
        s.state_code,
        s.state_name,
        l.country_id,
        c.country_name,
        l.zip_code,
		l.status,
        l.created_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        l.created_at,
        l.modified_by,
        u2.first_name,
        u2.last_name,
        u2.user_name,
        l.modified_at
    FROM public.""location"" l
    LEFT JOIN public.""state"" s ON l.state_id = s.id
    LEFT JOIN public.""country"" c ON l.country_id = c.id
    LEFT JOIN public.""user"" u1 ON l.created_by = u1.id
    LEFT JOIN public.""user"" u2 ON l.modified_by = u2.id
    WHERE l.id = p_id
      AND l.company_id = p_company_id;
    
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));

    total_rows := (
        SELECT COUNT(*)
        FROM public.""location"" l
        WHERE l.company_id = p_company_id
          AND l.status = 'Active'
          AND (
              p_filter_text = '' 
              OR LOWER(TRIM(l.location_name)) LIKE '%' || p_filter_text || '%'
          )
    );  

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, location_name text, description text, capacity bigint, address text, city_name text, state_id bigint, state_code text, state_name text, country_id bigint, country_name text, zip_code text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));

    RETURN QUERY 	
    SELECT
        l.id,
        l.location_name,
        l.description,
        l.capacity,	
        l.address,
        l.city_name,
        l.state_id,
        s.state_code,
        s.state_name,
        l.country_id,
        c.country_name,
        l.zip_code, 
		l.status,
        l.created_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        l.created_at,
        l.modified_by,
        u2.first_name,
        u2.last_name,
        u2.user_name,
        l.modified_at
    FROM public.""location"" l
    LEFT JOIN public.""state"" s ON l.state_id = s.id
    LEFT JOIN public.""country"" c ON l.country_id = c.id	
    LEFT JOIN public.""user"" u1 ON l.created_by = u1.id
    LEFT JOIN public.""user"" u2 ON l.modified_by = u2.id
    WHERE l.company_id = p_company_id      
      AND (p_filter_text = '' OR LOWER(TRIM(l.location_name)) LIKE '%' || p_filter_text || '%')
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN l.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN l.id END ASC,
        CASE WHEN p_sort_field = 'location_name' AND p_sort_direction = 'desc' THEN l.location_name END DESC,
        CASE WHEN p_sort_field = 'location_name' AND p_sort_direction = 'asc' THEN l.location_name END ASC	
    LIMIT p_limit
    OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_insert(p_company_id bigint, p_location_name text, p_description text, p_capacity bigint, p_address text, p_city_name text, p_state_id bigint, p_country_id bigint, p_zip_code text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""location"" (
        company_id,
        location_name,
        description,
        capacity,	
        address,
        city_name,
        state_id,	
        country_id,	
        zip_code,
		status,
        created_by,	
        created_at
    ) VALUES (
        p_company_id,
        TRIM(p_location_name),
        TRIM(p_description),
        p_capacity,	
        TRIM(p_address),
        TRIM(p_city_name),
        p_state_id,	
        p_country_id,	
        TRIM(p_zip_code),
		p_status,
        p_created_by,	
        p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 	
    SELECT
        l.id,
        l.location_name
    FROM public.""location"" l	
    WHERE l.company_id = p_company_id
      AND l.status = 'Active'
    ORDER BY l.location_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_location_update(p_company_id bigint, p_id bigint, p_location_name text, p_description text, p_capacity bigint, p_address text, p_city_name text, p_state_id bigint, p_country_id bigint, p_zip_code text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""location"" 
    SET 
        location_name = TRIM(p_location_name),
        description = TRIM(p_description),
        capacity = p_capacity,	
        address = TRIM(p_address),
        city_name = TRIM(p_city_name),
        state_id = p_state_id,	
        country_id = p_country_id,	
        zip_code = TRIM(p_zip_code), 
        status = TRIM(p_status),  
        modified_by = p_modified_by,	
        modified_at = p_modified_at
    WHERE id = p_id 
      AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_log_unauthorized_device(p_user_id bigint, p_company_id bigint, p_device_id text, p_device_info text, p_ip_address text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    BEGIN
        INSERT INTO public.logs (
            user_id,
            company_id,
            device_id,
            device_info,
            ip_address,
            created_by,
            created_at
        ) VALUES (
            p_user_id,
            p_company_id,
            TRIM(p_device_id),
            TRIM(p_device_info),
            TRIM(p_ip_address),
            p_created_by,
            COALESCE(p_created_at, now())
        );
    EXCEPTION WHEN OTHERS THEN
        -- avoid breaking main function
        RAISE NOTICE 'Logging failed: %', SQLERRM;
    END;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    DELETE 
	FROM public.""meeting""
	WHERE company_id=p_company_id AND id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id);

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, subject text, start_date_time timestamp without time zone, end_date_time timestamp without time zone, location_id bigint, location_name text, reminder text, description text, parent_type text, parent_type_id bigint, parent_type_name text, assigned_to bigint, assigned_to_user_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	m.id,
    m.subject,
    m.start_date_time,
    m.end_date_time,
    m.location_id,
	l.location_name,
    m.reminder,
    m.description,
    m.parent_type,
    m.parent_type_id,
	CASE WHEN m.parent_type = 'Account' THEN a.account_name 
	WHEN m.parent_type = 'Contact' THEN c.first_name || ' ' || c.last_name
	WHEN m.parent_type = 'Opportunity' THEN o.opportunity_name
	WHEN m.parent_type = 'Lead' THEN l1.first_name || ' ' || l1.last_name
	END parent_type_name,    
    m.assigned_to,
	u.user_name,
	m.status,
	m.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    m.created_at,
    m.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    m.modified_at
	FROM public.""meeting"" m
	LEFT JOIN public.""location"" l ON m.location_id = l.id
	LEFT JOIN public.""account"" a ON m.parent_type_id = a.id AND m.parent_type = 'Account'	
	LEFT JOIN public.""contact"" c ON m.parent_type_id = c.id AND m.parent_type = 'Contact'
	LEFT JOIN public.""opportunity"" o ON m.parent_type_id = o.id AND m.parent_type = 'Opportunity'
	LEFT JOIN public.""lead"" l1 ON m.parent_type_id = l1.id AND m.parent_type = 'Lead'
	LEFT JOIN public.""user"" u ON m.assigned_to = u.id
	LEFT JOIN public.""user"" u1 ON m.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON m.modified_by = u2.id
	WHERE m.id = p_id AND m.company_id=p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, title text, start timestamp without time zone, ""end"" timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN	
	RETURN QUERY 	
    SELECT
	m.id,
    m.subject, 
	m.start_date_time,
	m.end_date_time	
	FROM public.""meeting"" m
	WHERE company_id=p_company_id;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (
	SELECT COUNT(*) FROM 
	(SELECT
	m.id,
    m.subject,
    m.start_date_time,
    m.end_date_time,
    m.location_id,
	l.location_name,
    m.reminder,
    m.description,
    m.parent_type,
    m.parent_type_id,
	CASE WHEN m.parent_type = 'Account' THEN a.account_name 
	WHEN m.parent_type = 'Contact' THEN c1.first_name || ' ' || c1.last_name
	WHEN m.parent_type = 'Opportunity' THEN o.opportunity_name
	WHEN m.parent_type = 'Lead' THEN l1.first_name || ' ' || l1.last_name
	END parent_type_name,    
    m.assigned_to,
	u.user_name assigned_to_user_name,
	m.status,
	m.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    m.created_at,
    m.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    m.modified_at
	FROM public.""meeting"" m
	LEFT JOIN public.""location"" l ON m.location_id = l.id
	LEFT JOIN public.""account"" a ON m.parent_type_id = a.id AND m.parent_type = 'Account'		
	LEFT JOIN public.""contact"" c1 ON m.parent_type_id = c1.id AND m.parent_type = 'Contact'
	LEFT JOIN public.""opportunity"" o ON m.parent_type_id = o.id AND m.parent_type = 'Opportunity'
	LEFT JOIN public.""lead"" l1 ON m.parent_type_id = l1.id AND m.parent_type = 'Lead'
	LEFT JOIN public.""user"" u ON m.assigned_to = u.id
	LEFT JOIN public.""user"" u1 ON m.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON m.modified_by = u2.id	
	) t1
	WHERE m.company_id=p_company_id AND (LOWER(TRIM(t1.subject)) LIKE '%' || p_filter_text || '%')
	OR (LOWER(TRIM(t1.parent_type)) LIKE '%' || p_filter_text || '%')
	OR (LOWER(TRIM(t1.parent_type_name)) LIKE '%' || p_filter_text || '%')
	OR (LOWER(TRIM(t1.assigned_to_user_name)) LIKE '%' || p_filter_text || '%')
	);  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, subject text, start_date_time timestamp without time zone, end_date_time timestamp without time zone, location_id bigint, location_name text, reminder text, description text, parent_type text, parent_type_id bigint, parent_type_name text, assigned_to bigint, assigned_to_user_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text := LOWER(TRIM(p_filter_text));
	p_sort_field := LOWER(TRIM(p_sort_field));
	p_sort_direction := LOWER(TRIM(p_sort_direction));

	RETURN QUERY
	SELECT * FROM (
		SELECT
			m.id,
			m.subject,
			m.start_date_time,
			m.end_date_time,
			m.location_id,
			l.location_name,
			m.reminder,
			m.description,
			m.parent_type,
			m.parent_type_id,
			'' AS parent_type_name,
			m.assigned_to,
			u.user_name AS assigned_to_user_name,
			m.status,
			m.created_by,
			u1.first_name AS created_by_first_name,
			u1.last_name AS created_by_last_name,
			u1.user_name AS created_by_user_name,
			m.created_at,
			m.modified_by,
			u2.first_name AS modified_by_first_name,
			u2.last_name AS modified_by_last_name,
			u2.user_name AS modified_by_user_name,
			m.modified_at,
			m.company_id -- ✅ Needed for filtering in outer WHERE
		FROM public.""meeting"" m
		LEFT JOIN public.""location"" l ON m.location_id = l.id
		LEFT JOIN public.""user"" u ON m.assigned_to = u.id
		LEFT JOIN public.""user"" u1 ON m.created_by = u1.id
		LEFT JOIN public.""user"" u2 ON m.modified_by = u2.id
	) t1
	WHERE t1.company_id = p_company_id
	  AND (
		LOWER(TRIM(t1.subject)) LIKE '%' || p_filter_text || '%'
		OR LOWER(TRIM(t1.parent_type)) LIKE '%' || p_filter_text || '%'
		OR LOWER(TRIM(t1.parent_type_name)) LIKE '%' || p_filter_text || '%'
		OR LOWER(TRIM(t1.assigned_to_user_name)) LIKE '%' || p_filter_text || '%'
	  )
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN t1.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN t1.id END ASC,
		CASE WHEN p_sort_field = 'subject' AND p_sort_direction = 'desc' THEN t1.subject END DESC,
		CASE WHEN p_sort_field = 'subject' AND p_sort_direction = 'asc' THEN t1.subject END ASC,
		CASE WHEN p_sort_field = 'parent_type' AND p_sort_direction = 'desc' THEN t1.parent_type END DESC,
		CASE WHEN p_sort_field = 'parent_type' AND p_sort_direction = 'asc' THEN t1.parent_type END ASC,
		CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'desc' THEN t1.assigned_to_user_name END DESC,
		CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'asc' THEN t1.assigned_to_user_name END ASC
	LIMIT p_limit
	OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_get_page_b(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, subject text, start_date_time timestamp without time zone, end_date_time timestamp without time zone, location_id bigint, location_name text, reminder text, description text, parent_type text, parent_type_id bigint, parent_type_name text, assigned_to bigint, assigned_to_user_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT * FROM (
	SELECT
	m.id,
    m.subject,
    m.start_date_time,
    m.end_date_time,
    m.location_id,
	l.location_name,
    m.reminder,
    m.description,
    m.parent_type,
    m.parent_type_id,
	CASE WHEN m.parent_type = 'Account' THEN a.account_name 
	WHEN m.parent_type = 'Contact' THEN c1.first_name || ' ' || c1.last_name
	WHEN m.parent_type = 'Opportunity' THEN o.opportunity_name
	WHEN m.parent_type = 'Lead' THEN l1.first_name || ' ' || l1.last_name
	END parent_type_name,    
    m.assigned_to,
	u.user_name assigned_to_user_name,
	m.status,
	m.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    m.created_at,
    m.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    m.modified_at
	FROM public.""meeting"" m
	LEFT JOIN public.""location"" l ON m.location_id = l.id
	LEFT JOIN public.""account"" a ON m.parent_type_id = a.id AND m.parent_type = 'Account'		
	LEFT JOIN public.""contact"" c1 ON m.parent_type_id = c1.id AND m.parent_type = 'Contact'
	LEFT JOIN public.""opportunity"" o ON m.parent_type_id = o.id AND m.parent_type = 'Opportunity'
	LEFT JOIN public.""lead"" l1 ON m.parent_type_id = l1.id AND m.parent_type = 'Lead'
	LEFT JOIN public.""user"" u ON m.assigned_to = u.id
	LEFT JOIN public.""user"" u1 ON m.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON m.modified_by = u2.id		
	) t1
	WHERE m.company_id=p_company_id AND (LOWER(TRIM(t1.subject)) LIKE '%' || p_filter_text || '%')
	OR (LOWER(TRIM(t1.parent_type)) LIKE '%' || p_filter_text || '%')
	OR (LOWER(TRIM(t1.parent_type_name)) LIKE '%' || p_filter_text || '%')
	OR (LOWER(TRIM(t1.assigned_to_user_name)) LIKE '%' || p_filter_text || '%')
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN t1.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN t1.id END ASC,
	CASE WHEN p_sort_field = 'subject' AND p_sort_direction = 'desc' THEN t1.subject END DESC,
	CASE WHEN p_sort_field = 'subject' AND p_sort_direction = 'asc' THEN t1.subject END ASC,	
	CASE WHEN p_sort_field = 'parent_type' AND p_sort_direction = 'desc' THEN t1.parent_type END DESC,
	CASE WHEN p_sort_field = 'parent_type' AND p_sort_direction = 'asc' THEN t1.parent_type END ASC,	
	CASE WHEN p_sort_field = 'parent_type_name' AND p_sort_direction = 'desc' THEN t1.parent_type_name END DESC,
	CASE WHEN p_sort_field = 'parent_type_name' AND p_sort_direction = 'asc' THEN t1.parent_type_name END ASC,	
	CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'desc' THEN t1.assigned_to_user_name END DESC,
	CASE WHEN p_sort_field = 'assigned_to_user_name' AND p_sort_direction = 'asc' THEN t1.assigned_to_user_name END ASC								
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_insert(p_company_id bigint, p_subject text, p_start_date_time timestamp without time zone, p_end_date_time timestamp without time zone, p_location_id bigint, p_reminder text, p_description text, p_parent_type text, p_parent_type_id bigint, p_assigned_to bigint, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""meeting"" (
		company_id,
        subject,
	    start_date_time,
	    end_date_time,
	    location_id,	
	    reminder,
	    description,
	    parent_type,
	    parent_type_id,	
	    assigned_to,	
	    status,
		created_by,
		created_at
    ) VALUES ( 
		p_company_id,
		TRIM(p_subject),
	    p_start_date_time,
	    p_end_date_time,
	    p_location_id,	
	    TRIM(p_reminder),
	    TRIM(p_description),
	    TRIM(p_parent_type),
	    p_parent_type_id,	
	    p_assigned_to,	
	    TRIM(p_status),
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	m.id,
    m.subject
	FROM public.""meeting"" m	 WHERE company_id=p_company_id
	ORDER BY m.subject;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_subject_exist(p_id bigint, p_company_id bigint, p_subject text)
 RETURNS TABLE(id bigint, subject text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	m.id,
	m.subject
	FROM public.""meeting"" m
	WHERE m.company_id=p_company_id AND m.id <> p_id AND LOWER(TRIM(m.subject)) = LOWER(TRIM(p_subject));
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_meeting_update(p_id bigint, p_company_id bigint, p_subject text, p_start_date_time timestamp without time zone, p_end_date_time timestamp without time zone, p_location_id bigint, p_reminder text, p_description text, p_parent_type text, p_parent_type_id bigint, p_assigned_to bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""meeting"" SET 
	subject = TRIM(p_subject),
    start_date_time = p_start_date_time,
    end_date_time = p_end_date_time,
    location_id = p_location_id,	
    reminder = TRIM(p_reminder),
    description = TRIM(p_description),
    parent_type = TRIM(p_parent_type),
    parent_type_id = p_parent_type_id,	
    assigned_to = p_assigned_to,	
    status = TRIM(p_status),
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id AND company_id=p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""module""
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::bigint 
        FROM unnest(string_to_array(p_ids, ',')) AS id
    ) AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, module_name text, code text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp with time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		m.id,
        m.module_name,
        m.code,
        m.status,
		m.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
        m.created_at,
        m.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
        m.modified_at
	FROM public.""module"" m
	LEFT JOIN public.""user"" u ON m.created_by = u.id
	LEFT JOIN public.""user"" u1 ON m.modified_by = u1.id
	WHERE m.id = p_id AND m.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN    
    p_filter_text = LOWER(TRIM(p_filter_text));
    
    total_rows := (
        SELECT COUNT(*)    
        FROM public.""module"" m
        WHERE (LOWER(TRIM(m.module_name)) LIKE '%' || p_filter_text || '%') AND m.company_id = p_company_id
    );
     
    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, module_name text, code text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp with time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp with time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
  p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
  p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

  RETURN QUERY
  SELECT
    m.id,
    m.module_name,
    m.code,
    m.status,
    m.created_by,
    COALESCE(u.first_name, '')::text AS created_by_first_name,
    COALESCE(u.last_name, '')::text AS created_by_last_name,
    COALESCE(u.user_name, '')::text AS created_by_user_name,
    m.created_at,
    m.modified_by,
    COALESCE(u1.first_name, '')::text AS modified_by_first_name,
    COALESCE(u1.last_name, '')::text AS modified_by_last_name,
    COALESCE(u1.user_name, '')::text AS modified_by_user_name,
    m.modified_at
  FROM public.""module"" m
  LEFT JOIN public.""user"" u ON m.created_by = u.id
  LEFT JOIN public.""user"" u1 ON m.modified_by = u1.id
  WHERE (
    LOWER(TRIM(m.module_name)) LIKE '%' || p_filter_text || '%' OR
    LOWER(TRIM(m.code)) LIKE '%' || p_filter_text || '%'
  ) AND m.company_id = p_company_id
  ORDER BY
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN m.id END ASC,
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN m.id END DESC,
    CASE WHEN p_sort_field = 'module_name' AND p_sort_direction = 'asc' THEN m.module_name END ASC,
    CASE WHEN p_sort_field = 'module_name' AND p_sort_direction = 'desc' THEN m.module_name END DESC,
    CASE WHEN p_sort_field = 'code' AND p_sort_direction = 'asc' THEN m.code END ASC,
    CASE WHEN p_sort_field = 'code' AND p_sort_direction = 'desc' THEN m.code END DESC
  LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_insert(p_company_id bigint, p_module_name text, p_code text, p_status text, p_created_by bigint, p_created_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
	INSERT INTO public.module (
		company_id,
		module_name,
		code,
		status,
		created_by,
		created_at
	) VALUES (
		p_company_id,
		TRIM(p_module_name),
		TRIM(p_code),
		TRIM(p_status),
		p_created_by,
		p_created_at
	);

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT m.id, m.module_name
  FROM public.""module"" m
  WHERE status = 'Active'--AND m.company_id = p_company_id 
  ORDER BY m.module_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_module_name_exist(p_id bigint, p_company_id bigint, p_module_name text)
 RETURNS TABLE(id bigint, module_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		m.id,
		m.module_name
	FROM public.""module"" m
	WHERE m.id <> p_id 
	  AND LOWER(TRIM(m.module_name)) = LOWER(TRIM(p_module_name))
	  AND m.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_module_update(p_id bigint, p_company_id bigint, p_module_name text, p_code text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
	UPDATE public.module
	SET
		module_name = TRIM(p_module_name),
		code = TRIM(p_code),
		status = TRIM(p_status),
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""option"" 
    SET status='In-active'
    WHERE id IN (
        SELECT id::bigint
        FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, option_code bigint, option_name text, module_id bigint, module_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
 ROWS 1
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        o.id,
        o.option_code,
        o.option_name,
        o.module_id,
        m.module_name,
		o.status,
        o.created_by,
        COALESCE(u.first_name, '')::text AS created_by_first_name,
        COALESCE(u.last_name, '')::text AS created_by_last_name,
        COALESCE(u.user_name, '')::text AS created_by_user_name,
        o.created_at,
        o.modified_by,
        COALESCE(u1.first_name, '')::text AS modified_by_first_name,
        COALESCE(u1.last_name, '')::text AS modified_by_last_name,
        COALESCE(u1.user_name, '')::text AS modified_by_user_name,
        o.modified_at
    FROM public.""option"" o
    LEFT JOIN public.""module"" m ON o.module_id = m.id
    LEFT JOIN public.""user"" u ON o.created_by = u.id
    LEFT JOIN public.""user"" u1 ON o.modified_by = u1.id
    WHERE o.id = p_id AND o.company_id = p_company_id
    LIMIT 1;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));

    RETURN (
        SELECT COUNT(*)
        FROM public.""option"" o
		LEFT JOIN public.""module"" m ON o.module_id = m.id
        WHERE (
            LOWER(TRIM(o.option_name)) LIKE '%' || p_filter_text || '%'
            OR LOWER(TRIM(o.option_code::text)) LIKE '%' || p_filter_text || '%'
			OR LOWER(TRIM(m.module_name)) LIKE '%' || p_filter_text || '%'
        ) AND o.company_id = p_company_id
    );
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, option_code bigint, option_name text, module_id bigint, module_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
    p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
    p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

    RETURN QUERY
    SELECT
        o.id,
        o.option_code,
        o.option_name,
        o.module_id,
        m.module_name,
		o.status,
        o.created_by,
        COALESCE(u.first_name, '')::text AS created_by_first_name,
        COALESCE(u.last_name, '')::text AS created_by_last_name,
        COALESCE(u.user_name, '')::text AS created_by_user_name,
        o.created_at,
        o.modified_by,
        COALESCE(u1.first_name, '')::text AS modified_by_first_name,
        COALESCE(u1.last_name, '')::text AS modified_by_last_name,
        COALESCE(u1.user_name, '')::text AS modified_by_user_name,
        o.modified_at
    FROM public.""option"" o
    LEFT JOIN public.""module"" m ON o.module_id = m.id
    LEFT JOIN public.""user"" u ON o.created_by = u.id
    LEFT JOIN public.""user"" u1 ON o.modified_by = u1.id
    WHERE (
        LOWER(TRIM(o.option_name)) LIKE '%' || p_filter_text || '%' OR
        CAST(o.option_code AS text) LIKE '%' || p_filter_text || '%'
		OR LOWER(TRIM(m.module_name)) LIKE '%' || p_filter_text || '%'
    )
    AND o.company_id = p_company_id
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN o.id END ASC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN o.id END DESC,
        CASE WHEN p_sort_field = 'option_name' AND p_sort_direction = 'asc' THEN o.option_name END ASC,
        CASE WHEN p_sort_field = 'option_name' AND p_sort_direction = 'desc' THEN o.option_name END DESC,
        CASE WHEN p_sort_field = 'option_code' AND p_sort_direction = 'asc' THEN o.option_code END ASC,
        CASE WHEN p_sort_field = 'option_code' AND p_sort_direction = 'desc' THEN o.option_code END DESC
    LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_insert(p_company_id bigint, p_option_code bigint, p_option_name text, p_module_id bigint, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.""option"" (
        company_id,
        option_code,
        option_name,
        module_id,
		status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        p_option_code,
        TRIM(p_option_name),
        p_module_id,
		p_status,
        p_created_by,
        COALESCE(p_created_at, now())
    );

    RETURN true;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Insert Error: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_lookup(p_company_id bigint, p_module_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 
    SELECT
        o.id,
        o.option_name AS text
    FROM public.""option"" o
    WHERE (p_module_id IS NULL OR o.module_id = p_module_id) AND status='Active' --AND o.company_id = p_company_id 
    ORDER BY o.option_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_option_update(p_id bigint, p_company_id bigint, p_option_code bigint, p_option_name text, p_module_id bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""option""
    SET
        option_code = p_option_code,
        option_name = TRIM(p_option_name),
        module_id = p_module_id,
		status =p_status,
        modified_by = p_modified_by,
        modified_at = COALESCE(p_modified_at, now())
    WHERE id = p_id AND company_id = p_company_id;

    RETURN true;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Update Error: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_pay_receipt_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, company_id bigint, payment_id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, receipt_number text, fee_amount numeric, payment_mode text, payment_type text, payment_date date, generated_by bigint, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    pr.id,
    pr.company_id,
    pr.payment_id,
    pr.course_id,
    c.course_name,
    pr.learner_id,
    CONCAT(u2.first_name, ' ', u2.last_name) AS student_name,
    pr.receipt_number,
    pr.amount_paid as fee_amount,
    pr.payment_mode,
	fc.payment_type,
    pr.payment_date,
    pr.generated_by,
    pr.created_by,
    u.first_name AS created_by_first_name,
    u.last_name AS created_by_last_name,
    u.user_name AS created_by_user_name,
    pr.created_at,
    pr.modified_by,
    u1.first_name AS modified_by_first_name,
    u1.last_name AS modified_by_last_name,
    u1.user_name AS modified_by_user_name,
    pr.modified_at
  FROM public.pay_receipt pr
  LEFT JOIN public.""course"" c ON pr.course_id = c.id
  LEFT JOIN public.""fee_collections"" fc ON pr.payment_id = fc.id
  LEFT JOIN public.""user"" u2 ON pr.learner_id = u2.id
  LEFT JOIN public.""user"" u ON pr.created_by = u.id
  LEFT JOIN public.""user"" u1 ON pr.modified_by = u1.id
  WHERE pr.id = p_id AND pr.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_pay_receipt_get_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_learner_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
    v_from_date DATE := p_from_date;
    v_to_date DATE := p_to_date;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));

    SELECT COUNT(*) INTO total_rows
    FROM public.pay_receipt pr
    LEFT JOIN public.course c ON pr.course_id = c.id
    LEFT JOIN public.user u ON pr.learner_id = u.id
    WHERE pr.company_id = p_company_id
      AND (p_learner_id IS NULL OR pr.learner_id = p_learner_id)
      AND (p_course_id IS NULL OR pr.course_id = p_course_id)
      AND pr.payment_date BETWEEN v_from_date AND v_to_date
      AND (
          LOWER(pr.receipt_number) LIKE '%' || p_filter_text || '%' OR
          LOWER(pr.payment_mode) LIKE '%' || p_filter_text || '%' OR
          LOWER(c.course_name) LIKE '%' || p_filter_text || '%' OR
          LOWER(TRIM(u.first_name || ' ' || u.last_name)) LIKE '%' || p_filter_text || '%'
      );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_pay_receipt_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_learner_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, learner_id bigint, student_name text, receipt_number text, fee_amount numeric, payment_mode text, payment_type text, payment_date date, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_from_date DATE := p_from_date;
    v_to_date DATE := p_to_date;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        pr.id,
        pr.course_id,
        c.course_name,
        pr.learner_id,
        CONCAT(u2.first_name, ' ', u2.last_name) AS student_name,
        pr.receipt_number,
        pr.amount_paid as fee_amount,
        pr.payment_mode,
		fc.payment_type,
        pr.payment_date,
        pr.created_by,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        u.user_name AS created_by_user_name,
        pr.created_at,
        pr.modified_by,
        u1.first_name AS modified_by_first_name,
        u1.last_name AS modified_by_last_name,
        u1.user_name AS modified_by_user_name,
        pr.modified_at
    FROM public.pay_receipt pr
    LEFT JOIN public.course c ON pr.course_id = c.id
	LEFT JOIN public.""fee_collections"" fc ON pr.payment_id = fc.id
    LEFT JOIN public.user u2 ON pr.learner_id = u2.id
    LEFT JOIN public.user u ON pr.created_by = u.id
    LEFT JOIN public.user u1 ON pr.modified_by = u1.id
    WHERE pr.company_id = p_company_id
      AND (p_learner_id IS NULL OR pr.learner_id = p_learner_id)
      AND (p_course_id IS NULL OR pr.course_id = p_course_id)
      AND pr.payment_date BETWEEN v_from_date AND v_to_date
      AND (
            LOWER(pr.receipt_number) LIKE '%' || p_filter_text || '%' OR
            LOWER(pr.payment_mode) LIKE '%' || p_filter_text || '%' OR
            LOWER(c.course_name) LIKE '%' || p_filter_text || '%' OR
            LOWER(CONCAT(u2.first_name, ' ', u2.last_name)) LIKE '%' || p_filter_text || '%'
          )
    ORDER BY 
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN pr.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN pr.id END ASC,
        CASE WHEN p_sort_field = 'payment_date' AND p_sort_direction = 'desc' THEN pr.payment_date END DESC,
        CASE WHEN p_sort_field = 'payment_date' AND p_sort_direction = 'asc' THEN pr.payment_date END ASC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_pay_receipt_insert(p_company_id bigint, p_payment_id bigint, p_learner_id bigint, p_course_id bigint, p_receipt_number text, p_amount_paid numeric, p_payment_mode text, p_payment_date date, p_generated_by bigint, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.pay_receipt (
        company_id,
        payment_id,
        learner_id,
        course_id,
        receipt_number,
        amount_paid,
        payment_mode,
        payment_date,
        generated_by,
        created_by,
        created_at
    )
    VALUES (
        p_company_id,
        p_payment_id,
        p_learner_id,
        p_course_id,
        p_receipt_number,
        p_amount_paid,
        p_payment_mode,
        p_payment_date,
        p_generated_by,
        p_created_by,
        p_created_at
    );
    RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_pay_receipt_update(p_id bigint, p_company_id bigint, p_payment_id bigint, p_learner_id bigint, p_course_id bigint, p_receipt_number text, p_amount_paid numeric, p_payment_mode text, p_payment_date date, p_generated_by bigint, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.pay_receipt
    SET
        company_id = p_company_id,
        payment_id = p_payment_id,
        learner_id = p_learner_id,
        course_id = p_course_id,
        receipt_number = p_receipt_number,
        amount_paid = p_amount_paid,
        payment_mode = p_payment_mode,
        payment_date = p_payment_date,
        generated_by = p_generated_by,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id;

    RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_payment_get_page(p_user_id bigint, p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, payment_id bigint, admission_id bigint, student_name text, course_id bigint, course_name text, frequency text, amount numeric, payment_date timestamp without time zone, transaction_id bigint, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
    fp.id,
    fp.payment_id,
    fp.admission_id,
    CONCAT(a.first_name, ' ', a.last_name) AS student_name,
    fp.course_id,
    c.course_name,
    fp.frequency,
    fp.amount,
    fp.payment_date,
    fp.transaction_id,
	fp.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    fp.created_at,
    fp.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    fp.modified_at	
	FROM public.""fee_payment"" fp
	LEFT JOIN public.""payment"" p ON fp.payment_id = p.id
	LEFT JOIN public.""admission"" a ON fp.admission_id = a.id
	LEFT JOIN public.""course"" c ON fp.course_id = c.id
	LEFT JOIN public.""user"" u ON fp.created_by = u.id
	LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
	WHERE (LOWER(TRIM(fp.frequency)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
		  ) 
	AND fp.company_id = p_company_id AND u.id=p_user_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN fp.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN fp.id END ASC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'desc' THEN fp.frequency END DESC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'asc' THEN fp.frequency END ASC
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_payment_insert(p_company_id bigint, p_user_id bigint, p_payee_name text, p_amount numeric, p_currency text, p_receipt text, p_payment_method text, p_transaction_id text, p_is_captured boolean, p_status text, p_razorpay_order_id text, p_razorpay_signature text, p_razorpay_payment_id text, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    -- You can define variables for logging or diagnostics here if needed
BEGIN
    -- Begin transaction block
    BEGIN
        -- Insert into payment table
        INSERT INTO public.""payment"" (
            company_id,
            user_id,
            payee_name,
            amount,
            currency,
            receipt,
            payment_method,
            transaction_id,
            is_captured,
            status,
            razorpay_order_id,
            razorpay_payment_id,
            razorpay_signature,
            created_at
        ) VALUES (
            p_company_id,
            p_user_id,
            p_payee_name,
            p_amount,
            p_currency,
            p_receipt,
            p_payment_method,
            p_transaction_id,
            p_is_captured,
            p_status,
            p_razorpay_order_id,
            p_razorpay_payment_id,
            p_razorpay_signature,
            p_created_at
        );

        -- Update user payment status
        UPDATE public.""user""
        SET status ='Active', --- 'PAID'
            modified_at = (now() AT TIME ZONE 'Asia/Kolkata')
        WHERE id = p_user_id;
		
        --- update in enrollment
		UPDATE public.""enrollments""
        SET status =p_status, --- 'PAID'
            modified_at = (now() AT TIME ZONE 'Asia/Kolkata')
        WHERE user_id = p_user_id;
        		
		-- Return true if both succeeded
        RETURN true;

    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback is automatic in PL/pgSQL function context if an error is unhandled
            RAISE NOTICE 'Error occurred during payment insert or user update: %', SQLERRM;
            RETURN false;
    END;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_payment_review_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_course_id bigint DEFAULT NULL::bigint, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, payment_id bigint, admission_id bigint, student_name text, course_id bigint, course_name text, frequency text, amount numeric, payment_date timestamp without time zone, transaction_id bigint, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
    fp.id,
    fp.payment_id,
    fp.admission_id,
    CONCAT(a.first_name, ' ', a.last_name) AS student_name,
    fp.course_id,
    c.course_name,
    fp.frequency,
    fp.amount,
    fp.payment_date,
    fp.transaction_id,
	fp.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    fp.created_at,
    fp.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    fp.modified_at	
	FROM public.""fee_payment"" fp
	LEFT JOIN public.""payment"" p ON fp.payment_id = p.id
	LEFT JOIN public.""admission"" a ON fp.admission_id = a.id
	LEFT JOIN public.""course"" c ON fp.course_id = c.id
	LEFT JOIN public.""user"" u ON fp.created_by = u.id
	LEFT JOIN public.""user"" u1 ON fp.modified_by = u1.id
	WHERE fp.company_id = p_company_id
	  AND (p_user_id IS NULL OR fp.user_id = u.id)
	  AND fp.payment_date::date BETWEEN v_from_date AND v_to_date
	  AND (LOWER(TRIM(fp.frequency)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
		  ) 
	--AND fp.company_id = p_company_id-- AND u.id=p_user_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN fp.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN fp.id END ASC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'desc' THEN fp.frequency END DESC,
	CASE WHEN p_sort_field = 'frequency' AND p_sort_direction = 'asc' THEN fp.frequency END ASC
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_permissions_get(p_user_id bigint, p_company_id bigint)
 RETURNS TABLE(option_id bigint, option_code bigint, option_name text, module_id bigint, module_name text, ""grant"" boolean, permission_source text)
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_role_id bigint;
BEGIN
  -- Get the role_id of the user
  SELECT role_id INTO v_role_id FROM public.""user""
  WHERE id = p_user_id;

  RETURN QUERY
  SELECT
    o.id AS option_id,
    o.option_code,
    o.option_name,
    o.module_id,
    m.module_name,

    -- Logic for grant override
    CASE 
      WHEN rp.option_id IS NOT NULL AND rp.""grant"" = false THEN false
      WHEN up.option_id IS NOT NULL THEN up.""grant""
      ELSE rp.""grant""
    END AS ""grant"",

    -- Source info
    CASE 
      WHEN rp.option_id IS NOT NULL AND rp.""grant"" = false THEN 'Role'
      WHEN up.option_id IS NOT NULL THEN 'User'
      ELSE 'Role'
    END AS permission_source

  FROM public.""option"" o
  INNER JOIN public.module m ON o.module_id = m.id
  LEFT JOIN public.user_permission up
    ON up.option_id = o.id 
    AND up.user_id = p_user_id
    AND up.company_id = p_company_id
  LEFT JOIN public.role_permission rp
    ON rp.option_id = o.id 
    AND rp.role_id = v_role_id 
    AND rp.company_id = p_company_id
  WHERE up.option_id IS NOT NULL OR rp.option_id IS NOT NULL;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_lookup(p_company_id bigint, p_quiz_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	qq.id,
	qq.question
  
	FROM public.""quiz_questions"" qq
	WHERE qq.quiz_id=p_quiz_id AND qq.company_id = p_company_id AND status='Active'
	ORDER BY qq.question;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_options_delete(p_company_id bigint, p_question_id bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    DELETE 
	FROM public.""question_options""
	WHERE question_id=p_question_id
	AND company_id = p_company_id; 

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_options_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, quiz_id bigint, quiz_name text, question_id bigint, question text, option_text text, explanation text, is_correct boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	qo.id,
	qo.quiz_id,
	q.quiz_name,
    qo.question_id,
	qq.question,
	qo.option_text,
	qo.explanation,
    qo.is_correct,
	qo.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    qo.created_at,
    qo.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    qo.modified_at
	FROM public.""question_options"" qo
	LEFT JOIN public.""quiz"" q ON qo.quiz_id = q.id
	LEFT JOIN public.""quiz_questions"" qq ON qo.question_id = qq.id
	LEFT JOIN public.""user"" u ON qo.created_by = u.id
	LEFT JOIN public.""user"" u1 ON qo.modified_by = u1.id
	WHERE qo.id = p_id AND qo.company_id = p_company_id;
	
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_options_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
    v_filter_text TEXT;
BEGIN
    v_filter_text := LOWER(TRIM(p_filter_text));
    SELECT COUNT(*) INTO total_rows
    FROM public.""question_options"" qo
    LEFT JOIN public.""quiz"" q ON qo.quiz_id = q.id
    LEFT JOIN public.""quiz_questions"" qq ON qo.question_id = qq.id
    LEFT JOIN public.""user"" u ON qo.created_by = u.id
    LEFT JOIN public.""user"" u1 ON qo.modified_by = u1.id
    WHERE (
        LOWER(TRIM(qo.option_text)) LIKE '%' || v_filter_text || '%'
        OR LOWER(TRIM(q.quiz_name)) LIKE '%' || v_filter_text || '%'
        OR LOWER(TRIM(qq.question)) LIKE '%' || v_filter_text || '%'
    )
    AND qo.company_id = p_company_id;

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_options_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, quiz_id bigint, quiz_name text, question_id bigint, question text, option_text text, explanation text, is_correct boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	qo.id,
	qo.quiz_id,
	q.quiz_name,
    qo.question_id,
	qq.question,
	qo.option_text,
	qo.explanation,
    qo.is_correct,
	qo.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    qo.created_at,
    qo.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    qo.modified_at
	FROM public.""question_options"" qo
	LEFT JOIN public.""quiz"" q ON qo.quiz_id = q.id
	LEFT JOIN public.""quiz_questions"" qq ON qo.question_id = qq.id
	LEFT JOIN public.""user"" u ON qo.created_by = u.id
	LEFT JOIN public.""user"" u1 ON qo.modified_by = u1.id
	WHERE (LOWER(TRIM(qo.option_text)) LIKE '%' || p_filter_text || '%'
		   OR LOWER(TRIM(q.quiz_name)) LIKE '%' || p_filter_text || '%'
		   OR LOWER(TRIM(qq.question)) LIKE '%' || p_filter_text || '%'
		  ) AND qo.company_id = p_company_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN qo.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN qo.id END ASC
	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_options_insert(p_company_id bigint, p_quiz_id bigint, p_question_id bigint, p_option_text text, p_explanation text, p_is_correct boolean, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""question_options"" (
	   company_id,
	   quiz_id,
 	   question_id,
	   option_text,
	   explanation,
	   is_correct,
	   created_by,
	   created_at
    ) VALUES (
	    p_company_id,
		p_quiz_id,
        p_question_id,
		TRIM(p_option_text),
		TRIM(p_explanation),
		p_is_correct,
        p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_question_options_update(p_id bigint, p_company_id bigint, p_quiz_id bigint, p_question_id bigint, p_option_text text, p_explanation text, p_is_correct boolean, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.question_options SET
	company_id = p_company_id,
	quiz_id = p_quiz_id,
	question_id = p_question_id,
	option_text= TRIM(p_option_text),
	explanation= TRIM(p_explanation),
    is_correct= p_is_correct,
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_data_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, quiz_name text, quiz_code text, quiz_type text, exam_duration integer, question_id bigint, question text, option_id bigint, option_text text, is_correct boolean, explanation text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	    q.id,
        q.quiz_name,
	    q.quiz_code,
		q.quiz_type,
		q.exam_duration,
	    qo.question_id,
	    qq.question,
	    qo.id as option_id,
	    qo.option_text,
	    qo.is_correct, 
	    qo.explanation,
        q.status,	
	    q.created_by,
	    u.first_name,
	    u.last_name,
	    u.user_name,
        q.created_at,
        q.modified_by,
	    u1.first_name,
	    u1.last_name,
	    u1.user_name,
        q.modified_at
	FROM public.quiz q
	LEFT JOIN public.quiz_questions qq ON qq.quiz_id = q.id
	LEFT JOIN public.question_options qo ON qo.question_id = qq.id
	LEFT JOIN public.""user"" u ON q.created_by = u.id
	LEFT JOIN public.""user"" u1 ON q.modified_by = u1.id
	WHERE q.id = p_id AND q.company_id = p_company_id
      AND q.status = 'Active' 
      AND qq.status = 'Active';
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_data_insert(p_company_id bigint, p_course_id bigint, p_quiz_name text, p_quiz_code text, p_quiz_type text, p_exam_duration integer, p_status text, p_created_by bigint, p_created_at timestamp without time zone, input_json jsonb)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    question_item jsonb;
    option_item jsonb;
    generated_quiz_id bigint;
    generated_question_id bigint;
BEGIN
    -- Insert the quiz
    INSERT INTO public.quiz (
        company_id,
        course_id,
        quiz_name,
        quiz_code,
        quiz_type,
        exam_duration,        -- New column inserted here
        status,
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        p_course_id,
        TRIM(p_quiz_name),
        TRIM(p_quiz_code),
        p_quiz_type,
        p_exam_duration,      -- New value mapped here
        p_status,
        p_created_by,
        p_created_at
    )
    ON CONFLICT (quiz_name, quiz_code) DO NOTHING
    RETURNING id INTO generated_quiz_id;

    -- If quiz already exists, get its ID
    IF generated_quiz_id IS NULL THEN
        SELECT id INTO generated_quiz_id
        FROM public.quiz
        WHERE quiz_name = TRIM(p_quiz_name)
          AND quiz_code = TRIM(p_quiz_code);
    END IF;

    -- Loop through questions in the first quiz object
    FOR question_item IN
        SELECT * FROM jsonb_array_elements(input_json->'data'->'AddQuizData'->0->'questions')
    LOOP
        INSERT INTO quiz_questions (
            quiz_id,
            question,
            status,
            created_by,
            created_at,
            company_id
        ) VALUES (
            generated_quiz_id,
            question_item->>'question',
            question_item->>'status',
            p_created_by,
            p_created_at,
            p_company_id
        )
        RETURNING id INTO generated_question_id;

        -- Loop through options for this question
        FOR option_item IN
            SELECT * FROM jsonb_array_elements(question_item->'options')
        LOOP
            INSERT INTO question_options (
                question_id,
                option_text,
                is_correct,
                created_by,
                created_at,
                explanation,
                quiz_id,
                company_id
            )
            VALUES (
                generated_question_id,
                option_item->>'option_text',
                (option_item->>'is_correct')::boolean,
                p_created_by,
                p_created_at,
                option_item->>'explanation',
                generated_quiz_id,
                p_company_id
            );
        END LOOP;
    END LOOP;

    RETURN true;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""quiz""
	SET status = 'In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, quiz_name text, quiz_code text, quiz_type text, exam_duration integer, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
   SELECT
	q.id,
	q.course_id, 
	c.course_name,
    q.quiz_name,
	q.quiz_code,
	q.quiz_type,
	q.exam_duration,                  -- New field selected
    q.status,
	q.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    q.created_at,
    q.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    q.modified_at
	FROM public.""quiz"" q
	LEFT JOIN public.""course"" c ON q.course_id = c.id
	LEFT JOIN public.""user"" u ON q.created_by = u.id
	LEFT JOIN public.""user"" u1 ON q.modified_by = u1.id
	WHERE q.id = p_id AND q.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
BEGIN
    -- Normalize filter text to match func_quiz_get_page
    p_filter_text := LOWER(TRIM(p_filter_text));

    SELECT COUNT(*) INTO total_rows
    FROM public.""quiz"" q
	LEFT JOIN public.course c ON q.course_id = c.id
    LEFT JOIN public.""user"" u ON q.created_by = u.id
    LEFT JOIN public.""user"" u1 ON q.modified_by = u1.id
    WHERE q.company_id = p_company_id
      	  AND (
              LOWER(TRIM(q.quiz_name)) LIKE '%' || p_filter_text || '%'
		      OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%' 
          );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, quiz_name text, quiz_code text, quiz_type text, exam_duration integer, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        q.id,
        q.course_id,
        c.course_name,
        q.quiz_name,
        q.quiz_code,
		q.quiz_type,
		q.exam_duration,                     -- New field selected
        q.status,
        q.created_by,
        u.first_name,
        u.last_name,
        u.user_name,
        q.created_at,
        q.modified_by,
        u1.first_name,
        u1.last_name,
        u1.user_name,
        q.modified_at
    FROM public.quiz q
    LEFT JOIN public.course c ON q.course_id = c.id
    LEFT JOIN public.""user"" u ON q.created_by = u.id
    LEFT JOIN public.""user"" u1 ON q.modified_by = u1.id
    WHERE q.company_id = p_company_id
      AND (LOWER(TRIM(q.quiz_name)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%' 
		  )
    ORDER BY
        CASE 
            WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN q.id 
        END ASC,
        CASE 
            WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN q.id 
        END DESC,
        CASE 
            WHEN p_sort_field = 'quiz_name' AND p_sort_direction = 'asc' THEN q.quiz_name 
        END ASC,
        CASE 
            WHEN p_sort_field = 'quiz_name' AND p_sort_direction = 'desc' THEN q.quiz_name 
        END DESC
    LIMIT p_limit
    OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_insert(p_company_id bigint, p_course_id bigint, p_quiz_name text, p_quiz_code text, p_quiz_type text, p_exam_duration integer, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""quiz"" (
	    company_id,
		course_id,
        quiz_name,
		quiz_code,
		quiz_type,
        exam_duration,         -- New column inserted
        status,
		created_by,
		created_at
    ) VALUES (
	    p_company_id,
		p_course_id,
        TRIM(p_quiz_name),
		TRIM(p_quiz_code),
		p_quiz_type,
        p_exam_duration,       -- New value mapped
        p_status,
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_lookup(p_company_id bigint, p_course_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		q.id,
		q.quiz_name
	FROM public.""quiz"" q
	WHERE 
		q.company_id = p_company_id AND status='Active'  AND
		(p_course_id IS NULL OR q.course_id = p_course_id)
	ORDER BY q.quiz_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_question_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	qq.id,
    qq.question
	FROM public.""quiz_questions"" qq	
	WHERE qq.company_id = p_company_id AND status='Active'
	ORDER BY qq.question;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_question_options_delete(p_company_id bigint, p_question_id bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""question_options""
	SET status = 'In-active'
	WHERE question_id=p_question_id
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_question_options_get(p_question_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, option_text text, is_correct boolean, explanation text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
	SELECT
		qo.id,
		qo.option_text,	
		qo.is_correct,
		qo.explanation	
	FROM public.question_options qo
	WHERE qo.question_id = p_question_id
	  AND qo.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_question_options_insert(p_company_id bigint, p_quiz_id bigint, p_question_id bigint, p_option_text text, p_is_correct boolean, p_explanation text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""question_options"" (
	   company_id,
	   quiz_id,
 	   question_id,
	   option_text,
	   explanation,
	   is_correct,
	   created_by,
	   created_at
    ) VALUES (
	    p_company_id,
		p_quiz_id,
        p_question_id,
		TRIM(p_option_text),
		TRIM(p_explanation),
		p_is_correct,
        p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_question_options_update(p_company_id bigint, p_quiz_id bigint, p_question_id bigint, p_option_text text, p_explanation text, p_is_correct boolean, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN 
	
    INSERT INTO public.""question_options"" (
	   company_id,
	   quiz_id,
 	   question_id,
	   option_text,
	   explanation,
	   is_correct,
	   created_by,
	   created_at
    ) VALUES (
	    p_company_id,
		p_quiz_id,
        p_question_id,
		TRIM(p_option_text),
		TRIM(p_explanation),
		p_is_correct,
        p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_questions_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- Fix: Convert text to array inline
    DELETE FROM public.""question_options""
    WHERE question_id = ANY(string_to_array(p_ids, ',')::bigint[])
    AND company_id = p_company_id;

    DELETE FROM public.""quiz_questions""
    WHERE id IN (
        SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_questions_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, quiz_id bigint, quiz_name text, question text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	qq.id,
    qq.quiz_id,
	q.quiz_name,
	qq.question,
	qq.status,
	qq.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    qq.created_at,
    qq.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    q.modified_at
	FROM public.""quiz_questions"" qq
	LEFT JOIN public.""quiz"" q ON qq.quiz_id = q.id
	LEFT JOIN public.""user"" u ON qq.created_by = u.id
	LEFT JOIN public.""user"" u1 ON qq.modified_by = u1.id
	WHERE qq.id = p_id AND qq.company_id = p_company_id;
	
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_questions_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows bigint;
BEGIN
    p_filter_text = LOWER(TRIM(p_filter_text));
    total_rows = (SELECT
	COUNT(*)
    FROM public.""quiz_questions"" qq
	LEFT JOIN public.""quiz"" q ON qq.quiz_id = q.id			  
	WHERE  (LOWER(TRIM(qq.question)) LIKE '%' || p_filter_text || '%'
		   OR LOWER(TRIM(q.quiz_name)) LIKE '%' || p_filter_text || '%'
		   )
	AND qq.company_id = p_company_id ); 
    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_questions_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, quiz_id bigint, quiz_name text, question text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	qq.id,
    qq.quiz_id,
    q.quiz_name,
	qq.question,
	qq.status,
	qq.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    qq.created_at,
    qq.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    q.modified_at
	FROM public.""quiz_questions"" qq
	LEFT JOIN public.""quiz"" q ON qq.quiz_id = q.id
	LEFT JOIN public.""user"" u ON qq.created_by = u.id
	LEFT JOIN public.""user"" u1 ON qq.modified_by = u1.id
	WHERE (LOWER(TRIM(qq.question)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(q.quiz_name)) LIKE '%' || p_filter_text || '%'
		  ) AND qq.company_id = p_company_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN qq.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN qq.id END ASC,
	CASE WHEN p_sort_field = 'quiz_name' AND p_sort_direction = 'desc' THEN q.quiz_name END DESC,
	CASE WHEN p_sort_field = 'quiz_name' AND p_sort_direction = 'asc' THEN q.quiz_name END ASC,	
	CASE WHEN p_sort_field = 'question' AND p_sort_direction = 'desc' THEN qq.question END DESC,
	CASE WHEN p_sort_field = 'question' AND p_sort_direction = 'asc' THEN qq.question END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_questions_insert(p_company_id bigint, p_quiz_id bigint, p_question text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
	new_id bigint;
BEGIN
	INSERT INTO public.quiz_questions (
		company_id,
		quiz_id,
		question,
		status,
		created_by,
		created_at
	)
	VALUES (
		p_company_id,
		p_quiz_id,
		TRIM(p_question),
		p_status,
		p_created_by,
		p_created_at
	)
	RETURNING id INTO new_id;

	RETURN new_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_questions_update(p_id bigint, p_company_id bigint, p_quiz_id bigint, p_question text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""quiz_questions""
    SET
	    company_id = p_company_id,
        quiz_id = p_quiz_id,
        question = TRIM(p_question),
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_quiz_name_exist(p_id bigint, p_company_id bigint, p_quiz_name text)
 RETURNS TABLE(id bigint, quiz_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	q.id,
	q.quiz_name
	FROM public.""quiz"" q
	WHERE q.id <> p_id AND q.company_id = p_company_id AND LOWER(TRIM(q.quiz_name)) = LOWER(TRIM(p_quiz_name));
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_result_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    DELETE 
	FROM public.""quiz_results""
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_result_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, user_name text, course_name text, quiz_name text, quiz_code text, quiz_type text, exam_duration integer, total_questions integer, attempted_questions integer, unattempted_questions integer, correct_answers integer, wrong_answers integer, percentage numeric, time_taken_seconds integer, passed boolean, attempt_timestamp timestamp without time zone, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY
	SELECT
		qr.id,
		u.first_name || ' ' || u.last_name || ' (' || COALESCE(u.code, '') || ')' AS user_name,
		c.course_name,
		q.quiz_name,
		q.quiz_code,
		q.quiz_type,
		q.exam_duration,
		qr.total_questions,
		qr.attempted_questions,
		qr.unattempted_questions,
		qr.correct_answers,
		qr.wrong_answers,
		qr.percentage,
		qr.time_taken_seconds,
		qr.passed,
		qr.attempt_timestamp::timestamp without time zone,  -- <-- FIX
		qr.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		qr.created_at::timestamp without time zone          -- <-- FIX
	FROM public.quiz_results qr
	LEFT JOIN public.quiz q ON q.id = qr.quiz_id
	LEFT JOIN public.course c ON c.id = qr.course_id
	LEFT JOIN public.""user"" u ON qr.created_by = u.id
	WHERE qr.id = p_id AND qr.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_result_review_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_created_by bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows BIGINT;
	v_from_date DATE := p_from_date::date;
	v_to_date DATE := p_to_date::date;
BEGIN	
	p_filter_text := LOWER(TRIM(p_filter_text));

	total_rows := (
		SELECT COUNT(*)
		FROM public.quiz_results qr
		LEFT JOIN public.quiz q ON q.id = qr.quiz_id
		LEFT JOIN public.course c ON c.id = qr.course_id
		LEFT JOIN public.""user"" u ON qr.created_by = u.id
		WHERE qr.company_id = p_company_id
		  AND (p_created_by IS NULL OR qr.created_by = p_created_by)
		  AND qr.attempt_timestamp >= v_from_date
		  AND qr.attempt_timestamp < (v_to_date + INTERVAL '1 day')
		  AND (
				LOWER(COALESCE(q.quiz_name, '')) LIKE '%' || p_filter_text || '%' OR
				LOWER(COALESCE(q.quiz_code, '')) LIKE '%' || p_filter_text || '%' OR
				LOWER(COALESCE(q.quiz_type, '')) LIKE '%' || p_filter_text || '%' OR
				LOWER(COALESCE(c.course_name, '')) LIKE '%' || p_filter_text || '%' OR
				LOWER(COALESCE(u.first_name, '')) LIKE '%' || p_filter_text || '%' OR
				LOWER(COALESCE(u.last_name, '')) LIKE '%' || p_filter_text || '%' OR
				LOWER(COALESCE(u.user_name, '')) LIKE '%' || p_filter_text || '%'
		  )
	);

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_result_review_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_created_by bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, user_name text, course_name text, quiz_name text, quiz_code text, quiz_type text, exam_duration integer, total_questions integer, attempted_questions integer, unattempted_questions integer, correct_answers integer, wrong_answers integer, percentage numeric, time_taken_seconds integer, passed boolean, attempt_timestamp timestamp with time zone, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_from_date DATE := p_from_date;
	v_to_date DATE := p_to_date;
BEGIN
	p_filter_text := LOWER(TRIM(p_filter_text));
	p_sort_field := LOWER(TRIM(p_sort_field));
	p_sort_direction := LOWER(TRIM(p_sort_direction));

	RETURN QUERY
	SELECT
		qr.id,
		u.first_name || ' ' || u.last_name || ' (' || COALESCE(u.code, '') || ')' AS user_name,
		c.course_name,
		q.quiz_name,
		q.quiz_code,
		q.quiz_type,
		q.exam_duration,
		qr.total_questions,
		qr.attempted_questions,
		qr.unattempted_questions,
		qr.correct_answers,
		qr.wrong_answers,
		qr.percentage,
		qr.time_taken_seconds,
		qr.passed,
		qr.attempt_timestamp,
		qr.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		qr.created_at
	FROM public.quiz_results qr
	LEFT JOIN public.quiz q ON q.id = qr.quiz_id
	LEFT JOIN public.course c ON c.id = qr.course_id
	LEFT JOIN public.""user"" u ON qr.created_by = u.id
	WHERE qr.company_id = p_company_id
	  AND (p_created_by IS NULL OR qr.created_by = p_created_by)
	  AND qr.attempt_timestamp >= v_from_date 
	  AND qr.attempt_timestamp < (v_to_date + INTERVAL '1 day')
	  AND (
			LOWER(COALESCE(q.quiz_name, '')) LIKE '%' || p_filter_text || '%' OR
			LOWER(COALESCE(q.quiz_code, '')) LIKE '%' || p_filter_text || '%' OR
			LOWER(COALESCE(q.quiz_type, '')) LIKE '%' || p_filter_text || '%' OR
			LOWER(COALESCE(c.course_name, '')) LIKE '%' || p_filter_text || '%' OR
			LOWER(COALESCE(u.first_name, '')) LIKE '%' || p_filter_text || '%' OR
			LOWER(COALESCE(u.last_name, '')) LIKE '%' || p_filter_text || '%' OR
			LOWER(COALESCE(u.user_name, '')) LIKE '%' || p_filter_text || '%'
	  )
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN qr.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN qr.id END ASC,
		CASE WHEN p_sort_field = 'quiz_name' AND p_sort_direction = 'desc' THEN q.quiz_name END DESC,
		CASE WHEN p_sort_field = 'quiz_name' AND p_sort_direction = 'asc' THEN q.quiz_name END ASC,
		CASE WHEN p_sort_field = 'course_name' AND p_sort_direction = 'desc' THEN c.course_name END DESC,
		CASE WHEN p_sort_field = 'course_name' AND p_sort_direction = 'asc' THEN c.course_name END ASC,
		qr.id DESC
	OFFSET p_offset LIMIT p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_results_insert(p_company_id bigint, p_student_id bigint, p_course_id bigint, p_quiz_id bigint, p_total_questions integer, p_attempted_questions integer, p_unattempted_questions integer, p_correct_answers integer, p_wrong_answers integer, p_percentage numeric, p_time_taken_seconds integer, p_created_by bigint, p_passed boolean DEFAULT false, p_attempt_timestamp timestamp without time zone DEFAULT now(), p_created_at timestamp without time zone DEFAULT now())
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_result_id bigint;
BEGIN
	INSERT INTO public.quiz_results (
		company_id,
		student_id,
		course_id,
		quiz_id,
		total_questions,
		attempted_questions,
		unattempted_questions,
		correct_answers,
		wrong_answers,
		percentage,
		time_taken_seconds,
		passed,
		attempt_timestamp,
		created_by,
		created_at
	) VALUES (
		p_company_id,
		p_student_id,
		p_course_id,
		p_quiz_id,
		p_total_questions,
		p_attempted_questions,
		p_unattempted_questions,
		p_correct_answers,
		p_wrong_answers,
		p_percentage,
		p_time_taken_seconds,
		p_passed,
		p_attempt_timestamp,
		p_created_by,
		p_created_at
	)
	RETURNING id INTO v_result_id;

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_quiz_name text, p_quiz_code text, p_quiz_type text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.quiz
    SET
	    company_id = p_company_id,
        course_id = p_course_id,
        quiz_name = TRIM(p_quiz_name),
        quiz_code = TRIM(p_quiz_code),
		quiz_type= p_quiz_type,
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_quiz_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_quiz_name text, p_quiz_code text, p_quiz_type text, p_exam_duration integer, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.quiz
    SET
	    company_id = p_company_id,
        course_id = p_course_id,
        quiz_name = TRIM(p_quiz_name),
        quiz_code = TRIM(p_quiz_code),
		quiz_type = p_quiz_type,
        exam_duration = p_exam_duration, -- New column updated
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.referral
	SET status = 'In-active'
    WHERE id IN (
        SELECT unnest(string_to_array(p_ids, ',')::bigint[])
    )
    AND company_id = p_company_id;

    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, referral_company_name text, referral_date timestamp with time zone, contact_person text, mobile_no text, email text, address text, product_interest text, requirement text, is_paid boolean, status text, referred_by bigint, referred_by_name text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone, status_history json)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
	SELECT
		r.id,
		r.referral_company_name,
		r.referral_date,
		r.contact_person,
		r.mobile_no,
		r.email,
		r.address,
		r.product_interest,
		r.requirement,
		r.is_paid,
		r.status,
		r.referred_by,
		u2.first_name || ' ' || u2.last_name || ' (' || COALESCE(u2.id, 0) || ')' AS referred_by_name,
		r.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		r.created_at,
		r.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		r.modified_at,
		
		-- status_history as JSON array
		(
			SELECT json_agg(json_build_object(
				'old_status', sh.old_status,
				'new_status', sh.new_status,
				'created_at', sh.created_at
			) ORDER BY sh.created_at)
			FROM public.referral_status_history sh
			WHERE sh.referral_id = r.id AND sh.company_id = r.company_id
		) AS status_history

	FROM public.referral r
	LEFT JOIN public.""user"" u2 ON r.referred_by = u2.id
	LEFT JOIN public.""user"" u ON r.created_by = u.id
	LEFT JOIN public.""user"" u1 ON r.modified_by = u1.id
	WHERE r.id = p_id AND r.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_get_count(p_company_id bigint, p_userid bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text)); 

    total_rows := (
        SELECT COUNT(*)
        FROM public.referral r
        WHERE r.company_id = p_company_id AND r.referred_by = p_userid
          AND (
              LOWER(r.referral_company_name) LIKE '%' || p_filter_text || '%'
              OR LOWER(r.contact_person) LIKE '%' || p_filter_text || '%'
              OR LOWER(r.email) LIKE '%' || p_filter_text || '%'
              OR LOWER(r.product_interest) LIKE '%' || p_filter_text || '%'
              OR LOWER(r.requirement) LIKE '%' || p_filter_text || '%'
              OR LOWER(r.status) LIKE '%' || p_filter_text || '%'
          )
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_get_page(p_company_id bigint, p_userid bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, referral_company_name text, referral_date timestamp with time zone, contact_person text, mobile_no text, email text, address text, product_interest text, requirement text, is_paid boolean, status text, referred_by bigint, referred_by_name text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_affiliate_id bigint;

BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));
    SELECT u.affiliate_id INTO v_affiliate_id
    FROM public.""user"" u
    WHERE u.id = p_userid AND u.company_id = p_company_id;

	
	RETURN QUERY
    SELECT
        r.id,
        r.referral_company_name,
        r.referral_date,
        r.contact_person,
        r.mobile_no,
        r.email,
        r.address,
        r.product_interest,
        r.requirement,
        r.is_paid,
        r.status,
        r.referred_by,
		u.first_name || ' ' || u.last_name AS referred_by_name,
        r.created_by,
        r.created_at,
        r.modified_by,
        r.modified_at
    FROM public.referral r
	LEFT JOIN public.""user"" u ON r.referred_by = u.id
    WHERE r.company_id = p_company_id and r.referred_by = p_userid
      AND (
          LOWER(r.referral_company_name) LIKE '%' || p_filter_text || '%'
          OR LOWER(r.contact_person) LIKE '%' || p_filter_text || '%'
          OR LOWER(r.email) LIKE '%' || p_filter_text || '%'
          OR LOWER(r.product_interest) LIKE '%' || p_filter_text || '%'
          OR LOWER(r.requirement) LIKE '%' || p_filter_text || '%'
          OR LOWER(r.status) LIKE '%' || p_filter_text || '%'
      )
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN r.id END ASC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN r.id END DESC,
        CASE WHEN p_sort_field = 'referral_company_name' AND p_sort_direction = 'asc' THEN r.referral_company_name END ASC,
        CASE WHEN p_sort_field = 'referral_company_name' AND p_sort_direction = 'desc' THEN r.referral_company_name END DESC,
        CASE WHEN p_sort_field = 'referral_date' AND p_sort_direction = 'asc' THEN r.referral_date END ASC,
        CASE WHEN p_sort_field = 'referral_date' AND p_sort_direction = 'desc' THEN r.referral_date END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN r.status END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN r.status END DESC
    OFFSET p_offset
    LIMIT p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_insert(p_company_id bigint, p_referral_company_name text, p_referral_date timestamp with time zone, p_contact_person text, p_mobile_no text, p_email text, p_address text, p_product_interest text, p_requirement text, p_is_paid boolean, p_status text, p_referred_by bigint, p_created_by bigint, p_created_at timestamp without time zone, p_received_amount numeric DEFAULT 0)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_new_referral_id bigint;
BEGIN
	-- Insert into referral table
	INSERT INTO public.referral (
		company_id,
		referral_company_name,
		referral_date,
		contact_person,
		mobile_no,
		email,
		address,
		product_interest,
		requirement,
		received_amount,
		is_paid,
		status,
		referred_by,
		created_by,
		created_at
	)
	VALUES (
		p_company_id,
		TRIM(p_referral_company_name),
		(now() AT TIME ZONE 'Asia/Kolkata'),
		TRIM(p_contact_person),
		TRIM(p_mobile_no),
		TRIM(p_email),
		TRIM(p_address),
		TRIM(p_product_interest),
		TRIM(p_requirement),
		p_received_amount,
		p_is_paid,
		TRIM(p_status),
		p_referred_by,
		p_created_by,
		p_created_at
	)
	RETURNING id INTO v_new_referral_id;

	-- Insert into referral_status_history
	INSERT INTO public.referral_status_history (
		company_id,
		referral_id,
		old_status,
		new_status,
		created_by,
		created_at
	)
	VALUES (
		p_company_id,
		v_new_referral_id,
		NULL,
		TRIM(p_status),
		p_created_by,
		p_created_at
	);

	RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_report(p_company_id bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, referral_company_name text, referral_date timestamp with time zone, contact_person text, mobile_no text, email text, address text, product_interest text, requirement text, is_paid boolean, status text, referred_by bigint, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone, referred_by_name text, created_by_name text, modified_by_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        r.id,
        r.referral_company_name,
        r.referral_date,
        r.contact_person,
        r.mobile_no,
        r.email,
        r.address,
        r.product_interest,
        r.requirement,
        r.is_paid,
        r.status,
        r.referred_by,
        r.created_by,
        r.created_at,
        r.modified_by,
        r.modified_at,
        CONCAT(u_ref.first_name, ' ', u_ref.last_name) AS referred_by_name,
        CONCAT(u_cr.first_name, ' ', u_cr.last_name) AS created_by_name,
        CONCAT(u_mod.first_name, ' ', u_mod.last_name) AS modified_by_name
    FROM public.referral r
    LEFT JOIN public.""user"" u_ref ON r.referred_by = u_ref.id
    LEFT JOIN public.""user"" u_cr ON r.created_by = u_cr.id
    LEFT JOIN public.""user"" u_mod ON r.modified_by = u_mod.id
    WHERE (p_user_id IS NULL OR r.referred_by = p_user_id)
      AND r.referral_date BETWEEN p_from_date AND p_to_date
      AND r.company_id = p_company_id
    ORDER BY r.referral_date DESC;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_review_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_referred_by bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows BIGINT;
	v_from_date DATE := p_from_date::date;
	v_to_date DATE := p_to_date::date;
BEGIN	
	p_filter_text := LOWER(TRIM(p_filter_text));

	total_rows := (
		SELECT COUNT(*)
		FROM public.referral r
		WHERE r.company_id = p_company_id
		  AND (p_referred_by IS NULL OR r.referred_by = p_referred_by)
		  AND r.referral_date BETWEEN v_from_date AND v_to_date
		  AND (
				LOWER(TRIM(r.referral_company_name)) LIKE '%' || p_filter_text || '%' OR
				LOWER(TRIM(r.contact_person)) LIKE '%' || p_filter_text || '%' OR
				LOWER(TRIM(r.mobile_no)) LIKE '%' || p_filter_text || '%' OR
				LOWER(TRIM(r.email)) LIKE '%' || p_filter_text || '%' OR
				LOWER(TRIM(r.product_interest)) LIKE '%' || p_filter_text || '%' OR
				LOWER(TRIM(r.requirement)) LIKE '%' || p_filter_text || '%' OR
				LOWER(TRIM(r.status)) LIKE '%' || p_filter_text || '%'
		  )
	);

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_review_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_referred_by bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, referral_company_name text, referral_date timestamp with time zone, contact_person text, mobile_no text, email text, address text, product_interest text, requirement text, is_paid boolean, status text, referred_by bigint, referred_by_name text, referred_by_first_name text, referred_by_last_name text, referred_by_user_name text, created_by bigint, created_at timestamp without time zone, modified_by bigint, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_from_date DATE := p_from_date;
	v_to_date DATE := p_to_date;
	v_code bigint;
	v_affiliate_role_id bigint;
BEGIN
	p_filter_text := LOWER(TRIM(p_filter_text));
	p_sort_field := LOWER(TRIM(p_sort_field));
	p_sort_direction := LOWER(TRIM(p_sort_direction));
    
	-- Get affiliate role id
    SELECT r.id INTO v_affiliate_role_id
    FROM public.role r
    WHERE r.role_name = 'Affiliate' AND r.company_id = p_company_id;
	
	-- Handle referred_by filter only if provided
	IF p_referred_by IS NOT NULL THEN
		SELECT u.code INTO v_code
		FROM public.""user"" u
		WHERE u.id = p_referred_by AND u.company_id = p_company_id;
	END IF;

	RETURN QUERY
	SELECT
		r.id,
		r.referral_company_name,
		r.referral_date,
		r.contact_person,
		r.mobile_no,
		r.email,
		r.address,
		r.product_interest,
		r.requirement,
		r.is_paid,
		r.status,
		r.referred_by,
		u.first_name || ' ' || u.last_name AS referred_by_name,
		u.first_name,
		u.last_name,
		u.user_name AS referred_by_user_name,
		r.created_by,
		r.created_at,
		r.modified_by,
		r.modified_at
	FROM public.referral r
	LEFT JOIN public.""user"" u ON r.referred_by = u.id 
	AND u.role_id = v_affiliate_role_id
	WHERE r.company_id = p_company_id
	  AND (p_referred_by IS NULL OR r.referred_by = u.id)
	  AND r.referral_date::date BETWEEN v_from_date AND v_to_date
	  AND (
			LOWER(TRIM(r.referral_company_name)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(r.contact_person)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(r.mobile_no)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(r.email)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(r.product_interest)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(r.requirement)) LIKE '%' || p_filter_text || '%' OR
			LOWER(TRIM(r.status)) LIKE '%' || p_filter_text || '%'
		)
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN r.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN r.id END ASC,
		CASE WHEN p_sort_field = 'referral_company_name' AND p_sort_direction = 'desc' THEN r.referral_company_name END DESC,
		CASE WHEN p_sort_field = 'referral_company_name' AND p_sort_direction = 'asc' THEN r.referral_company_name END ASC,
		CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN r.status END DESC,
		CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN r.status END ASC,
		r.id DESC
	OFFSET p_offset LIMIT p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_update(p_id bigint, p_company_id bigint, p_referral_company_name text, p_referral_date timestamp with time zone, p_contact_person text, p_mobile_no text, p_email text, p_address text, p_product_interest text, p_requirement text, p_is_paid boolean, p_status text, p_referred_by bigint, p_modified_by bigint, p_modified_at timestamp without time zone, p_received_amount numeric DEFAULT 0, p_payment_mode text DEFAULT NULL::text, p_remarks text DEFAULT NULL::text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_old_status TEXT;
BEGIN
    -- Fetch the current status
    SELECT status INTO v_old_status
    FROM public.referral
    WHERE id = p_id AND company_id = p_company_id;

    -- Insert into referral_status_history only if the status has changed
    IF TRIM(p_status) IS DISTINCT FROM v_old_status THEN
        INSERT INTO public.referral_status_history (
            company_id,
            referral_id,
            old_status,
            new_status,
            created_by,
            created_at
        )
        VALUES (
            p_company_id,
            p_id,
            v_old_status,
            TRIM(p_status),
            p_modified_by,
            p_modified_at
        );
    END IF;

    -- Update the referral record
    UPDATE public.referral
    SET
        referral_company_name = TRIM(p_referral_company_name),
        referral_date = (now() AT TIME ZONE 'Asia/Kolkata'),
        contact_person = TRIM(p_contact_person),
        mobile_no = TRIM(p_mobile_no),
        email = TRIM(p_email),
        address = TRIM(p_address),
        product_interest = TRIM(p_product_interest),
        requirement = TRIM(p_requirement),
		received_amount=p_received_amount,
        is_paid = p_is_paid,
        status = TRIM(p_status),
        referred_by = p_referred_by,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_referral_verify(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.referral
    SET status = 'Accepted'
    WHERE id IN (
        SELECT unnest(string_to_array(p_ids, ',')::BIGINT[])
    )
    AND company_id = p_company_id;

    RETURN TRUE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""role""
    SET status='In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id ;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, role_name text, type_id bigint, type_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	r.id,
    r.role_name,
	r.type_id bigint,
	t.type_name text,
	r.status,
	r.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    r.created_at,
    r.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    r.modified_at
	FROM public.""role"" r
	LEFT JOIN public.""type"" t ON r.type_id = t.id
	LEFT JOIN public.""user"" u ON r.created_by = u.id
	LEFT JOIN public.""user"" u1 ON r.modified_by = u1.id
	WHERE r.id = p_id AND r.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN    
    p_filter_text = LOWER(TRIM(p_filter_text));
    total_rows := (
        SELECT COUNT(*)    
        FROM public.""role"" r
        WHERE (LOWER(TRIM(r.role_name)) LIKE '%' || p_filter_text || '%') 
          AND r.company_id = p_company_id
    );
     
    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, role_name text, type_id bigint, type_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	r.id,
    r.role_name,
	r.type_id bigint,
	t.type_name text,
	r.status,
	r.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    r.created_at,
    r.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    r.modified_at
	FROM public.""role"" r
	LEFT JOIN public.""type"" t ON r.type_id = t.id
	LEFT JOIN public.""user"" u ON r.created_by = u.id
	LEFT JOIN public.""user"" u1 ON r.modified_by = u1.id
	WHERE (LOWER(TRIM(r.role_name)) LIKE '%' || p_filter_text || '%') AND r.company_id = p_company_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN r.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN r.id END ASC,
	CASE WHEN p_sort_field = 'role_name' AND p_sort_direction = 'desc' THEN r.role_name END DESC,
	CASE WHEN p_sort_field = 'role_name' AND p_sort_direction = 'asc' THEN r.role_name END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_insert(p_company_id bigint, p_role_name text, p_type_id bigint, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""role"" (
	    company_id,
        role_name,
		type_id,
		status,
		created_by,
		created_at
    ) VALUES (
	    p_company_id,
        TRIM(p_role_name),
		p_type_id,
		p_status,
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	r.id,
    r.role_name
	FROM public.""role"" r
	WHERE r.company_id = p_company_id AND status='Active'
	ORDER BY r.role_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_permission_all_get(p_company_id bigint, p_role_id bigint, p_module_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, role_id bigint, role_name text, module_id bigint, module_name text, option_id bigint, option_name text, ""grant"" boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT 
    COALESCE(rp.id, 0) AS id,
    r.id AS role_id,
    r.role_name,
    m.id AS module_id,
    m.module_name,
    o.id AS option_id,
    o.option_name,
    COALESCE(rp.""grant"", false) AS ""grant"",
    rp.created_by,
    cu.first_name AS created_by_first_name,
    cu.last_name AS created_by_last_name,
    cu.user_name AS created_by_user_name,
    rp.created_at,
    rp.modified_by,
    mu.first_name AS modified_by_first_name,
    mu.last_name AS modified_by_last_name,
    mu.user_name AS modified_by_user_name,
    rp.modified_at
  FROM public.role r
  CROSS JOIN public.option o
  LEFT JOIN public.module m ON o.module_id = m.id
  LEFT JOIN public.role_permission rp 
    ON rp.role_id = r.id AND rp.option_id = o.id AND rp.company_id = p_company_id
  LEFT JOIN public.""user"" cu ON rp.created_by = cu.id
  LEFT JOIN public.""user"" mu ON rp.modified_by = mu.id
  WHERE r.company_id = p_company_id
    AND r.id = p_role_id
    AND (p_module_id IS NULL OR m.id = p_module_id)
  ORDER BY r.role_name, m.module_name, o.option_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_permission_all_insert(p_company_id bigint, p_role_id bigint, p_grant boolean, p_user_id bigint, p_created_at timestamp without time zone, p_module_id bigint DEFAULT NULL::bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_success boolean;
BEGIN
  -- Step 1: Update existing role_permission
  UPDATE public.role_permission rp
  SET ""grant"" = p_grant,
      created_by = p_user_id,
      created_at = p_created_at
  WHERE rp.role_id = p_role_id
    AND rp.company_id = p_company_id
    AND (
      p_module_id IS NULL OR 
      EXISTS (
        SELECT 1 FROM public.option o 
        WHERE o.id = rp.option_id AND o.module_id = p_module_id
      )
    );

  -- Step 2: Insert missing role_permission
  INSERT INTO public.role_permission (
    role_id,
    option_id,
    ""grant"",
    created_by,
    created_at,
    company_id
  )
  SELECT
    p_role_id,
    o.id,
    p_grant,
    p_user_id,
    p_created_at,
    p_company_id
  FROM public.option o
  WHERE (p_module_id IS NULL OR o.module_id = p_module_id)
    AND NOT EXISTS (
      SELECT 1
      FROM public.role_permission rp
      WHERE rp.role_id = p_role_id
        AND rp.option_id = o.id
        AND rp.company_id = p_company_id
    );

  -- Step 3: Call child function to insert user_permissions
  v_success := public.func_user_permission_from_role_insert(
    p_company_id,
    p_role_id,
    p_user_id,
    p_created_at,
    p_grant
  );

  RETURN v_success;

EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in func_role_permission_all_insert: %', SQLERRM;
  RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_permission_insert_or_update(p_id bigint, p_company_id bigint, p_role_id bigint, p_option_id bigint, p_grant boolean, p_user_id bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Step 1: Insert or update role_permission
  IF p_id IS NOT NULL AND EXISTS (
    SELECT 1
    FROM public.role_permission
    WHERE id = p_id
      AND company_id = p_company_id
  ) THEN
    -- Update by id
    UPDATE public.role_permission
    SET ""grant"" = p_grant,
        modified_by = p_user_id,
        modified_at = p_created_at
    WHERE id = p_id;
  ELSE
    -- Insert or update by (role_id, option_id)
    IF EXISTS (
      SELECT 1
      FROM public.role_permission
      WHERE role_id = p_role_id
        AND option_id = p_option_id
        AND company_id = p_company_id
    ) THEN
      -- Update existing record
      UPDATE public.role_permission
      SET ""grant"" = p_grant,
          modified_by = p_user_id,
          modified_at = p_created_at
      WHERE role_id = p_role_id
        AND option_id = p_option_id
        AND company_id = p_company_id;
    ELSE
      -- Insert new record
      INSERT INTO public.role_permission (
        role_id,
        option_id,
        ""grant"",
        created_by,
        created_at,
        company_id
      )
      VALUES (
        p_role_id,
        p_option_id,
        p_grant,
        p_user_id,
        p_created_at,
        p_company_id
      );
    END IF;
  END IF;

  -- Step 2: Insert or update user_permission for all users having this role
  INSERT INTO public.user_permission (
    user_id,
    option_id,
    ""grant"",
    created_by,
    created_at,
    company_id
  )
  SELECT
    u.id AS user_id,
    p_option_id,
    p_grant,
    p_user_id,
    p_created_at,
    p_company_id
  FROM public.""user"" u
  WHERE u.role_id = p_role_id
    AND u.company_id = p_company_id
ON CONFLICT (user_id, option_id, company_id)
DO UPDATE SET
  ""grant"" = EXCLUDED.""grant"",
  modified_by = p_user_id,
  modified_at = p_created_at;

  RETURN TRUE;

EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in func_role_permission_insert_or_update: %', SQLERRM;
  RETURN FALSE;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_role_name_exist(p_id bigint, p_company_id bigint, p_role_name text)
 RETURNS TABLE(id bigint, role_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	r.id,
	r.role_name
	FROM public.""role"" r
	WHERE r.id <> p_id AND LOWER(TRIM(r.role_name)) = LOWER(TRIM(p_role_name))
	AND r.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_role_update(p_id bigint, p_company_id bigint, p_role_name text, p_type_id bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""role"" SET
	company_id = p_company_id,
	role_name = TRIM(p_role_name),
	type_id = p_type_id,
	status=p_status,
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_by_company_id_get(p_company_id bigint)
 RETURNS TABLE(id bigint, key text, value text, type text, description text, status text, company_id bigint, company_name text, business_config jsonb, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	sc.id,
    sc.key,
	sc.value,
	sc.type,
	sc.description,
	sc.status,
	sc.company_id,
	c.company_name,
	 jsonb_build_object(
            'business_config',
            CASE 
                WHEN func_is_valid_json(sc.business_config) THEN sc.business_config::jsonb
                ELSE '{}'::jsonb
            END
        ) AS business_config,
	sc.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    sc.created_at,
    sc.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    sc.modified_at
	FROM public.""site_config"" sc
	LEFT JOIN public.""user"" u ON sc.created_by = u.id
	LEFT JOIN public.""company"" c ON sc.company_id = c.id
	LEFT JOIN public.""user"" u1 ON sc.modified_by = u1.id
	WHERE sc.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""site_config""
    SET Status='In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id);
	---AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, key text, value text, type text, description text, status text, company_id bigint, company_name text, business_config jsonb, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
	SELECT
		sc.id,
		sc.key,
		sc.value,
		sc.type,
		sc.description,
		sc.status,
		sc.company_id,
		c.company_name,
		jsonb_build_object(
            'business_config',
            CASE 
                WHEN func_is_valid_json(sc.business_config) THEN sc.business_config::jsonb
                ELSE '{}'::jsonb
            END
        ) AS business_config,
		sc.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		sc.created_at,
		sc.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		sc.modified_at
	FROM public.site_config sc
	LEFT JOIN public.""user"" u ON sc.created_by = u.id
	LEFT JOIN public.""user"" u1 ON sc.modified_by = u1.id
	LEFT JOIN public.company c ON sc.company_id = c.id
	WHERE sc.id = p_id AND sc.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_get_count(p_filter_text text, p_company_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows bigint;
BEGIN	
	p_filter_text := LOWER(TRIM(p_filter_text));

	SELECT COUNT(*) INTO total_rows
	FROM public.site_config sc
	WHERE LOWER(TRIM(sc.key)) LIKE '%' || p_filter_text || '%'
	  AND (p_company_id IS NULL OR sc.company_id = p_company_id);

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_get_page(p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_company_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, key text, value text, type text, description text, status text, company_id bigint, company_name text, business_config jsonb, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text := LOWER(TRIM(p_filter_text));
	p_sort_field := LOWER(TRIM(p_sort_field));
	p_sort_direction := LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
	SELECT
		sc.id,
		sc.key,
		sc.value,
		sc.type,
		sc.description,
		sc.status,
		sc.company_id,
		c.company_name,
		jsonb_build_object(
            'business_config',
            CASE 
                WHEN func_is_valid_json(sc.business_config) THEN sc.business_config::jsonb
                ELSE '{}'::jsonb
            END
        ) AS business_config,
		sc.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		sc.created_at,
		sc.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		sc.modified_at
	FROM public.site_config sc
	LEFT JOIN public.""user"" u ON sc.created_by = u.id
	LEFT JOIN public.""user"" u1 ON sc.modified_by = u1.id
	LEFT JOIN public.company c ON sc.company_id = c.id
	WHERE LOWER(TRIM(sc.key)) LIKE '%' || p_filter_text || '%'
	  AND (p_company_id IS NULL OR sc.company_id = p_company_id)
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN sc.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN sc.id END ASC,
		CASE WHEN p_sort_field = 'key' AND p_sort_direction = 'desc' THEN sc.key END DESC,
		CASE WHEN p_sort_field = 'key' AND p_sort_direction = 'asc' THEN sc.key END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_insert(p_company_id bigint, p_key text, p_value text, p_type text, p_description text, p_status text, p_business_config jsonb, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""site_config"" (
		company_id,
        key,
		value,
		type,
		description,
		status,
		business_config,
		created_by,
		created_at
    ) VALUES (
	    p_company_id,
        TRIM(p_key),
		TRIM(p_value),
		TRIM(p_type),
		TRIM(p_description),
		TRIM(p_status),
		p_business_config,
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_site_config_update(p_id bigint, p_company_id bigint, p_key text, p_value text, p_type text, p_description text, p_status text, p_business_config jsonb, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""site_config"" SET 
	company_id = p_company_id,
	key = TRIM(p_key),
	value = TRIM(p_value),
	type = TRIM(p_type),
	description = TRIM(p_description),
	status = TRIM(p_status),
	business_config = p_business_config,
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""state""
	SET Status='In-active'
	WHERE company_id = p_company_id
	  AND id IN (
		  SELECT id::bigint 
		  FROM unnest(string_to_array(p_ids, ',')) AS id
	  );

    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, state_name text, state_code text, country_id bigint, country_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		s.id, 
		s.state_name, 
		s.state_code,
		s.country_id,
		c.country_name,
		s.status,
		s.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		s.created_at,
		s.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		s.modified_at
	FROM public.""state"" s
	LEFT JOIN public.""country"" c ON s.country_id = c.id
	LEFT JOIN public.""user"" u ON s.created_by = u.id
	LEFT JOIN public.""user"" u1 ON s.modified_by = u1.id
	WHERE s.id = p_id
	  AND s.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
	total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	
	total_rows = (
		SELECT COUNT(*)	
		FROM public.""state"" s
		LEFT JOIN public.""country"" c ON s.country_id = c.id
		WHERE s.company_id = p_company_id
		  AND (LOWER(TRIM(s.state_name)) LIKE '%' || p_filter_text || '%'
			  OR LOWER(TRIM(c.country_name)) LIKE '%' || p_filter_text || '%'
			  )
	);  

	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, state_name text, state_code text, country_id bigint, country_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
    SELECT
		s.id, 
		s.state_name, 
		s.state_code, 
		s.country_id,
		c.country_name,
		s.status,
		s.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
		s.created_at,
		s.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
		s.modified_at	
	FROM public.""state"" s
	LEFT JOIN public.""country"" c ON s.country_id = c.id
	LEFT JOIN public.""user"" u ON s.created_by = u.id
	LEFT JOIN public.""user"" u1 ON s.modified_by = u1.id
	WHERE s.company_id = p_company_id
	  AND (LOWER(TRIM(s.state_name)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.country_name)) LIKE '%' || p_filter_text || '%'
		  )
	ORDER BY 
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN s.id END DESC,
		CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN s.id END ASC,
		CASE WHEN p_sort_field = 'state_name' AND p_sort_direction = 'desc' THEN s.state_name END DESC,
		CASE WHEN p_sort_field = 'state_name' AND p_sort_direction = 'asc' THEN s.state_name END ASC,
		CASE WHEN p_sort_field = 'state_code' AND p_sort_direction = 'desc' THEN s.state_code END DESC,
		CASE WHEN p_sort_field = 'state_code' AND p_sort_direction = 'asc' THEN s.state_code END ASC,
		CASE WHEN p_sort_field = 'country_name' AND p_sort_direction = 'desc' THEN c.country_name END DESC,
		CASE WHEN p_sort_field = 'country_name' AND p_sort_direction = 'asc' THEN c.country_name END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_insert(p_company_id bigint, p_state_name text, p_state_code text, p_country_id bigint, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""state"" (
        company_id,
        state_name,
		state_code, 
		country_id,
		status,
		created_by,
		created_at		
    ) VALUES (
        p_company_id,
        TRIM(p_state_name),
		TRIM(p_state_code), 
		p_country_id,
		p_status,
		p_created_by,
		p_created_at	
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_lookup(p_company_id bigint, p_country_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 	
    SELECT
        s.id,
        s.state_name
    FROM public.""state"" s
    WHERE s.country_id = p_country_id AND status='Active'
      AND s.company_id = p_company_id -- Only include this if your table has company_id
    ORDER BY s.state_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_state_update(p_id bigint, p_company_id bigint, p_state_name text, p_state_code text, p_country_id bigint, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""state"" 
    SET 
		state_name = TRIM(p_state_name),
		state_code = TRIM(p_state_code), 
		country_id = p_country_id,
		status=p_status,
		modified_by = p_modified_by,
		modified_at = p_modified_at	
    WHERE id = p_id
      AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    DELETE 
	FROM public.""study_notes""
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, description jsonb, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
   SELECT
	sn.id,
	sn.course_id, 
	c.course_name,
    sn.title,
	      jsonb_build_object(
            'code',
            CASE 
                WHEN func_is_valid_json(sn.description) THEN sn.description::jsonb
                ELSE '{}'::jsonb
            END
        ) AS description,
	sn.status,
	sn.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    sn.created_at,
    sn.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    sn.modified_at
	FROM public.""study_notes"" sn
	LEFT JOIN public.""course"" c ON sn.course_id = c.id
	LEFT JOIN public.""user"" u ON sn.created_by = u.id
	LEFT JOIN public.""user"" u1 ON sn.modified_by = u1.id
	WHERE sn.id = p_id AND sn.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, description jsonb, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN

	RETURN QUERY 	
    SELECT
	sn.id,
	sn.course_id, 
	c.course_name,
    sn.title,
	      jsonb_build_object(
            'code',
            CASE 
                WHEN func_is_valid_json(sn.description) THEN sn.description::jsonb
                ELSE '{}'::jsonb
            END
        ) AS description,
    sn.status,
	sn.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    sn.created_at,
    sn.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    sn.modified_at
	FROM public.""study_notes"" sn
	LEFT JOIN public.""course"" c ON sn.course_id = c.id
	LEFT JOIN public.""user"" u ON sn.created_by = u.id
	LEFT JOIN public.""user"" u1 ON sn.modified_by = u1.id
	WHERE sn.company_id = p_company_id
	ORDER BY sn.title ASC;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
BEGIN
    SELECT COUNT(*) INTO total_rows
    FROM public.""study_notes"" sn
	LEFT JOIN public.""course"" c ON sn.course_id = c.id
    LEFT JOIN public.""user"" u ON sn.created_by = u.id
    LEFT JOIN public.""user"" u1 ON sn.modified_by = u1.id
    WHERE (LOWER(TRIM(sn.title)) LIKE '%' || LOWER(TRIM(p_filter_text)) || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || LOWER(TRIM(p_filter_text)) || '%'
		  )
	AND sn.company_id = p_company_id;

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, description jsonb, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	sn.id,
	sn.course_id, 
	c.course_name,
    sn.title,
	      jsonb_build_object(
            'code',
            CASE 
                WHEN func_is_valid_json(sn.description) THEN sn.description::jsonb
                ELSE '{}'::jsonb
            END
        ) AS description,
    sn.status,
	sn.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    sn.created_at,
    sn.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    sn.modified_at
	FROM public.""study_notes"" sn
	LEFT JOIN public.""course"" c ON sn.course_id = c.id
	LEFT JOIN public.""user"" u ON sn.created_by = u.id
	LEFT JOIN public.""user"" u1 ON sn.modified_by = u1.id
	WHERE (LOWER(TRIM(sn.title)) LIKE '%' || p_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
		  ) AND sn.company_id = p_company_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN sn.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN sn.id END ASC,
	CASE WHEN p_sort_field = 'title' AND p_sort_direction = 'desc' THEN sn.title END DESC,
	CASE WHEN p_sort_field = 'title' AND p_sort_direction = 'asc' THEN sn.title END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_insert(p_company_id bigint, p_course_id bigint, p_title text, p_description text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""study_notes"" (
	    company_id,
		course_id,
        title,
		description,
        status,
		created_by,
		created_at
    ) VALUES (
	    p_company_id,
		p_course_id,
        TRIM(p_title),
		TRIM(p_description),
        p_status,
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_study_notes_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_title text, p_description text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""study_notes""
    SET
	    company_id = p_company_id,
        course_id = p_course_id,
        title = TRIM(p_title),
		description = TRIM(p_description),
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""type""
    SET status = 'In-active'
    WHERE id IN (
        SELECT id::bigint 
        FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, type_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		t.id,
        t.type_name,
        t.status,
		t.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
        t.created_at,
        t.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
        t.modified_at
	FROM public.""type"" t
	LEFT JOIN public.""user"" u ON t.created_by = u.id
	LEFT JOIN public.""user"" u1 ON t.modified_by = u1.id
	WHERE t.id = p_id; --AND t.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN    
    p_filter_text = LOWER(TRIM(p_filter_text));
    
    total_rows := (
        SELECT COUNT(*)    
        FROM public.""type"" t
        WHERE (LOWER(TRIM(t.type_name)) LIKE '%' || p_filter_text || '%') 
          --AND t.company_id = p_company_id
    );
     
    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, type_name text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));

	RETURN QUERY 	
    SELECT
		t.id,
        t.type_name,
        t.status,
		t.created_by,
		u.first_name,
		u.last_name,
		u.user_name,
        t.created_at,
        t.modified_by,
		u1.first_name,
		u1.last_name,
		u1.user_name,
        t.modified_at
	FROM public.""type"" t
	LEFT JOIN public.""user"" u ON t.created_by = u.id
	LEFT JOIN public.""user"" u1 ON t.modified_by = u1.id
	WHERE (LOWER(TRIM(t.type_name)) LIKE '%' || p_filter_text || '%') 
	--AND t.company_id = p_company_id
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN t.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN t.id END ASC,
	CASE WHEN p_sort_field = 'type_name' AND p_sort_direction = 'desc' THEN t.type_name END DESC,
	CASE WHEN p_sort_field = 'type_name' AND p_sort_direction = 'asc' THEN t.type_name END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_insert(p_company_id bigint, p_type_name text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
	INSERT INTO public.""type"" (
		company_id,
		type_name,
		status,
		created_by,
		created_at
	) VALUES (
		p_company_id,
		TRIM(p_type_name),
		TRIM(p_status),
		p_created_by,
		p_created_at
	);

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_lookup(p_company_id bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		t.id,
        t.type_name
	FROM public.""type"" t
	WHERE status='Active' --AND t.company_id = p_company_id
	ORDER BY t.type_name;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_name_exist(p_id bigint, p_company_id bigint, p_type_name text)
 RETURNS TABLE(id bigint, type_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
		t.id,
		t.type_name
	FROM public.""type"" t
	WHERE t.id <> p_id 
	  AND LOWER(TRIM(t.type_name)) = LOWER(TRIM(p_type_name))
	  AND t.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_type_update(p_id bigint, p_company_id bigint, p_type_name text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
	UPDATE public.""type""
	SET
		type_name = TRIM(p_type_name),
		status = TRIM(p_status),
		modified_by = p_modified_by,
		modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

	RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""user""
    SET status='In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
       AND company_id = p_company_id;
    -- Return true to indicate success
    RETURN true;
EXCEPTION
    WHEN others THEN
        -- Handle any exceptions (e.g., violation of constraints)
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""user_device_mapping"" 
    SET Status='In-active'
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_exist(p_company_id bigint, p_device_id text, p_user_name text)
 RETURNS TABLE(device_id text, user_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        udm.device_id,
        TRIM(LOWER(u.user_name)) AS user_name
    FROM public.""user"" u
    JOIN public.user_device_mapping udm
        ON udm.user_id = u.id
       AND udm.company_id = u.company_id
    WHERE udm.device_id = p_device_id
      AND u.company_id = p_company_id
      AND TRIM(LOWER(u.user_name)) = TRIM(LOWER(p_user_name))
      AND u.status = 'Active'
      AND udm.status = 'Active';
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, user_id bigint, name text, device_id text, device_info text, status text, remarks text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        udm.id,
        udm.user_id,
        COALESCE(u.first_name, '') || ' ' || COALESCE(u.last_name, '') AS name,
        udm.device_id,
        udm.device_info,
        udm.status,
        udm.remarks,
        udm.created_by,
        cu.first_name,
        cu.last_name,
        cu.user_name,
        udm.created_at,
        udm.modified_by,
        mu.first_name,
        mu.last_name,
        mu.user_name,
        udm.modified_at
    FROM public.user_device_mapping udm
    LEFT JOIN public.""user"" u ON udm.user_id = u.id
    LEFT JOIN public.""user"" cu ON udm.created_by = cu.id
    LEFT JOIN public.""user"" mu ON udm.modified_by = mu.id
    WHERE udm.company_id = p_company_id
      AND udm.id = p_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_get_count(p_company_id bigint, p_filter_text text, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    total_rows bigint;
    v_from_date date := p_from_date::date;
    v_to_date date := p_to_date::date;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));

    total_rows := (
        SELECT COUNT(*)
        FROM public.user_device_mapping udm
        LEFT JOIN public.""user"" u ON udm.user_id = u.id
        WHERE udm.company_id = p_company_id AND udm.status='Active'
          AND (p_user_id IS NULL OR udm.user_id = p_user_id)
          AND udm.created_at::date BETWEEN v_from_date AND v_to_date
          AND (
              LOWER(COALESCE(udm.device_id, '')) LIKE '%' || p_filter_text || '%' OR
              LOWER(COALESCE(udm.device_info, '')) LIKE '%' || p_filter_text || '%' OR
              LOWER(COALESCE(udm.status, '')) LIKE '%' || p_filter_text || '%' OR
              LOWER(COALESCE(udm.remarks, '')) LIKE '%' || p_filter_text || '%' OR
              LOWER(COALESCE(u.first_name, '')) LIKE '%' || p_filter_text || '%' OR
              LOWER(COALESCE(u.last_name, '')) LIKE '%' || p_filter_text || '%'
          )
    );

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_from_date date DEFAULT CURRENT_DATE, p_to_date date DEFAULT CURRENT_DATE, p_user_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, user_id bigint, name text, device_id text, device_info text, status text, remarks text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_from_date date := p_from_date::date;
    v_to_date date := p_to_date::date;
BEGIN
    p_filter_text := LOWER(TRIM(p_filter_text));
    p_sort_field := LOWER(TRIM(p_sort_field));
    p_sort_direction := LOWER(TRIM(p_sort_direction));

    RETURN QUERY
    SELECT
        udm.id,
        udm.user_id,
        COALESCE(u.first_name, '') || ' ' || COALESCE(u.last_name, '') AS name,
        udm.device_id,
        udm.device_info,
        udm.status,
        udm.remarks,
        udm.created_by,
        cu.first_name,
        cu.last_name,
        cu.user_name,
        udm.created_at,
        udm.modified_by,
        mu.first_name,
        mu.last_name,
        mu.user_name,
        udm.modified_at
    FROM public.user_device_mapping udm
    LEFT JOIN public.""user"" u ON udm.user_id = u.id
    LEFT JOIN public.""user"" cu ON udm.created_by = cu.id
    LEFT JOIN public.""user"" mu ON udm.modified_by = mu.id
    WHERE udm.company_id = p_company_id AND udm.status='Active'
      AND (p_user_id IS NULL OR udm.user_id = p_user_id)
      AND udm.created_at::date BETWEEN v_from_date AND v_to_date
      AND (
          LOWER(COALESCE(udm.device_id, '')) LIKE '%' || p_filter_text || '%' OR
          LOWER(COALESCE(udm.device_info, '')) LIKE '%' || p_filter_text || '%' OR
          LOWER(COALESCE(udm.status, '')) LIKE '%' || p_filter_text || '%' OR
          LOWER(COALESCE(udm.remarks, '')) LIKE '%' || p_filter_text || '%' OR
          LOWER(COALESCE(u.first_name, '')) LIKE '%' || p_filter_text || '%' OR
          LOWER(COALESCE(u.last_name, '')) LIKE '%' || p_filter_text || '%'
      )
    ORDER BY
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN udm.id END DESC,
        CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN udm.id END ASC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN udm.status END DESC,
        CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN udm.status END ASC,
        CASE WHEN p_sort_field = 'created_at' AND p_sort_direction = 'desc' THEN udm.created_at END DESC,
        CASE WHEN p_sort_field = 'created_at' AND p_sort_direction = 'asc' THEN udm.created_at END ASC
    OFFSET p_offset
    LIMIT p_limit;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_mapping_exist(p_company_id bigint, p_user_id bigint, p_device_id character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    exists_flag BOOLEAN;
BEGIN
    SELECT TRUE
    INTO exists_flag
    FROM user_device_mapping
    WHERE user_id = p_user_id 
      AND device_id = p_device_id
      AND company_id = p_company_id
      AND status='Active'
    LIMIT 1;

    RETURN COALESCE(exists_flag, FALSE);
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_mapping_insert(p_company_id bigint, p_user_id bigint, p_device_id character varying, p_device_info text, p_created_by bigint)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    is_inserted BOOLEAN;
BEGIN
    -- Try inserting
    BEGIN
        INSERT INTO user_device_mapping (
            user_id, device_id,device_info, company_id, created_by, created_at
        )
        VALUES (
            p_user_id, p_device_id,p_device_info, p_company_id, p_created_by, CURRENT_TIMESTAMP
        );
        is_inserted := TRUE;  -- Insert success
    EXCEPTION WHEN unique_violation THEN
        -- Conflict occurred, so update instead
        UPDATE user_device_mapping
        SET device_id = p_device_id,
            modified_by = p_created_by,
            modified_at = CURRENT_TIMESTAMP
        WHERE user_id = p_user_id;
        is_inserted := FALSE;  -- Updated existing
    END;

    RETURN is_inserted;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_device_update(p_id bigint, p_company_id bigint, p_user_id bigint, p_status text, p_remarks text, p_modified_by bigint, p_modified_at timestamp with time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""user_device_mapping"" SET 
      status =  TRIM(p_status),
	  remarks =  TRIM(p_remarks),      
	  modified_by = p_modified_by,
	  modified_at = p_modified_at	
	WHERE id = p_id AND user_id=p_user_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_email_exist(p_id bigint, p_company_id bigint, p_email text)
 RETURNS TABLE(id bigint, email text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	u.id,
	u.email
	FROM public.""user"" u
	WHERE u.id <> p_id AND LOWER(TRIM(u.email)) = LOWER(TRIM(p_email))
	AND u.company_id = p_company_id AND status='Active';
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_email_exist_userid(p_id bigint, p_company_id bigint, p_email text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_user_id bigint;
BEGIN
    SELECT u.id INTO v_user_id
    FROM public.""user"" u
    WHERE u.id <> p_id
      AND LOWER(TRIM(u.email)) = LOWER(TRIM(p_email))
      AND u.company_id = p_company_id
      AND u.status = 'Active'
    LIMIT 1;

    IF v_user_id IS NOT NULL THEN
        RETURN v_user_id::text;
    ELSE
        RETURN 'false';
    END IF;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, mobile_no text, user_name text, password text, status text, role_id bigint, role_name text, type_id bigint, type_name text, image_url text, code text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	u.id,
    u.first_name,
    u.last_name,
    u.email,
    u.mobile_no,
    u.user_name,
    u.password,
    u.status,
	u.role_id,
	r.role_name,
	u.type_id,
	t.type_name,
	u.image_url,
	u.code,
	u.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    u.created_at,
    u.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    u.modified_at
	FROM public.""user"" u
	LEFT JOIN public.""role"" r ON u.role_id = r.id
	LEFT JOIN public.""type"" t ON u.type_id = t.id
	LEFT JOIN public.""user"" u1 ON u.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON u.modified_by = u2.id
	WHERE u.id = p_id
    AND u.company_id = p_company_id;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_get_by_user_name(p_company_id bigint, p_user_name text)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, mobile_no text, user_name text, password text, status text, role_id bigint, role_name text, code text, affiliate_id bigint, type_id bigint, type_name text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	u.id,
	u.first_name,
    u.last_name,
    u.email,
    u.mobile_no,
    u.user_name,
    u.password,
    u.status,
	u.role_id,
	r.role_name,
	u.code,
	u.affiliate_id,
	u.type_id,
	t.type_name,
	u.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    u.created_at,
    u.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    u.modified_at
	FROM public.""user"" u
	LEFT JOIN public.""role"" r ON r.id = u.role_id
	LEFT JOIN public.""type"" t ON t.id = u.type_id
	LEFT JOIN public.""user"" u1 ON u.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON u.modified_by = u2.id
	WHERE u.company_id = p_company_id AND LOWER(TRIM(u.user_name)) = LOWER(TRIM(p_user_name));
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE total_rows bigint;
BEGIN	
	p_filter_text = LOWER(TRIM(p_filter_text));
	total_rows = (SELECT
	COUNT(*)	
	FROM public.""user"" u
	LEFT JOIN public.""role"" r ON u.role_id = r.id
	 WHERE u.company_id = p_company_id  
          AND (LOWER(TRIM(u.first_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.last_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.email)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.mobile_no)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.user_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(r.role_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.status)) LIKE '%' || p_filter_text || '%'));  
	RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, first_name text, last_name text, email text, mobile_no text, user_name text, password text, status text, role_id bigint, role_name text, type_id bigint, type_name text, image_url text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	u.id,
    u.first_name,
    u.last_name,
    u.email,
    u.mobile_no,
    u.user_name,
    u.password,
    u.status,
	u.role_id,
	r.role_name,
	u.type_id,
	t.type_name,
	u.image_url,
	u.created_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    u.created_at,
    u.modified_by,
	u2.first_name,
	u2.last_name,
	u2.user_name,
    u.modified_at
	FROM public.""user"" u
	LEFT JOIN public.""role"" r ON u.role_id = r.id
	LEFT JOIN public.""type"" t ON u.type_id = t.id
	LEFT JOIN public.""user"" u1 ON u.created_by = u1.id
	LEFT JOIN public.""user"" u2 ON u.modified_by = u2.id
	WHERE u.company_id = p_company_id AND  (LOWER(TRIM(u.first_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.last_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.email)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.mobile_no)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.user_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(r.role_name)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(u.status)) LIKE '%' || p_filter_text || '%')
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN u.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN u.id END ASC,
	CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'desc' THEN u.first_name END DESC,
	CASE WHEN p_sort_field = 'first_name' AND p_sort_direction = 'asc' THEN u.first_name END ASC,
	CASE WHEN p_sort_field = 'last_name' AND p_sort_direction = 'desc' THEN u.last_name END DESC,
	CASE WHEN p_sort_field = 'last_name' AND p_sort_direction = 'asc' THEN u.last_name END ASC,
	CASE WHEN p_sort_field = 'email' AND p_sort_direction = 'desc' THEN u.email END DESC,
	CASE WHEN p_sort_field = 'email' AND p_sort_direction = 'asc' THEN u.email END ASC,
	CASE WHEN p_sort_field = 'mobile_no' AND p_sort_direction = 'desc' THEN u.mobile_no END DESC,
	CASE WHEN p_sort_field = 'mobile_no' AND p_sort_direction = 'asc' THEN u.mobile_no END ASC,
	CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'desc' THEN u.user_name END DESC,
	CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'asc' THEN u.user_name END ASC,
	CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'desc' THEN u.status END DESC,
	CASE WHEN p_sort_field = 'status' AND p_sort_direction = 'asc' THEN u.status END ASC
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_insert(p_company_id bigint, p_first_name text, p_last_name text, p_email text, p_mobile_no text, p_user_name text, p_password text, p_role_id bigint, p_image_url text, p_status text, p_code text, p_type_id bigint, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_type_id bigint;
BEGIN
	SELECT t.id
	INTO v_type_id
	FROM role r
	INNER JOIN type t ON r.type_id = t.id
	WHERE r.id = p_role_id
	  AND r.company_id = p_company_id
	LIMIT 1;

	IF p_type_id IS NULL OR p_type_id = 0 THEN
		p_type_id := v_type_id;
	END IF;
    -- Insert the user into the user table
    INSERT INTO public.""user"" (
	    company_id,
        first_name, 
        last_name, 
        email, 
        mobile_no, 
        user_name, 
        password, 
		role_id,
		image_url,
        status,
		code,
		type_id,
		created_by,
		created_at
    ) VALUES (
	    p_company_id,
        TRIM(p_first_name), 
        TRIM(p_last_name), 
        TRIM(p_email), 
        TRIM(p_mobile_no), 
        TRIM(p_user_name), 
        p_password, 
		p_role_id,
		p_image_url,
        TRIM(p_status),
		p_code,
		p_type_id,
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_insert_return_id(p_company_id bigint, p_first_name text, p_last_name text, p_email text, p_mobile_no text, p_user_name text, p_password text, p_role_id bigint, p_image_url text, p_status text, p_code text, p_type_id bigint, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_type_id bigint;
    v_user_id bigint;
BEGIN
    -- Get the type_id from the role if not provided
    SELECT t.id
    INTO v_type_id
    FROM role r
    INNER JOIN type t ON r.type_id = t.id
    WHERE r.id = p_role_id
      AND r.company_id = p_company_id
    LIMIT 1;

    IF p_type_id IS NULL OR p_type_id = 0 THEN
        p_type_id := v_type_id;
    END IF;

    -- Insert user and return the newly generated ID
    INSERT INTO public.""user"" (
        company_id,
        first_name,
        last_name,
        email,
        mobile_no,
        user_name,
        password,
        role_id,
        image_url,
        status,
        code,
        type_id,
        created_by,
        created_at
    )
    VALUES (
        p_company_id,
        TRIM(p_first_name),
        TRIM(p_last_name),
        TRIM(p_email),
        TRIM(p_mobile_no),
        TRIM(p_user_name),
        p_password,
        p_role_id,
        p_image_url,
        TRIM(p_status),
        p_code,
        p_type_id,
        p_created_by,
        p_created_at
    )
    RETURNING id INTO v_user_id;

    RETURN v_user_id;

EXCEPTION WHEN OTHERS THEN
    -- Return -1 on any error (you can change this behavior)
    RETURN -1;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_lookup(p_company_id bigint, p_module_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, text text)
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_role_ids text[] := NULL;
BEGIN
    -- Step 1: Get role_ids if module_id is provided
    IF p_module_id IS NOT NULL THEN
        SELECT ARRAY(
            SELECT rmm.role_id
            FROM public.role_module_mapping rmm
            WHERE rmm.module_id = p_module_id
              AND rmm.company_id = p_company_id
        ) INTO v_role_ids;

        -- Step 2: If mapping is not found, set v_role_ids to NULL
        IF array_length(v_role_ids, 1) IS NULL THEN
            v_role_ids := NULL;
        END IF;
    END IF;

    -- Step 3: Return users based on v_role_ids
    RETURN QUERY
    SELECT
        u.id,
        u.first_name || ' ' || u.last_name || ' (' || u.id || ')' AS text
    FROM public.""user"" u
    LEFT JOIN public.""role"" r ON r.id = u.role_id
    WHERE u.company_id = p_company_id
      AND u.status = 'Active'
      --AND r.role_name <> 'Admin'
      AND (
           v_role_ids IS NULL OR u.role_id::text = ANY(v_role_ids)
      )
    ORDER BY u.first_name;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_mobile_no_exist(p_id bigint, p_company_id bigint, p_mobile_no text)
 RETURNS TABLE(id bigint, mobile_no text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	u.id,
	u.mobile_no
	FROM public.""user"" u
	WHERE u.id <> p_id AND LOWER(TRIM(u.mobile_no)) = LOWER(TRIM(p_mobile_no))
	AND u.company_id = p_company_id AND status='Active'; 
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_password_forget(p_company_id bigint, p_user_name text, p_email text, p_password text, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.""user""
    SET 
        password = p_password,
        modified_at = p_modified_at
    WHERE company_id = p_company_id AND user_name = p_user_name OR email = p_email;

    -- Check if any row was updated
    IF FOUND THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_password_update(p_id bigint, p_company_id bigint, p_password text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""user"" SET 
	company_id = P_company_id,
	password = p_password, 	
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id AND company_id = P_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.user_permission
	SET status = 'In-active'
    WHERE id IN (
        SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id
    )
    AND company_id = p_company_id;

    RETURN true;

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Delete Error in user_permission: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_from_role_insert(p_company_id bigint, p_role_id bigint, p_user_id bigint, p_created_at timestamp without time zone, p_grant boolean)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Insert or update permission entries for all users of a given role
  INSERT INTO public.user_permission (
    user_id,
    option_id,
    ""grant"",
    created_by,
    created_at,
    company_id
  )
  SELECT
    u.id AS user_id,
    rp.option_id,
    p_grant,
    p_user_id AS created_by,
    p_created_at,
    p_company_id
  FROM public.""user"" u
  JOIN public.role_permission rp
    ON rp.role_id = u.role_id
   AND rp.company_id = p_company_id
  WHERE u.role_id = p_role_id
    AND u.company_id = p_company_id
ON CONFLICT (user_id, option_id, company_id)
DO UPDATE SET
  ""grant"" = EXCLUDED.""grant"",
  modified_by = p_user_id,
  modified_at = p_created_at;

  RETURN true;

EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in user_permission insert/update: %', SQLERRM;
  RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_from_role_insert_main(p_company_id bigint, p_role_id bigint, p_user_id bigint, p_created_at timestamp without time zone, p_grant boolean)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
  -- Insert user_permission records only if NOT already present
  INSERT INTO public.user_permission (
    user_id,
    option_id,
    ""grant"",
    created_by,
    created_at,
    company_id
  )
  SELECT
    p_user_id,
    rp.option_id,
    p_grant,
    p_user_id,
    p_created_at,
    p_company_id
  FROM public.role_permission rp
  WHERE rp.role_id = p_role_id
    AND rp.company_id = p_company_id
    AND NOT EXISTS (
      SELECT 1
      FROM public.user_permission up
      WHERE up.user_id = p_user_id
        AND up.option_id = rp.option_id
        AND up.company_id = p_company_id
    );

  RETURN true;

EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error in user_permission insert: %', SQLERRM;
  RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, user_id bigint, user_name text, module_id bigint, module_name text, option_id bigint, option_name text, ""grant"" boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  RETURN QUERY
  SELECT
    up.id,
    up.user_id,
    u.user_name,
    o.module_id,
    m.module_name,
    up.option_id,
    o.option_name,
    up.""grant"",
    up.created_by,
    cu.first_name,
    cu.last_name,
    cu.user_name,
    up.created_at,
    up.modified_by,
    mu.first_name,
    mu.last_name,
    mu.user_name,
    up.modified_at
  FROM public.user_permission up
  LEFT JOIN public.user u ON up.user_id = u.id
  LEFT JOIN public.option o ON up.option_id = o.id
  LEFT JOIN public.module m ON o.module_id = m.id
  LEFT JOIN public.user cu ON up.created_by = cu.id
  LEFT JOIN public.user mu ON up.modified_by = mu.id
  WHERE up.id = p_id AND up.company_id = p_company_id;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_get_count(p_company_id bigint, p_filter_text text, p_user_id bigint DEFAULT NULL::bigint, p_module_id bigint DEFAULT NULL::bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_count bigint;
BEGIN
    p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));

    SELECT COUNT(*)
    INTO v_count
    FROM public.user_permission up
    LEFT JOIN public.user u ON up.user_id = u.id
    LEFT JOIN public.option o ON up.option_id = o.id
    LEFT JOIN public.module m ON o.module_id = m.id
    WHERE up.company_id = p_company_id
      AND (
        LOWER(COALESCE(u.user_name, '')) LIKE '%' || p_filter_text || '%' OR
        LOWER(COALESCE(o.option_name, '')) LIKE '%' || p_filter_text || '%' OR
        LOWER(COALESCE(m.module_name, '')) LIKE '%' || p_filter_text || '%'
      )
      AND (p_user_id IS NULL OR u.id = p_user_id)
      AND (p_module_id IS NULL OR m.id = p_module_id);

    RETURN v_count;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint, p_user_id bigint DEFAULT NULL::bigint, p_module_id bigint DEFAULT NULL::bigint)
 RETURNS TABLE(id bigint, user_id bigint, user_name text, module_id bigint, module_name text, option_id bigint, option_name text, ""grant"" boolean, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
  p_filter_text := LOWER(TRIM(COALESCE(p_filter_text, '')));
  p_sort_field := LOWER(TRIM(COALESCE(p_sort_field, 'id')));
  p_sort_direction := LOWER(TRIM(COALESCE(p_sort_direction, 'asc')));

  RETURN QUERY
  SELECT
    up.id,
    up.user_id,
    u.user_name,
    o.module_id,
    m.module_name,
    up.option_id,
    o.option_name,
    up.grant,
    up.created_by,
    cu.first_name,
    cu.last_name,
    cu.user_name,
    up.created_at,
    up.modified_by,
    mu.first_name,
    mu.last_name,
    mu.user_name,
    up.modified_at
  FROM public.user_permission up
  LEFT JOIN public.user u ON up.user_id = u.id
  LEFT JOIN public.option o ON up.option_id = o.id
  LEFT JOIN public.module m ON o.module_id = m.id
  LEFT JOIN public.user cu ON up.created_by = cu.id
  LEFT JOIN public.user mu ON up.modified_by = mu.id
  WHERE (
    LOWER(COALESCE(u.user_name, '')) LIKE '%' || p_filter_text || '%' OR
    LOWER(COALESCE(o.option_name, '')) LIKE '%' || p_filter_text || '%' OR
    LOWER(COALESCE(m.module_name, '')) LIKE '%' || p_filter_text || '%'
  )
  AND up.company_id = p_company_id
  AND (p_user_id IS NULL OR up.user_id = p_user_id)
  AND (p_module_id IS NULL OR o.module_id = p_module_id)
  ORDER BY
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN up.id END ASC,
    CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN up.id END DESC,
    CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'asc' THEN u.user_name END ASC,
    CASE WHEN p_sort_field = 'user_name' AND p_sort_direction = 'desc' THEN u.user_name END DESC,
    CASE WHEN p_sort_field = 'module_name' AND p_sort_direction = 'asc' THEN m.module_name END ASC,
    CASE WHEN p_sort_field = 'module_name' AND p_sort_direction = 'desc' THEN m.module_name END DESC,
    CASE WHEN p_sort_field = 'option_name' AND p_sort_direction = 'asc' THEN o.option_name END ASC,
    CASE WHEN p_sort_field = 'option_name' AND p_sort_direction = 'desc' THEN o.option_name END DESC
  LIMIT p_limit OFFSET p_offset;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_insert(p_company_id bigint, p_user_id bigint, p_option_id bigint, p_grant boolean, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.user_permission (
        company_id,
        user_id,
        option_id,
        ""grant"",
        created_by,
        created_at
    ) VALUES (
        p_company_id,
        p_user_id,
        p_option_id,
        p_grant,
        p_created_by,
        COALESCE(p_created_at, now())
    );

    RETURN true;

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Insert Error in user_permission: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_permission_update(p_id bigint, p_company_id bigint, p_user_id bigint, p_option_id bigint, p_grant boolean, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.user_permission
    SET 
        user_id = p_user_id,
        option_id = p_option_id,
        ""grant"" = p_grant,
        modified_by = p_modified_by,
        modified_at = COALESCE(p_modified_at, now())
    WHERE id = p_id AND company_id = p_company_id;

    RETURN true;

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Update Error in user_permission: %', SQLERRM;
    RETURN false;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_profile_update(p_id bigint, p_company_id bigint, p_first_name text, p_last_name text, p_email text, p_mobile_no text, p_image_url text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""user"" SET 
	company_id = (p_company_id),
	first_name = TRIM(p_first_name), 
	last_name = TRIM(p_last_name), 
	email = TRIM(p_email), 
	mobile_no = TRIM(p_mobile_no), 
	image_url = p_image_url,
	status = TRIM(p_status),
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_update(p_id bigint, p_company_id bigint, p_first_name text, p_last_name text, p_email text, p_mobile_no text, p_user_name text, p_password text, p_role_id bigint, p_image_url text, p_status text, p_code text, p_type_id bigint, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    UPDATE public.""user"" SET 
	company_id = p_company_id,
	first_name = TRIM(p_first_name), 
	last_name = TRIM(p_last_name), 
	email = TRIM(p_email), 
	mobile_no = TRIM(p_mobile_no), 
	user_name = TRIM(p_user_name), 
	password = p_password, 
	role_id = p_role_id,
	image_url = p_image_url,
	status = TRIM(p_status),
	code=p_code,
	type_id=p_type_id,
	modified_by = p_modified_by,
	modified_at = p_modified_at
	WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_user_user_name_exist(p_id bigint, p_company_id bigint, p_user_name text)
 RETURNS TABLE(id bigint, user_name text)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	u.id,
	u.user_name
	FROM public.""user"" u
	WHERE u.id <> p_id AND LOWER(TRIM(u.user_name)) = LOWER(TRIM(p_user_name))
	AND u.company_id = p_company_id AND status='Active';
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_delete(p_company_id bigint, p_ids text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN   
    DELETE 
	FROM public.""video_uploads""
	WHERE id in (SELECT id::bigint FROM unnest(string_to_array(p_ids, ',')) AS id)
	AND company_id = p_company_id ;

    -- Return true to indicate success
    RETURN true;

END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_get(p_id bigint, p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, video_source text, description text, tags text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
   SELECT
	vu.id,
	vu.course_id, 
	c.course_name,
    vu.title,
	vu.video_source,
	vu.description,
	vu.tags,
    vu.status,
	vu.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    vu.created_at,
    vu.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    vu.modified_at
	FROM public.""video_uploads"" vu
	LEFT JOIN public.""course"" c ON vu.course_id = c.id
	LEFT JOIN public.""user"" u ON vu.created_by = u.id
	LEFT JOIN public.""user"" u1 ON vu.modified_by = u1.id
	WHERE vu.id = p_id AND vu.company_id = p_company_id ;
  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_get_all(p_company_id bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, video_source text, description text, tags text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	RETURN QUERY 	
    SELECT
	vu.id,
	vu.course_id, 
	c.course_name,
    vu.title,
	vu.video_source,
	vu.description,
	vu.tags,
    vu.status,
	vu.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    vu.created_at,
    vu.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    vu.modified_at
	FROM public.""video_uploads"" vu
	LEFT JOIN public.""course"" c ON vu.course_id = c.id
	LEFT JOIN public.""user"" u ON vu.created_by = u.id
	LEFT JOIN public.""user"" u1 ON vu.modified_by = u1.id
	WHERE vu.company_id = p_company_id
	ORDER BY vu.title ASC;
		
 
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_get_count(p_company_id bigint, p_filter_text text)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE 
    total_rows BIGINT;
	v_filter_text TEXT;
BEGIN
    v_filter_text := LOWER(TRIM(p_filter_text));
    SELECT COUNT(*) INTO total_rows
    FROM public.""video_uploads"" vu
	LEFT JOIN public.""course"" c ON vu.course_id = c.id
    LEFT JOIN public.""user"" u ON vu.created_by = u.id
    LEFT JOIN public.""user"" u1 ON vu.modified_by = u1.id
    WHERE (LOWER(TRIM(vu.title)) LIKE '%' || v_filter_text || '%'
		  OR LOWER(TRIM(c.course_name)) LIKE '%' || v_filter_text || '%')
	 AND vu.company_id = p_company_id;

    RETURN total_rows;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_get_page(p_company_id bigint, p_filter_text text, p_sort_field text, p_sort_direction text, p_offset bigint, p_limit bigint)
 RETURNS TABLE(id bigint, course_id bigint, course_name text, title text, video_source text, description text, tags text, status text, created_by bigint, created_by_first_name text, created_by_last_name text, created_by_user_name text, created_at timestamp without time zone, modified_by bigint, modified_by_first_name text, modified_by_last_name text, modified_by_user_name text, modified_at timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
BEGIN
	p_filter_text = LOWER(TRIM(p_filter_text));
	p_sort_field = LOWER(TRIM(p_sort_field));
	p_sort_direction = LOWER(TRIM(p_sort_direction));
	RETURN QUERY 	
    SELECT
	vu.id,
	vu.course_id, 
	c.course_name,
    vu.title,
	vu.video_source,
	vu.description,
	vu.tags,
    vu.status,
	vu.created_by,
	u.first_name,
	u.last_name,
	u.user_name,
    vu.created_at,
    vu.modified_by,
	u1.first_name,
	u1.last_name,
	u1.user_name,
    vu.modified_at
	FROM public.""video_uploads"" vu
	LEFT JOIN public.""course"" c ON vu.course_id = c.id
	LEFT JOIN public.""user"" u ON vu.created_by = u.id
	LEFT JOIN public.""user"" u1 ON vu.modified_by = u1.id
	WHERE vu.company_id = p_company_id AND 
	(LOWER(TRIM(vu.title)) LIKE '%' || p_filter_text || '%'
	OR LOWER(TRIM(c.course_name)) LIKE '%' || p_filter_text || '%'
	)
	ORDER BY 
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'desc' THEN vu.id END DESC,
	CASE WHEN p_sort_field = 'id' AND p_sort_direction = 'asc' THEN vu.id END ASC,
	CASE WHEN p_sort_field = 'title' AND p_sort_direction = 'desc' THEN vu.title END DESC,
	CASE WHEN p_sort_field = 'title' AND p_sort_direction = 'asc' THEN vu.title END ASC	
	LIMIT p_limit
	OFFSET p_offset;  
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_insert(p_company_id bigint, p_course_id bigint, p_title text, p_video_source text, p_description text, p_tags text, p_status text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN    
    INSERT INTO public.""video_uploads"" (
	    company_id,
		course_id,
        title,
		video_source,
		description,
		tags,
        status,
		created_by,
		created_at
    ) VALUES (
	    p_company_id,
		p_course_id,
        TRIM(p_title),
		TRIM(p_video_source),
		TRIM(p_description),
		TRIM(p_tags),
        p_status,
		p_created_by,
		p_created_at
    );

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.func_video_uploads_update(p_id bigint, p_company_id bigint, p_course_id bigint, p_title text, p_video_source text, p_description text, p_tags text, p_status text, p_modified_by bigint, p_modified_at timestamp without time zone)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE public.video_uploads
    SET
	    company_id = p_company_id,
        course_id = p_course_id,
        title = TRIM(p_title),
        video_source = TRIM(p_video_source),
		description = TRIM(p_description),
		tags = TRIM(p_tags),
        status = p_status,
        modified_by = p_modified_by,
        modified_at = p_modified_at
    WHERE id = p_id AND company_id = p_company_id;

    -- Return true to indicate success
    RETURN true;
END;
$function$
;
"
"CREATE OR REPLACE FUNCTION public.log_unauthorized_device(p_user_id bigint, p_company_id bigint, p_device_id text, p_device_info text, p_ip_address text, p_created_by bigint, p_created_at timestamp without time zone)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    BEGIN
        INSERT INTO public.logs (
            user_id,
            company_id,
            device_id,
            device_info,
            ip_address,
            created_by,
            created_at
        ) VALUES (
            p_user_id,
            p_company_id,
            TRIM(p_device_id),
            TRIM(p_device_info),
            TRIM(p_ip_address),
            p_created_by,
            COALESCE(p_created_at, now())
        );
    EXCEPTION WHEN OTHERS THEN
        -- avoid breaking main function
        RAISE NOTICE 'Logging failed: %', SQLERRM;
    END;
END;
$function$
;
"