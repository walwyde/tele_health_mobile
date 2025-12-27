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

ALTER TABLE public.drugs
ADD COLUMN advice text;

ALTER TABLE public.drugs ADD COLUMN warning text;

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


CREATE TABLE disease_chat_responses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  disease_id uuid REFERENCES diseases(id) ON DELETE CASCADE,
  stage text CHECK (stage IN ('intro', 'advice', 'warning', 'urgency', 'reassurance')),
  message text NOT NULL
);


-- INTRO
INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'intro',
'Based on the symptoms you selected, {DISEASE} is a possible condition. This assessment is generated using an AI-supported symptom analysis model.'
FROM diseases WHERE name = '{DISEASE}';

-- ADVICE
INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'advice',
'General self-care measures may help manage symptoms, including adequate rest, hydration, and following recommended lifestyle adjustments.'
FROM diseases WHERE name = '{DISEASE}';

-- WARNING
INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'warning',
'Do not self-medicate beyond recommended guidelines. Incorrect treatment may worsen symptoms.'
FROM diseases WHERE name = '{DISEASE}';

-- URGENCY
INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'urgency',
'Seek immediate medical attention if symptoms worsen, persist, or new severe symptoms develop.'
FROM diseases WHERE name = '{DISEASE}';

-- REASSURANCE
INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'reassurance',
'This AI system provides guidance only and does not replace consultation with a qualified healthcare professional.'
FROM diseases WHERE name = '{DISEASE}';


INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'intro',
'Based on the symptoms you selected, malaria is a possible condition. This assessment is generated using an AI-supported symptom analysis model.'
FROM diseases WHERE name = 'Malaria';

INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'advice',
'Ensure adequate rest, proper hydration, and adherence to prescribed antimalarial medication if provided by a healthcare professional.'
FROM diseases WHERE name = 'Malaria';

INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'warning',
'Incomplete treatment or incorrect drug use may lead to complications or drug resistance.'
FROM diseases WHERE name = 'Malaria';

INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'urgency',
'If high fever, confusion, persistent vomiting, or seizures occur, seek emergency medical care immediately.'
FROM diseases WHERE name = 'Malaria';

INSERT INTO disease_chat_responses (disease_id, stage, message)
SELECT id, 'reassurance',
'Malaria is treatable when identified early. Follow professional medical advice for full recovery.'
FROM diseases WHERE name = 'Malaria';

-- MALARIA
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Artemether-Lumefantrine','Twice daily for 3 days',
'Take after meals and complete full course.',
'Seek medical care if symptoms persist.'
FROM diseases WHERE name='Malaria';

-- TYPHOID FEVER
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Ciprofloxacin','As prescribed',
'Rest and hydrate adequately.',
'Avoid self-medication.'
FROM diseases WHERE name='Typhoid Fever';

-- COMMON COLD
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Paracetamol','500mg every 6–8 hours',
'Rest and increase fluid intake.',
'Do not exceed recommended dose.'
FROM diseases WHERE name='Common Cold';

-- INFLUENZA
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Paracetamol','500mg every 6–8 hours',
'Helps reduce fever and body pain.',
'Consult a doctor if fever persists.'
FROM diseases WHERE name='Influenza (Flu)';

-- COVID-19
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Paracetamol','As needed for fever',
'Isolate and monitor symptoms.',
'Seek urgent care if breathing difficulty occurs.'
FROM diseases WHERE name='COVID-19';

-- PNEUMONIA
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Amoxicillin','As prescribed',
'Complete prescribed course.',
'Medical supervision required.'
FROM diseases WHERE name='Pneumonia';

-- TUBERCULOSIS
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Anti-TB Therapy','As prescribed',
'Strict adherence required.',
'Must be supervised by healthcare professional.'
FROM diseases WHERE name='Tuberculosis';

-- ASTHMA
INSERT INTO drugs (disease_id, name, dosage, advice, warning)
SELECT id,'Salbutamol Inhaler','As directed',
'Use during breathing difficulty.',
'Seek review for frequent attacks.'
FROM diseases WHERE name='Asthma';

CREATE TABLE symptom_synonyms (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  symptom_id uuid NOT NULL,
  synonym text NOT NULL,
  CONSTRAINT fk_symptom
    FOREIGN KEY (symptom_id)
    REFERENCES symptoms(id)
    ON DELETE CASCADE
);


