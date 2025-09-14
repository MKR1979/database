"CREATE TABLE public.admission (
    gender text,
    email text,
    phone_no text,
    address text,
    city_name text,
    state_id bigint,
    country_id bigint,
    zip_code text,
    highschoolname text,
    highschoolpercentage numeric,
    highersschoolname text,
    highersschoolpercentage numeric,
    graduationname text,
    graduationpercentage numeric,
    tenthproof text,
    twelthproof text,
    graduationproof text,
    photoidproof text,
    photo text,
    status text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    company_id bigint,
    paid_amount numeric DEFAULT 0,
    total_fee numeric,
    payment_mode text,
    is_aadhar_req text,
    is_birth_certi_req text,
    is_tc_req text,
    is_samagraid_req text,
    transfer_certificate text DEFAULT false,
    course_id bigint,
    first_name text,
    last_name text,
    id bigint NOT NULL,
    admission_date timestamp without time zone,
    dob date,\n    CONSTRAINT admission_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.admission_clg (
    transport_route text,
    hostel_facility text,
    hostel_occupancy text,
    scholarship_student text,
    family_samagra_id text,
    student_pen_no text,
    photo text,
    aadhaar_card text,
    other_certificate text,
    father_aadhaar text,
    mother_aadhaar text,
    samagra_id text,
    high_school_marksheet text,
    intermediate_marksheet text,
    diploma_marksheet text,
    ug_marksheet text,
    pg_marksheet text,
    anti_ragging text,
    student_undertaking text,
    parents_undertaking text,
    admission_date timestamp without time zone,
    transfer_certificate text DEFAULT false,
    course_type_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    status text DEFAULT 'Active'::text,
    mother_photo text,
    father_photo text,
    corr_city_name text,
    corr_zip_code text,
    email text,
    phone_no text,
    religion text,
    blood_group text,
    medium text,
    father_qualification text,
    father_occupation text,
    father_organisation text,
    father_designation text,
    father_phone_no text,
    father_email text,
    id bigint NOT NULL,
    company_id bigint,
    father_aadhaar_no text,
    course_id bigint,
    district_id bigint,
    state_id bigint,
    country_id bigint,
    corr_district_id bigint,
    corr_state_id bigint,
    corr_country_id bigint,
    diploma_course_id bigint,
    ug_course_id bigint,
    pg_course_id bigint,
    ........pg.dropped.13........ -,
    entry_type text,
    gender text,
    first_name text,
    last_name text,
    user_name text,
    father_name text,
    mother_name text,
    dob date,
    category text,
    address text,
    city_name text,
    zip_code text,
    corr_address text,
    mother_occupation text,
    mother_qualification text,
    mother_organisation text,
    mother_designation text,
    mother_phone_no text,
    mother_email text,
    mother_aadhaar_no text,
    student_aadhaar_no text,
    samagra_id_no text,
    staff_child text,
    sibling_in_college text,
    parents_ex_college text,
    guardian_name text,
    guardian_phone_no text,
    high_school_board text,
    high_school_year bigint,
    high_school_roll_no text,
    high_school_percentage numeric(5,2),
    intermediate_board text,
    intermediate_year bigint,
    intermediate_roll_no text,
    intermediate_stream text,
    intermediate_percentage numeric(5,2),
    diploma_college text,
    diploma_university text,
    diploma_registration_no text,
    diploma_passing_year bigint,
    diploma_cgpa numeric(5,2),
    ug_college text,
    ug_university text,
    ug_registration_no text,
    ug_passing_year bigint,
    ug_cgpa numeric(5,2),
    pg_college text,
    pg_university text,
    pg_registration_no text,
    pg_passing_year bigint,
    pg_cgpa numeric(5,2),
    undertaking text,
    transport_facility text
);
"
"CREATE TABLE public.admission_form (
    modified_at timestamp without time zone,
    admission_date timestamp without time zone,
    transfer_certificate text DEFAULT false,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    status text DEFAULT 'Active'::text,
    mother_photo text,
    father_photo text,
    prev_class_marksheet text,
    samagra_id text,
    mother_aadhaar text,
    father_aadhaar text,
    other_certificate text,
    birth_certificate text,
    aadhaar_card text,
    photo text,
    student_pen_no text,
    family_samagra_id text,
    mess_facility text,
    transport_facility text,
    stream text,
    ii_language text,
    iii_language text,
    undertaking text,
    guardian_phone_no text,
    guardian_name text,
    parents_ex_school text,
    sibling_in_school text,
    staff_child text,
    samagra_id_no text,
    mother_aadhaar_no text,
    father_aadhaar_no text,
    student_aadhaar_no text,
    mother_email text,
    mother_phone_no text,
    mother_designation text,
    mother_organisation text,
    mother_occupation text,
    mother_qualification text,
    father_email text,
    father_phone_no text,
    father_designation text,
    father_organisation text,
    father_occupation text,
    father_qualification text,
    medium text,
    current_board text,
    current_school text,
    boarder_day_scholar text,
    blood_group text,
    religion text,
    phone_no text,
    email text,
    zip_code text,
    city_name text,
    country_id bigint,
    state_id bigint,
    address text,
    category text,
    dob date,
    mother_name text,
    father_name text,
    last_name text,
    first_name text,
    gender text,
    course_id bigint,
    company_id bigint,
    id bigint NOT NULL
);
"
"CREATE TABLE public.affiliate (
    first_name text,
    last_name text,
    ........pg.dropped.4........ -,
    ........pg.dropped.5........ -,
    ........pg.dropped.6........ -,
    ........pg.dropped.7........ -,
    address text,
    city_name text,
    state_id bigint,
    country_id bigint,
    company_id bigint,
    conversion_rate numeric,
    modified_at timestamp without time zone,
    created_by bigint,
    zip_code text,
    status text,
    photo_id_url text,
    created_at timestamp without time zone,
    modified_by bigint,
    district_id bigint,
    id bigint NOT NULL,\n    CONSTRAINT affiliate_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.affiliate_payment (
    amount_paid numeric NOT NULL,
    payment_date timestamp without time zone DEFAULT now(),
    remarks text,
    created_at timestamp without time zone DEFAULT now(),
    created_by bigint,
    company_id bigint,
    id bigint NOT NULL,
    affiliate_id bigint NOT NULL,
    total_referrals bigint DEFAULT 0,
    total_earning numeric DEFAULT 0,
    deduction numeric DEFAULT 0,
    status text DEFAULT 'pending'::text,\n    CONSTRAINT affiliate_payment_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.attendance (
    user_id bigint,
    device_id text,
    is_verified boolean DEFAULT false,
    ........pg.dropped.17........ -,
    company_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    remarks text,
    ip_address text,
    device_info text,
    is_on_campus boolean DEFAULT false,
    distance_from_office numeric,
    longitude numeric,
    latitude numeric,
    attendance_time timestamp with time zone DEFAULT now(),
    entry_type text,
    id bigint NOT NULL,\n    CONSTRAINT attendance_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.attendance_bulk (
    id bigint NOT NULL,
    user_id bigint,
    entry_type text,
    attendance_time timestamp with time zone DEFAULT now(),
    latitude numeric,
    longitude numeric,
    distance_from_office numeric,
    is_on_campus boolean DEFAULT false,
    device_info text,
    ip_address text,
    remarks text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    company_id bigint,
    is_verified boolean DEFAULT false,
    is_locked boolean DEFAULT false
);
"
"CREATE TABLE public.chatbot_messages (
    text text NOT NULL,
    sender text,
    created_at timestamp without time zone DEFAULT now(),
    session_id text NOT NULL,
    company_id bigint NOT NULL,
    id bigint NOT NULL,\n    CONSTRAINT chatbot_messages_pkey PRIMARY KEY (id, id, id, id, id, id)
);
"
"CREATE TABLE public.code_projects (
    source_code text,
    description text,
    company_id bigint,
    title text NOT NULL,
    id bigint NOT NULL,
    course_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    status text NOT NULL
);
"
"CREATE TABLE public.company (
    modified_by bigint,
    company_name text,
    company_type text,
    email text,
    phone_no text,
    address text,
    status text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_at timestamp without time zone,
    company_code text,
    id bigint NOT NULL,\n    CONSTRAINT company_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.company_domain_info (
    logo_url text,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    status text,
    domain_name text,
    company_id bigint,
    id bigint NOT NULL,
    logo_width integer,
    logo_height integer,\n    CONSTRAINT company_domain_info_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.contact_us (
    phone_no text,
    contact_name text,
    email text,
    id bigint NOT NULL,
    can_contacted boolean DEFAULT true,
    created_by bigint DEFAULT 1,
    company_id bigint,
    created_at timestamp without time zone,
    message text,
    subject text,
    category_name text
);
"
"CREATE TABLE public.country (
    id bigint NOT NULL,
    country_name text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    company_id bigint,
    status text,\n    CONSTRAINT country_pkey PRIMARY KEY (id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.course (
    modified_by bigint,
    created_by bigint,
    course_name text,
    course_code text,
    price bigint,
    duration text,
    ........pg.dropped.6........ -,
    logo_url text,
    documents_path text,
    status text,
    id bigint NOT NULL,
    prev_class_marksheet boolean DEFAULT false,
    isdiplomareq boolean DEFAULT false,
    course_type_id bigint,
    is_samagraid_req boolean DEFAULT false,
    is_tc_req boolean DEFAULT false,
    is_birth_certi_req boolean DEFAULT false,
    is_aadhar_req boolean DEFAULT false,
    company_id bigint,
    is_paid boolean DEFAULT false,
    quiz_id bigint,
    isphotoidreq boolean DEFAULT false,
    ispgreq boolean DEFAULT false,
    isgradreq boolean DEFAULT false,
    is12threq boolean DEFAULT false,
    is10threq boolean DEFAULT false,
    modified_at timestamp without time zone,
    created_at timestamp without time zone,\n    CONSTRAINT course_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.course_enrollment (
    course_id bigint NOT NULL,
    student_id bigint NOT NULL,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    id bigint NOT NULL,
    status text DEFAULT 'Active'::text,
    enrollment_date timestamp without time zone
);
"
"CREATE TABLE public.coursetype (
    created_by bigint,
    group_id bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    created_at timestamp with time zone DEFAULT now(),
    status text DEFAULT 'Active'::text,
    code text,
    course_type_name text NOT NULL,
    company_id bigint,
    id bigint NOT NULL
);
"
"CREATE TABLE public.coursetypeold (
    group_id bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    created_at timestamp with time zone,
    created_by bigint,
    status text,
    code text,
    course_type_name text,
    company_id bigint,
    id bigint
);
"
"CREATE TABLE public.currency (
    id bigint NOT NULL,
    currency_name text,
    currency_symbol text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    status text,
    company_id bigint,
    currency_code text,\n    CONSTRAINT currency_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.district (
    modified_by bigint,
    id bigint NOT NULL,
    district_name text,
    state_id bigint NOT NULL,
    company_id bigint,
    status text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_at timestamp without time zone,\n    CONSTRAINT district_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.email_otps (
    otp text NOT NULL,
    purpose text,
    is_verified boolean DEFAULT false,
    verified_at timestamp without time zone,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    company_id bigint,
    status text DEFAULT 'Active'::text NOT NULL,
    email_id bigint,
    to_address text NOT NULL,
    id bigint NOT NULL,\n    CONSTRAINT email_otps_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.email_template (
    email_template_body text,
    id bigint NOT NULL,
    status text,
    company_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    email_template_name text,\n    CONSTRAINT email_template_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.emails (
    retry_count integer DEFAULT 0 NOT NULL,
    attachment_path text,
    template_name text,
    otp text,
    body text,
    subject text,
    to_address text NOT NULL,
    id bigint NOT NULL,
    company_id bigint,
    created_at timestamp without time zone DEFAULT now(),
    sent_at timestamp without time zone,
    status text NOT NULL
);
"
"CREATE TABLE public.employee (
    department_type text,
    experience numeric,
    designation text,
    salary numeric,
    gender text,
    email text NOT NULL,
    phone_no text,
    marital_status text,
    father_name text,
    mother_name text,
    husband_wife_name text,
    address text,
    aadhaar_no text,
    pan_card text,
    status text DEFAULT 'Active'::text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    company_id bigint,
    photo text,
    photoidproof text,
    id bigint NOT NULL,
    first_name text NOT NULL,
    last_name text,
    user_name text NOT NULL,
    emp_code text NOT NULL,
    joining_date timestamp without time zone,
    dob date,
    qualification text
);
"
"CREATE TABLE public.enrollments (
    company_id bigint,
    course_id bigint NOT NULL,
    user_id bigint NOT NULL,
    id bigint NOT NULL,
    modified_at timestamp without time zone,
    created_by bigint,
    created_at timestamp without time zone,
    status text,
    paid_amount numeric,
    modified_by bigint,
    end_date timestamp with time zone,
    enrollment_date timestamp with time zone DEFAULT now()
);
"
"CREATE TABLE public.enrollments_new (
    modified_by bigint,
    created_by bigint,
    created_at timestamp without time zone,
    modified_at timestamp without time zone,
    paid_amount numeric,
    end_date timestamp with time zone,
    enrollment_date timestamp with time zone DEFAULT now(),
    company_id bigint,
    course_id bigint NOT NULL,
    learner_id bigint NOT NULL,
    id bigint NOT NULL,
    status text
);
"
"CREATE TABLE public.event (
    budget numeric,
    email_template_id bigint,
    assigned_to bigint,
    description text,
    start_date_time timestamp without time zone,
    event_name text,
    id bigint NOT NULL,
    end_date_time timestamp without time zone,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    currency_id bigint,
    location_id bigint,
    company_id bigint,
    status text DEFAULT 'Active'::text,\n    CONSTRAINT event_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.fee_collections (
    fee_amount numeric(12,2),
    cheque_number text,
    payment_mode text,
    payment_date timestamp with time zone,
    learner_id bigint,
    course_id bigint,
    company_id bigint NOT NULL,
    id bigint NOT NULL,
    remarks text,
    payment_type text,
    modified_at timestamp with time zone,
    modified_by bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by bigint NOT NULL,
    course_name text,
    student_name text,
    status text
);
"
"CREATE TABLE public.fee_payment (
    transaction_id bigint,
    user_id bigint,
    razorpay_signature text,
    razorpay_payment_id text,
    razorpay_order_id text,
    is_captured boolean,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    company_id bigint,
    status text,
    fine_amount numeric,
    discount numeric,
    due_date timestamp without time zone,
    payment_date timestamp without time zone,
    amount numeric,
    frequency text,
    course_id bigint,
    admission_id bigint,
    payment_id bigint,
    id bigint NOT NULL,\n    CONSTRAINT fee_payment_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.fee_payment_new (
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    payment_id bigint,
    enrollment_id bigint,
    student_fee_plan_id bigint,
    id bigint NOT NULL,
    learner_id bigint NOT NULL,
    modified_by bigint,
    modified_at timestamp without time zone,
    created_by bigint,
    company_id bigint,
    razorpay_signature text,
    razorpay_payment_id text,
    razorpay_order_id text,
    is_captured boolean,
    status text,
    fine_amount numeric(10,2),
    discount numeric(10,2),
    payment_date timestamp without time zone,
    due_date date,
    amount numeric(10,2),
    frequency text,
    course_id bigint
);
"
"CREATE TABLE public.group (
    company_id bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    group_name text NOT NULL,
    id bigint NOT NULL,
    status text DEFAULT 'Active'::text,
    created_by bigint,\n    CONSTRAINT group_pkey PRIMARY KEY (id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.location (
    status text,
    location_name text,
    description text,
    created_at timestamp without time zone,
    modified_by bigint,
    company_id bigint,
    zip_code text,
    created_by bigint,
    country_id bigint,
    state_id bigint,
    city_name text,
    address text,
    capacity bigint,
    ........pg.dropped.15........ -,
    modified_at timestamp without time zone,
    ........pg.dropped.14........ -,
    id bigint NOT NULL,\n    CONSTRAINT location_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.logs (
    modified_by bigint,
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL,
    device_id text NOT NULL,
    device_info text,
    ip_address text,
    created_by bigint,
    created_at timestamp without time zone DEFAULT now(),
    modified_at timestamp without time zone,\n    CONSTRAINT logs_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.meeting (
    start_date_time timestamp without time zone,
    subject text,
    company_id bigint,
    end_date_time timestamp without time zone,
    location_id bigint,
    reminder text,
    description text,
    parent_type text,
    parent_type_id bigint,
    assigned_to bigint,
    status text,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    id bigint NOT NULL,\n    CONSTRAINT meeting_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.module (
    company_id bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    created_at timestamp with time zone DEFAULT now(),
    created_by bigint,
    status text DEFAULT 'Active'::text,
    id bigint NOT NULL,
    module_name text NOT NULL,
    code text
);
"
"CREATE TABLE public.option (
    id bigint NOT NULL,
    option_code bigint DEFAULT 0 NOT NULL,
    option_name text,
    module_id bigint,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    status text DEFAULT 'Active'::text,
    company_id bigint,
    modified_at timestamp without time zone,\n    CONSTRAINT option_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.pay_receipt (
    created_by bigint,
    generated_by bigint,
    payment_date date DEFAULT CURRENT_DATE,
    amount_paid numeric(10,2),
    payment_mode text,
    receipt_number text,
    course_id bigint,
    learner_id bigint,
    payment_id bigint,
    company_id bigint,
    id bigint NOT NULL,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
"
"CREATE TABLE public.payment (
    currency text,
    id bigint NOT NULL,
    user_id bigint,
    payee_name text,
    razorpay_signature text,
    company_id bigint,
    created_at timestamp without time zone,
    razorpay_payment_id text,
    razorpay_order_id text,
    status text,
    is_captured boolean,
    transaction_id text,
    payment_method text,
    receipt text,
    amount numeric
);
"
"CREATE TABLE public.payment_new (
    collected_by bigint,
    modified_by bigint,
    modified_at timestamp without time zone,
    id bigint NOT NULL,
    learner_id bigint,
    amount numeric(10,2),
    currency text,
    payment_method text,
    transaction_id text,
    status text,
    is_captured boolean,
    razorpay_order_id text,
    razorpay_payment_id text,
    razorpay_signature text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by bigint,
    company_id bigint,
    paid_by_admin boolean DEFAULT false
);
"
"CREATE TABLE public.payment_receipts (
    course_name text NOT NULL,
    student_name text NOT NULL,
    admission_date timestamp without time zone NOT NULL,
    phone_no text,
    address text,
    site_url text,
    status text,
    created_by bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified_by bigint,
    modified_at timestamp without time zone,
    admission_no text NOT NULL,
    company_id bigint,
    id bigint NOT NULL,
    email text,
    payment_date date DEFAULT CURRENT_DATE NOT NULL,
    payment_mode text,
    amount_paid numeric(10,2) NOT NULL,\n    CONSTRAINT payment_receipts_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.question_options (
    explanation text,
    id bigint NOT NULL,
    question_id bigint NOT NULL,
    option_text text,
    is_correct boolean DEFAULT false,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    quiz_id bigint,
    company_id bigint,\n    CONSTRAINT options_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.quiz (
    created_at timestamp without time zone,
    exam_duration integer,
    modified_by bigint,
    quiz_type text,
    company_id bigint,
    course_id bigint,
    modified_at timestamp without time zone,
    id bigint NOT NULL,
    quiz_name text,
    quiz_code text,
    status text,
    created_by bigint,\n    CONSTRAINT quiz_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.quiz_questions (
    modified_by bigint,
    created_by bigint,
    status text,
    ........pg.dropped.4........ -,
    question text,
    quiz_id bigint NOT NULL,
    id bigint NOT NULL,
    modified_at timestamp without time zone,
    company_id bigint,
    created_at timestamp without time zone,\n    CONSTRAINT quiz_questions_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.quiz_results (
    course_id bigint NOT NULL,
    correct_answers integer NOT NULL,
    wrong_answers integer NOT NULL,
    percentage numeric(5,2),
    time_taken_seconds integer NOT NULL,
    passed boolean DEFAULT false NOT NULL,
    attempt_timestamp timestamp with time zone DEFAULT now(),
    created_by bigint,
    created_at timestamp without time zone,
    company_id bigint NOT NULL,
    unattempted_questions integer NOT NULL,
    id bigint NOT NULL,
    student_id bigint NOT NULL,
    attempted_questions integer NOT NULL,
    total_questions integer NOT NULL,
    quiz_id bigint NOT NULL
);
"
"CREATE TABLE public.referral (
    address text,
    is_paid boolean DEFAULT false NOT NULL,
    email text NOT NULL,
    mobile_no text NOT NULL,
    contact_person text NOT NULL,
    referral_date timestamp with time zone DEFAULT now(),
    referral_company_name text NOT NULL,
    company_id bigint NOT NULL,
    id bigint NOT NULL,
    received_amount numeric(12,2) DEFAULT 0.00,
    amount_paid numeric(12,2) DEFAULT 0.00,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone DEFAULT now(),
    created_by bigint,
    referred_by bigint NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    requirement text,
    product_interest text
);
"
"CREATE TABLE public.referral_payments (
    affiliate_id bigint NOT NULL,
    company_id bigint,
    remarks text,
    payment_mode text,
    payment_date timestamp without time zone DEFAULT now(),
    amount numeric(10,2) NOT NULL,
    id bigint NOT NULL,
    referral_id bigint NOT NULL
);
"
"CREATE TABLE public.referral_status_history (
    created_at timestamp without time zone DEFAULT now(),
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    referral_id bigint NOT NULL,
    old_status text,
    new_status text,
    created_by bigint,
    modified_by bigint,
    modified_at timestamp without time zone
);
"
"CREATE TABLE public.role (
    created_by bigint,
    role_name text,
    id bigint NOT NULL,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    company_id bigint,
    status text DEFAULT 'Active'::text,
    type_id bigint
);
"
"CREATE TABLE public.role_module_mapping (
    modified_by bigint,
    modified_at timestamp without time zone,
    created_at timestamp without time zone,
    created_by bigint,
    status text,
    role_id text,
    module_id bigint,
    company_id bigint,
    id bigint NOT NULL
);
"
"CREATE TABLE public.role_permission (
    company_id bigint,
    id bigint NOT NULL,
    role_id bigint,
    option_id bigint,
    grant boolean,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,\n    CONSTRAINT role_permission_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.site_config (
    modified_by bigint,
    modified_at timestamp without time zone,
    business_config text,
    type text,
    description text,
    key text,
    company_id bigint,
    id bigint NOT NULL,
    status text,
    value text,
    created_by bigint,
    created_at timestamp without time zone
);
"
"CREATE TABLE public.state (
    country_id bigint,
    state_name text,
    id bigint NOT NULL,
    status text,
    company_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    state_code text,\n    CONSTRAINT state_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.student_fee_components (
    fee_plan_id bigint,
    component_name text NOT NULL,
    component_amount numeric(10,2) NOT NULL,
    id bigint NOT NULL,\n    CONSTRAINT student_fee_components_pkey PRIMARY KEY (id, id, id, id)
);
"
"CREATE TABLE public.student_fee_payment_log (
    paid_on date NOT NULL,
    payment_mode text,
    receipt_number text,
    created_at timestamp without time zone DEFAULT now(),
    created_by bigint,
    id bigint NOT NULL,
    fee_breakup_id bigint,
    paid_amount numeric(10,2) NOT NULL,\n    CONSTRAINT student_fee_payment_log_pkey PRIMARY KEY (id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.student_fee_plan (
    modified_by bigint,
    modified_at timestamp without time zone,
    net_amount numeric(10,2),
    payment_frequency text,
    id bigint NOT NULL,
    learner_id bigint NOT NULL,
    course_id bigint NOT NULL,
    start_date text NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    discount numeric(10,2) DEFAULT 0,
    fine_amount numeric(10,2) DEFAULT 0,
    status text DEFAULT 'Active'::text,
    company_id bigint NOT NULL,
    created_by bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
"
"CREATE TABLE public.student_fees_breakup (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    modified_by bigint,
    created_at timestamp without time zone DEFAULT now(),
    created_by bigint,
    receipt_number text,
    payment_mode text,
    paid_on date,
    is_paid boolean DEFAULT false,
    modified_at timestamp without time zone,
    amount numeric(10,2) NOT NULL,
    fee_component text NOT NULL,
    fee_year integer,
    fee_cycle_code text,
    ........pg.dropped.6........ -,
    fee_plan_id bigint NOT NULL,
    course_id bigint NOT NULL,
    admission_id bigint NOT NULL
);
"
"CREATE TABLE public.student_monthly_fees (
    modified_by bigint,
    modified_at timestamp without time zone,
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    admission_id bigint NOT NULL,
    course_id bigint NOT NULL,
    fee_frequency text NOT NULL,
    fee_month integer NOT NULL,
    fee_year integer NOT NULL,
    fee_amount numeric NOT NULL,
    is_paid boolean DEFAULT false,
    paid_on date,
    payment_mode text,
    receipt_number text,
    created_by bigint,
    created_at timestamp without time zone DEFAULT now()
);
"
"CREATE TABLE public.study_notes (
    company_id bigint,
    title text,
    course_id bigint,
    id bigint NOT NULL,
    modified_at timestamp without time zone,
    modified_by bigint,
    description text,
    created_at timestamp without time zone,
    created_by bigint,
    status text,\n    CONSTRAINT study_notes_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.type (
    created_by bigint,
    modified_by bigint,
    modified_at timestamp without time zone,
    id bigint NOT NULL,
    status text DEFAULT 'Active'::text,
    type_name text NOT NULL,
    company_id bigint,
    created_at timestamp without time zone,\n    CONSTRAINT type_pkey PRIMARY KEY (id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.user (
    first_name text,
    id bigint NOT NULL,
    last_name text,
    email text,
    mobile_no text,
    user_name text,
    affiliate_id bigint,
    password text,
    status text,
    created_by bigint,
    type text,
    type_id bigint,
    company_id bigint,
    code text,
    image_url text,
    role_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone
);
"
"CREATE TABLE public.user_device_mapping (
    device_id text,
    id bigint NOT NULL,
    user_id bigint,
    company_id bigint,
    created_by bigint,
    created_at timestamp without time zone,
    modified_by bigint,
    modified_at timestamp without time zone,
    device_info text,
    status text DEFAULT 'active'::text,
    remarks text
);
"
"CREATE TABLE public.user_permission (
    company_id bigint,
    modified_at timestamp without time zone,
    modified_by bigint,
    created_at timestamp without time zone,
    created_by bigint,
    grant boolean,
    option_id bigint,
    user_id bigint,
    id bigint NOT NULL,\n    CONSTRAINT user_permission_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id)
);
"
"CREATE TABLE public.video_uploads (
    video_source text,
    modified_by bigint,
    course_id bigint,
    title text,
    modified_at timestamp without time zone,
    company_id bigint,
    created_at timestamp without time zone,
    created_by bigint,
    status text,
    tags text,
    id bigint NOT NULL,
    description text,\n    CONSTRAINT video_uploads_pkey PRIMARY KEY (id, id, id, id, id, id, id, id, id, id, id, id)
);
"