-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- public.medical определение

-- Drop table

-- DROP TABLE medical;

CREATE TABLE medical (
	medical_id serial4 NOT NULL,
	last_name varchar(50) NULL,
	first_name varchar(50) NULL,
	patronymic varchar(50) NULL,
	profession varchar(70) NOT NULL,
	CONSTRAINT medical_pkey PRIMARY KEY (medical_id)
);

-- Permissions

ALTER TABLE medical OWNER TO postgres;
GRANT ALL ON TABLE medical TO postgres;

-- public.patient определение

-- Drop table

-- DROP TABLE patient;

CREATE TABLE patient (
	patient_id serial4 NOT NULL,
	last_name varchar(50) NULL,
	first_name varchar(50) NULL,
	patronymic varchar(50) NULL,
	birthday_patient date NULL,
	address varchar(100) NULL,
	CONSTRAINT patient_pkey PRIMARY KEY (patient_id)
);

-- Permissions

ALTER TABLE patient OWNER TO postgres;
GRANT ALL ON TABLE patient TO postgres;

-- public.reception_patients определение

-- Drop table

-- DROP TABLE reception_patients;

CREATE TABLE reception_patients (
	reception_patients_id serial4 NOT NULL,
	medical_id int4 NOT NULL,
	patient_id int4 NOT NULL,
	quintation_price numeric NULL,
	deduction_price numeric NULL,
	salary numeric GENERATED ALWAYS AS (quintation_price * (deduction_price / 100::numeric) * 0.87) STORED NULL,
	CONSTRAINT reception_patients_pkey PRIMARY KEY (reception_patients_id),
	CONSTRAINT reception_patients_medical_fk FOREIGN KEY (medical_id) REFERENCES medical(medical_id),
	CONSTRAINT reception_patients_patient_fk FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

-- Permissions

ALTER TABLE reception_patients OWNER TO postgres;
GRANT ALL ON TABLE reception_patients TO postgres;

-- Permissions

GRANT ALL ON SCHEMA public TO pg_database_owner;
GRANT USAGE ON SCHEMA public TO public;

INSERT INTO public.medical (medical_id,last_name,first_name,patronymic,profession) VALUES
	 (1,'Федоров','Светлана','Викторовна','Невролог'),
	 (2,'Григорьев','Сергей','Анатольевич','Эндокринолог'),
	 (3,'Ковалев','Наталья','Станиславовна','Терапевт'),
	 (4,'Алексеева','Виктория','Игоревна','Хирург-онколог'),
	 (5,'Сидоров','Денис','Александрович','Уролог'),
	 (6,'Лисицын','Екатерина','Олеговна','Педиатр'),
	 (7,'Мельников','Павел','Сергеевич','Дерматолог'),
	 (8,'Борисова','Ксения','Андреевна','Гастроэнтеролог'),
	 (9,'Тихонов','Анатолий','Владимирович','Ревматолог'),
	 (10,'Зайцева','Алёна','Юрьевна','Микробиолог');
	
INSERT INTO public.patient (patient_id,last_name,first_name,patronymic,birthday_patient,address) VALUES
	 (1,'Федорова','Светлана','Викторовна','1985-04-10','г. Екатеринбург, ул. Куйбышева, дом 18'),
	 (2,'Григорьев','Сергей','Анатольевич','1991-10-22','ул. Лермонтова, дом 5, квартира 12'),
	 (3,'Ковалев','Наталья','Станиславовна','1974-12-15','г. Казань, пр-т Победы, дом 3'),
	 (4,'Алексеева','Виктория','Игоревна','1989-07-19','пос. Южный, ул. Солнечная, дом 7'),
	 (5,'Сидоров','Денис','Александрович','1980-01-30','г. Ростов-на-Дону, ул. Садовая, дом 45'),
	 (6,'Лисицына','Екатерина','Олеговна','1996-03-05','г. Челябинск, ул. Ленина, дом 9'),
	 (7,'Мельников','Павел','Сергеевич','1979-05-28','г. Новосибирск, ул. Красный проспект, дом 50'),
	 (8,'Борисова','Ксения','Андреевна','1993-11-11','ул. Гагарина, дом 33, квартира 8'),
	 (9,'Тихонов','Анатолий','Владимирович','1987-09-07','г. Уфа, ул. Пушкина, дом 12'),
	 (10,'Зайцева','Алёна','Юрьевна','1994-02-14','пос. Северный, ул. Центральная, дом 21');
	
INSERT INTO public.reception_patients (reception_patients_id,medical_id,patient_id,quintation_price,deduction_price,salary) VALUES
	 (1,1,1,4000.00,20,696.000000000000000000000000),
	 (2,2,2,3500.00,30,913.500000000000000000000000),
	 (3,3,3,9000.00,15,1174.500000000000000000000000),
	 (4,4,4,6000.00,25,1305.000000000000000000000000),
	 (5,5,5,5500.00,22,1052.700000000000000000000000),
	 (6,6,6,4500.00,18,704.700000000000000000000000),
	 (7,7,7,8000.00,28,1948.800000000000000000000000),
	 (8,8,8,3500.00,14,426.300000000000000000000000),
	 (9,9,9,6500.00,26,1470.300000000000000000000000),
	 (10,10,10,5800.00,19,958.740000000000000000000000);