-- FEVER
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'high temperature',
  'hot body',
  'burning up',
  'feeling hot',
  'pyrexia',
  'elevated temperature',
  'body heat',
  'feverish',
  'temperature',
  'hot fever'
]) FROM symptoms WHERE name='fever';

-- HEADACHE
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'head pain',
  'head hurting',
  'migraine',
  'head ache',
  'sore head',
  'painful head',
  'throbbing head',
  'pounding head',
  'splitting headache',
  'head pressure',
  'brain pain',
  'cephalalgia'
]) FROM symptoms WHERE name='headache';

-- CHILLS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'shivering',
  'shaking',
  'cold shivers',
  'feeling cold',
  'trembling',
  'shuddering',
  'rigor',
  'body shaking',
  'cold feeling',
  'teeth chattering',
  'goosebumps',
  'cold sweats'
]) FROM symptoms WHERE name='chills';

-- VOMITING
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'throwing up',
  'puking',
  'being sick',
  'retching',
  'emesis',
  'vomit',
  'spitting up',
  'bringing up food',
  'regurgitation',
  'upchucking',
  'heaving',
  'sick to stomach'
]) FROM symptoms WHERE name='vomiting';

-- FATIGUE
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'tired',
  'tiredness',
  'exhaustion',
  'weakness',
  'lack of energy',
  'lethargy',
  'weariness',
  'feeling drained',
  'low energy',
  'sluggishness',
  'feeling worn out',
  'asthenia',
  'malaise',
  'body weakness',
  'no strength'
]) FROM symptoms WHERE name='fatigue';

-- COUGH
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'coughing',
  'hacking',
  'persistent cough',
  'dry cough',
  'wet cough',
  'productive cough',
  'chesty cough',
  'tussis',
  'throat clearing',
  'hacking cough',
  'barking cough',
  'whooping'
]) FROM symptoms WHERE name='cough';

-- CHEST PAIN
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'chest hurting',
  'heart pain',
  'chest tightness',
  'chest pressure',
  'breast pain',
  'thoracic pain',
  'chest discomfort',
  'angina',
  'chest ache',
  'pain in chest',
  'tight chest',
  'squeezing chest'
]) FROM symptoms WHERE name='chest pain';

-- SHORTNESS OF BREATH
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'short breath',
  'breathlessness',
  'difficulty breathing',
  'hard to breathe',
  'gasping',
  'dyspnea',
  'labored breathing',
  'air hunger',
  'cant catch breath',
  'winded',
  'panting',
  'out of breath',
  'breathing problem',
  'suffocation feeling'
]) FROM symptoms WHERE name='shortness of breath';

-- DIARRHEA
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'loose stool',
  'watery stool',
  'running stomach',
  'frequent bowel movements',
  'upset stomach',
  'loose bowels',
  'the runs',
  'liquid stool',
  'stomach running',
  'toilet runs',
  'diarrhoea',
  'gastroenteritis symptoms'
]) FROM symptoms WHERE name='diarrhea';

-- ABDOMINAL PAIN
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'stomach pain',
  'stomach ache',
  'belly pain',
  'tummy ache',
  'gut pain',
  'abdominal cramps',
  'stomach cramps',
  'belly ache',
  'gastric pain',
  'intestinal pain',
  'lower abdomen pain',
  'upper abdomen pain',
  'mid stomach pain'
]) FROM symptoms WHERE name='abdominal pain';

-- NAUSEA
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'feeling sick',
  'queasiness',
  'upset stomach',
  'sick feeling',
  'queasy',
  'stomach upset',
  'urge to vomit',
  'feeling nauseous',
  'unsettled stomach',
  'stomach turning',
  'gag feeling',
  'motion sickness'
]) FROM symptoms WHERE name='nausea';

-- WEIGHT LOSS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'losing weight',
  'weight reduction',
  'body weight dropping',
  'slimming down',
  'getting thinner',
  'wasting',
  'cachexia',
  'unintentional weight loss',
  'sudden weight loss',
  'rapid weight loss',
  'clothes fitting loose'
]) FROM symptoms WHERE name='weight loss';

-- FREQUENT URINATION
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'peeing often',
  'urinating frequently',
  'constant urination',
  'excessive urination',
  'polyuria',
  'frequent toilet visits',
  'peeing a lot',
  'frequent passing urine',
  'need to pee often',
  'urinary frequency',
  'always need toilet'
]) FROM symptoms WHERE name='frequent urination';

