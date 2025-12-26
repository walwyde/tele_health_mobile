-- SYMPTOMS
CREATE TABLE symptoms (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL
);

-- DISEASES
CREATE TABLE diseases (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  description text
);

-- DISEASE-SYMPTOM MAPPING
CREATE TABLE disease_symptoms (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  disease_id uuid REFERENCES diseases(id) ON DELETE CASCADE,
  symptom_id uuid REFERENCES symptoms(id) ON DELETE CASCADE
);

-- DRUGS
CREATE TABLE drugs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  disease_id uuid REFERENCES diseases(id) ON DELETE CASCADE,
  name text NOT NULL,
  dosage text NOT NULL
);

INSERT INTO symptoms (name) VALUES
('fever'),
('headache'),
('chills'),
('vomiting'),
('fatigue'),
('cough'),
('chest pain'),
('shortness of breath'),
('diarrhea'),
('abdominal pain'),
('nausea'),
('weight loss'),
('frequent urination'),
('excessive thirst'),
('blurred vision'),
('dizziness'),
('joint pain'),
('skin rash'),
('sore throat'),
('loss of appetite'),
('night sweats'),
('wheezing'),
('weakness'),
('confusion'),
('seizures'),
('depression'),
('anxiety'),
('insomnia'),
('obesity'),
('swelling'),
('yellow eyes'),
('dark urine'),
('bleeding'),
('vision loss'),
('eye pain'),
('neck stiffness'),
('muscle spasms'),
('paralysis');


INSERT INTO diseases (name, description) VALUES
('Malaria','Parasitic infection transmitted by mosquitoes'),
('Typhoid','Bacterial infection from contaminated food or water'),
('Diabetes','Chronic condition affecting blood sugar'),
('Hypertension','High blood pressure'),
('Asthma','Chronic airway inflammation'),
('Pneumonia','Lung infection'),
('Tuberculosis','Chronic bacterial lung infection'),
('Hepatitis B','Viral liver infection'),
('Hepatitis C','Viral liver disease'),
('HIV/AIDS','Immune system disease'),
('Cholera','Severe diarrheal illness'),
('Dysentery','Inflammatory bowel infection'),
('Ulcer','Open sore in stomach lining'),
('Appendicitis','Inflammation of appendix'),
('Migraine','Severe headache disorder'),
('Anemia','Low red blood cell count'),
('Arthritis','Joint inflammation'),
('Stroke','Interruption of blood to brain'),
('Heart Disease','Disorders of heart'),
('Kidney Disease','Impaired kidney function'),
('Liver Cirrhosis','Chronic liver damage'),
('COVID-19','Viral respiratory disease'),
('Influenza','Seasonal viral illness'),
('Bronchitis','Inflammation of bronchial tubes'),
('Sinusitis','Inflammation of sinuses'),
('Peptic Ulcer','Stomach or duodenal ulcer'),
('Food Poisoning','Illness from contaminated food'),
('Measles','Highly contagious viral disease'),
('Chickenpox','Viral skin infection'),
('Tetanus','Bacterial nervous system infection'),
('Epilepsy','Neurological seizure disorder'),
('Depression','Mood disorder'),
('Anxiety Disorder','Mental health condition'),
('Obesity','Excess body fat'),
('Thyroid Disorder','Hormonal imbalance'),
('Prostate Disease','Prostate gland disorder'),
('Breast Cancer','Malignant breast tumor'),
('Cervical Cancer','Cancer of cervix'),
('Glaucoma','Optic nerve damage'),
('Cataract','Clouding of eye lens');

ALTER TABLE disease_symptoms 
   ADD CONSTRAINT unique_disease_symptom 
   UNIQUE (disease_id, symptom_id);

   -- MALARIA
