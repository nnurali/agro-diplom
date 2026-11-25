-- 1. Пайдаланушылар кестесі (D1: Users)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('farmer', 'agronomist', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Егістік алқаптары кестесі (D2: Fields)
CREATE TABLE Fields (
    field_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    field_name VARCHAR(100) NOT NULL,
    area_hectares DECIMAL(10, 2) NOT NULL CHECK (area_hectares > 0),
    soil_type VARCHAR(50) NOT NULL,
    coordinates VARCHAR(100) NOT NULL,
    CONSTRAINT fk_field_user FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 3. Дақылдар анықтамалығы (D3: Crops)
CREATE TABLE Crops (
    crop_id INT AUTO_INCREMENT PRIMARY KEY,
    crop_name VARCHAR(100) NOT NULL,
    variety VARCHAR(100) NOT NULL,
    growth_days INT NOT NULL CHECK (growth_days > 0),
    optimal_temp VARCHAR(30) NOT NULL
);

-- 4. Алқапқа егілген дақылдар - M:N байланысын шешетін аралық кесте (D4: Field_Crops)
CREATE TABLE Field_Crops (
    field_crop_id INT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    crop_id INT NOT NULL,
    planting_date DATE NOT NULL,
    harvest_date DATE,
    yield_tons DECIMAL(10, 2) DEFAULT 0,
    CONSTRAINT fk_fc_field FOREIGN KEY (field_id) REFERENCES Fields(field_id) ON DELETE CASCADE,
    CONSTRAINT fk_fc_crop FOREIGN KEY (crop_id) REFERENCES Crops(crop_id) ON DELETE RESTRICT
);

-- 5. Агротехникалық шаралар кестесі (D5: Agro_Tasks)
CREATE TABLE Agro_Tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    field_crop_id INT NOT NULL,
    task_type VARCHAR(100) NOT NULL,
    scheduled_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL CHECK (status IN ('Жоспарланған', 'Орындалуда', 'Орындалды')),
    notes TEXT,
    CONSTRAINT fk_task_fc FOREIGN KEY (field_crop_id) REFERENCES Field_Crops(field_crop_id) ON DELETE CASCADE
);

-- 6. Ауа райы ескертулері кестесі (D6: Weather_Alerts)
CREATE TABLE Weather_Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    alert_type VARCHAR(100) NOT NULL,
    temperature DECIMAL(5, 2) NOT NULL,
    humidity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_alert_field FOREIGN KEY (field_id) REFERENCES Fields(field_id) ON DELETE CASCADE
);

-- Тестілік жазбалар (INSERT)
INSERT INTO Users (full_name, phone_number, role) VALUES
('Ерлан Сүлейменов', '+77015551122', 'farmer'),
('Айгүл Нұрланова', '+77024443322', 'agronomist'),
('Дәурен Қасымов', '+77057778899', 'farmer'),
('Марат Беков', '+77071112233', 'admin');

INSERT INTO Fields (user_id, field_name, area_hectares, soil_type, coordinates) VALUES
(1, 'Солтүстік-1 алқабы', 150.50, 'Қара топырақ', '43.2389, 76.8897'),
(1, 'Өзен жағасы алқабы', 85.00, 'Саздақ топырақ', '43.2510, 76.9120'),
(3, 'Оңтүстік дала', 210.00, 'Қоңыр топырақ', '42.3417, 69.5901'),
(3, 'Шығыс беткей', 60.25, 'Қара топырақ', '42.3600, 69.6100');

INSERT INTO Crops (crop_name, variety, growth_days, optimal_temp) VALUES
('Бидай', 'Саратовская-29', 110, '18-24°C'),
('Жүгері', 'Қазақстандық-43', 125, '22-28°C'),
('Күнбағыс', 'Заря', 105, '20-26°C'),
('Арпа', 'Бәйшешек', 95, '16-22°C');

INSERT INTO Field_Crops (field_id, crop_id, planting_date, harvest_date, yield_tons) VALUES
(1, 1, '2026-04-15', '2026-08-10', 420.50),
(2, 2, '2026-05-01', '2026-09-05', 310.00),
(3, 3, '2026-04-20', '2026-08-15', 380.75),
(4, 1, '2026-04-18', '2026-08-12', 165.20);

INSERT INTO Agro_Tasks (field_crop_id, task_type, scheduled_date, status, notes) VALUES
(1, 'Тыңайтқыш себу (Азот)', '2026-05-20', 'Орындалды', 'Гектарына 120 кг себілді'),
(1, 'Арамшөптерге қарсы бүрку', '2026-06-10', 'Орындалды', 'Гербицид қолданылды'),
(2, 'Тамшылатып суару', '2026-06-15', 'Орындалуда', 'Ылғалдылық 65%-ға жеткізілді'),
(3, 'Топырақты қопсыту', '2026-05-25', 'Жоспарланған', 'Жаңбырдан кейін жүргізу керек');

INSERT INTO Weather_Alerts (field_id, alert_type, temperature, humidity) VALUES
(1, 'Қатты ыстық және құрғақшылық қаупі', 36.5, 22),
(2, 'Нөсер жаңбыр ескертуі', 17.0, 88),
(3, 'Үсік жүру қаупі', 1.5, 75),
(4, 'Қолайлы ауа райы', 23.0, 55);

-- 1-сұраныс: Кемінде 3 кестені JOIN арқылы біріктіру
SELECT
    u.full_name AS фермер,
    f.field_name AS алқап_атауы,
    f.area_hectares AS ауданы_га,
    c.crop_name AS дақыл,
    c.variety AS сұрпы,
    fc.yield_tons AS өнім_тонна
FROM Field_Crops fc
JOIN Fields f ON fc.field_id = f.field_id
JOIN Users u ON f.user_id = u.user_id
JOIN Crops c ON fc.crop_id = c.crop_id
ORDER BY fc.yield_tons DESC;

-- 2-сұраныс: GROUP BY қолдану
SELECT
    c.crop_name AS дақыл_атауы,
    COUNT(fc.field_crop_id) AS алқап_саны,
    SUM(fc.yield_tons) AS жалпы_өнім_тонна,
    ROUND(AVG(fc.yield_tons), 2) AS орташа_өнім_тонна
FROM Crops c
JOIN Field_Crops fc ON c.crop_id = fc.crop_id
GROUP BY c.crop_name
ORDER BY жалпы_өнім_тонна DESC;