-- EXCESSIVE THIRST
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'always thirsty',
  'extreme thirst',
  'constant thirst',
  'polydipsia',
  'increased thirst',
  'dry mouth',
  'thirsty all time',
  'cant quench thirst',
  'unquenchable thirst',
  'abnormal thirst',
  'drinking too much water'
]) FROM symptoms WHERE name='excessive thirst';

-- BLURRED VISION
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'blurry vision',
  'unclear vision',
  'hazy vision',
  'foggy vision',
  'cloudy vision',
  'poor vision',
  'cant see clearly',
  'vision blur',
  'fuzzy vision',
  'dim vision',
  'out of focus vision',
  'vision problems'
]) FROM symptoms WHERE name='blurred vision';

-- DIZZINESS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'dizzy',
  'lightheaded',
  'feeling faint',
  'vertigo',
  'spinning sensation',
  'head spinning',
  'room spinning',
  'unsteady',
  'off balance',
  'giddy',
  'woozy',
  'light headed',
  'balance problems'
]) FROM symptoms WHERE name='dizziness';

-- JOINT PAIN
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'joint ache',
  'arthralgia',
  'joint stiffness',
  'painful joints',
  'aching joints',
  'joint discomfort',
  'knee pain',
  'elbow pain',
  'wrist pain',
  'ankle pain',
  'joint soreness',
  'stiff joints'
]) FROM symptoms WHERE name='joint pain';

-- SKIN RASH
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'rash',
  'skin eruption',
  'skin bumps',
  'skin spots',
  'red spots',
  'skin irritation',
  'itchy skin',
  'skin breakout',
  'hives',
  'skin lesions',
  'skin outbreak',
  'dermatitis',
  'eczema'
]) FROM symptoms WHERE name='skin rash';

-- SORE THROAT
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'throat pain',
  'painful throat',
  'scratchy throat',
  'throat hurting',
  'pharyngitis',
  'throat ache',
  'raw throat',
  'irritated throat',
  'burning throat',
  'swollen throat',
  'throat discomfort',
  'difficulty swallowing'
]) FROM symptoms WHERE name='sore throat';

-- LOSS OF APPETITE
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'no appetite',
  'not hungry',
  'dont want to eat',
  'anorexia',
  'reduced appetite',
  'poor appetite',
  'lack of hunger',
  'food aversion',
  'not feeling like eating',
  'decreased appetite',
  'appetite loss',
  'no desire to eat'
]) FROM symptoms WHERE name='loss of appetite';

-- NIGHT SWEATS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'sweating at night',
  'night time sweating',
  'nocturnal sweating',
  'waking up sweating',
  'drenched in sweat',
  'excessive night sweating',
  'sleep sweating',
  'bed sheets wet',
  'sweating while sleeping',
  'night perspiration'
]) FROM symptoms WHERE name='night sweats';

-- WHEEZING
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'whistling breath',
  'noisy breathing',
  'chest whistling',
  'breathing sounds',
  'raspy breathing',
  'labored breathing sound',
  'bronchial wheezing',
  'tight breathing',
  'stridor',
  'breath whistling'
]) FROM symptoms WHERE name='wheezing';

-- WEAKNESS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'weak',
  'body weakness',
  'muscle weakness',
  'feeling weak',
  'lack of strength',
  'feeble',
  'frail',
  'debility',
  'no energy',
  'physical weakness',
  'general weakness',
  'overall weakness',
  'asthenia'
]) FROM symptoms WHERE name='weakness';

-- CONFUSION
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'confused',
  'disoriented',
  'mental confusion',
  'foggy mind',
  'cant think clearly',
  'bewildered',
  'muddled',
  'mental fog',
  'cognitive impairment',
  'delirium',
  'altered mental state',
  'brain fog'
]) FROM symptoms WHERE name='confusion';

-- SEIZURES
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'convulsions',
  'fits',
  'epileptic attack',
  'shaking attack',
  'spasms',
  'epilepsy',
  'seizure episode',
  'convulsive attack',
  'falling sickness',
  'uncontrolled shaking',
  'loss of consciousness attack'
]) FROM symptoms WHERE name='seizures';