INSERT INTO disease_symptoms (disease_id, symptom_id)
SELECT d.id, s.id 
FROM diseases d 
JOIN symptoms s ON s.name IN ('fever','chills','headache','vomiting','fatigue')
WHERE d.name = 'Malaria'
ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- TYPHOID
INSERT INTO disease_symptoms (disease_id, symptom_id)
SELECT d.id, s.id 
FROM diseases d 
JOIN symptoms s ON s.name IN ('fever','abdominal pain','diarrhea','loss of appetite','fatigue')
WHERE d.name = 'Typhoid'
ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- CHOLERA
INSERT INTO disease_symptoms (disease_id, symptom_id)
SELECT d.id, s.id 
FROM diseases d 
JOIN symptoms s ON s.name IN ('diarrhea','vomiting','dehydration','weakness')
WHERE d.name = 'Cholera'
ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- DYSENTERY
INSERT INTO disease_symptoms (disease_id, symptom_id)
SELECT d.id, s.id 
FROM diseases d 
JOIN symptoms s ON s.name IN ('diarrhea','abdominal pain','fever','bleeding')
WHERE d.name = 'Dysentery'
ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- COVID-19
INSERT INTO disease_symptoms (disease_id, symptom_id)
SELECT d.id, s.id 
FROM diseases d 
JOIN symptoms s ON s.name IN ('fever','cough','fatigue','shortness of breath','loss of appetite')
WHERE d.name = 'COVID-19'
ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- INFLUENZA
INSERT INTO disease_symptoms (disease_id, symptom_id)
SELECT d.id, s.id 
FROM diseases d 
JOIN symptoms s ON s.name IN ('fever','headache','fatigue','cough','sore throat')
WHERE d.name = 'Influenza'
ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- ASTHMA
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('shortness of breath','wheezing','chest pain','cough') WHERE d.name = 'Asthma' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- PNEUMONIA
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('fever','cough','chest pain','shortness of breath') WHERE d.name = 'Pneumonia' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- BRONCHITIS
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('cough','chest pain','fatigue','shortness of breath') WHERE d.name = 'Bronchitis' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- TUBERCULOSIS
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('cough','night sweats','weight loss','fever') WHERE d.name = 'Tuberculosis' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- DIABETES
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('frequent urination','excessive thirst','weight loss','blurred vision') WHERE d.name = 'Diabetes' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- HYPERTENSION
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('headache','dizziness','chest pain','blurred vision') WHERE d.name = 'Hypertension' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- OBESITY
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('obesity','fatigue','joint pain') WHERE d.name = 'Obesity' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- THYROID DISORDER
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('weight loss','weight gain','fatigue','anxiety') WHERE d.name = 'Thyroid Disorder' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- STROKE
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('confusion','paralysis','vision loss','headache') WHERE d.name = 'Stroke' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- EPILEPSY
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('seizures','confusion','loss of consciousness') WHERE d.name = 'Epilepsy' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- MIGRAINE
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('headache','nausea','blurred vision') WHERE d.name = 'Migraine' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- DEPRESSION
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('depression','insomnia','fatigue') WHERE d.name = 'Depression' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- ANXIETY DISORDER
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('anxiety','insomnia','palpitations') WHERE d.name = 'Anxiety Disorder' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- PEPTIC ULCER
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('abdominal pain','nausea','vomiting') WHERE d.name = 'Peptic Ulcer' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- APPENDICITIS
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('abdominal pain','fever','vomiting') WHERE d.name = 'Appendicitis' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- BREAST CANCER
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('lump','pain','weight loss') WHERE d.name = 'Breast Cancer' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- CERVICAL CANCER
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('bleeding','pelvic pain','weight loss') WHERE d.name = 'Cervical Cancer' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- GLAUCOMA
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('eye pain','vision loss') WHERE d.name = 'Glaucoma' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

-- CATARACT
INSERT INTO disease_symptoms (disease_id, symptom_id) SELECT d.id, s.id FROM diseases d JOIN symptoms s ON s.name IN ('blurred vision','vision loss') WHERE d.name = 'Cataract' ON CONFLICT (disease_id, symptom_id) DO NOTHING;

CREATE VIEW disease_match_scores AS
SELECT
  d.id AS disease_id,
  d.name AS disease_name,
  COUNT(ds.symptom_id) AS match_count
FROM disease_symptoms ds
JOIN diseases d ON d.id = ds.disease_id
GROUP BY d.id, d.name;