-- DEPRESSION
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'feeling depressed',
  'sadness',
  'low mood',
  'feeling down',
  'hopelessness',
  'despair',
  'melancholy',
  'feeling blue',
  'unhappiness',
  'emotional pain',
  'major depression',
  'clinical depression',
  'persistent sadness'
]) FROM symptoms WHERE name='depression';

-- ANXIETY
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'feeling anxious',
  'nervousness',
  'worry',
  'panic',
  'unease',
  'restlessness',
  'fear',
  'panic attacks',
  'feeling on edge',
  'stress',
  'tension',
  'apprehension',
  'nervous feeling'
]) FROM symptoms WHERE name='anxiety';

-- INSOMNIA
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'cant sleep',
  'sleeplessness',
  'trouble sleeping',
  'difficulty sleeping',
  'sleep problems',
  'unable to sleep',
  'sleep disorder',
  'wakefulness',
  'poor sleep',
  'restless sleep',
  'sleep deprivation',
  'lying awake',
  'tossing and turning'
]) FROM symptoms WHERE name='insomnia';

-- OBESITY
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'overweight',
  'excess weight',
  'excess body fat',
  'being obese',
  'heavy weight',
  'fat',
  'corpulent',
  'weight gain',
  'excessive weight',
  'high BMI',
  'adiposity'
]) FROM symptoms WHERE name='obesity';

-- SWELLING
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'edema',
  'puffiness',
  'bloating',
  'inflammation',
  'swollen',
  'fluid retention',
  'puffy',
  'enlarged',
  'distended',
  'tumid',
  'water retention',
  'body swelling'
]) FROM symptoms WHERE name='swelling';

-- YELLOW EYES
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'jaundice',
  'yellow skin',
  'yellowish eyes',
  'icterus',
  'yellowing of eyes',
  'scleral icterus',
  'yellow sclera',
  'yellow tinge eyes',
  'jaundiced eyes',
  'golden eyes'
]) FROM symptoms WHERE name='yellow eyes';

-- DARK URINE
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'brown urine',
  'tea colored urine',
  'cola colored urine',
  'darkened urine',
  'concentrated urine',
  'discolored urine',
  'murky urine',
  'amber urine',
  'deep yellow urine',
  'rust colored urine'
]) FROM symptoms WHERE name='dark urine';

-- BLEEDING
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'blood loss',
  'hemorrhage',
  'bleeding episode',
  'blood flow',
  'hemorrhaging',
  'blood coming out',
  'bleeding from',
  'loss of blood',
  'excessive bleeding',
  'abnormal bleeding',
  'blood discharge'
]) FROM symptoms WHERE name='bleeding';

-- VISION LOSS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'losing vision',
  'cant see',
  'blindness',
  'sight loss',
  'visual impairment',
  'loss of sight',
  'decreased vision',
  'vision deterioration',
  'going blind',
  'visual loss',
  'partial blindness',
  'reduced vision'
]) FROM symptoms WHERE name='vision loss';

-- EYE PAIN
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'eye hurting',
  'painful eyes',
  'eye ache',
  'sore eyes',
  'eye discomfort',
  'ocular pain',
  'eye pressure',
  'burning eyes',
  'stabbing eye pain',
  'sharp eye pain',
  'throbbing eyes'
]) FROM symptoms WHERE name='eye pain';

-- NECK STIFFNESS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'stiff neck',
  'neck pain',
  'rigid neck',
  'cant move neck',
  'neck rigidity',
  'painful neck',
  'tight neck',
  'neck soreness',
  'cervical stiffness',
  'frozen neck',
  'locked neck'
]) FROM symptoms WHERE name='neck stiffness';

-- MUSCLE SPASMS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'muscle cramps',
  'cramping',
  'muscle twitching',
  'spasm',
  'charley horse',
  'muscle contractions',
  'involuntary muscle movement',
  'muscle jerking',
  'muscle knots',
  'tight muscles',
  'muscle seizure'
]) FROM symptoms WHERE name='muscle spasms';

-- PARALYSIS
INSERT INTO symptom_synonyms (symptom_id, synonym)
SELECT id, unnest(ARRAY[
  'cant move',
  'unable to move',
  'loss of movement',
  'immobility',
  'motor loss',
  'limb paralysis',
  'body paralysis',
  'loss of motor function',
  'plegia',
  'muscle paralysis',
  'functional loss',
  'movement loss'
]) FROM symptoms WHERE name='paralysis';
