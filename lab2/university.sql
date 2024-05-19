-- Создание роли для подключения к базе
CREATE ROLE university_role WITH LOGIN PASSWORD 'password';
GRANT CONNECT ON DATABASE university TO university_role;

-- Создание базы данных
CREATE DATABASE university OWNER university_role;

-- Подключение к базе данных
\c university

-- Создание таблиц и индексов

-- Таблица StudentGroup
CREATE TABLE StudentGroup (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица Student
CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    group_id INTEGER REFERENCES StudentGroup(id)
);

-- Таблица Subject
CREATE TABLE Subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица Teacher
CREATE TABLE Teacher (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица связи между Subject и Teacher (Subject_Teacher)
CREATE TABLE Subject_Teacher (
    id SERIAL PRIMARY KEY,
    subject_id INTEGER REFERENCES Subject(id),
    teacher_id INTEGER REFERENCES Teacher(id)
);

-- Таблица Grade
CREATE TABLE Grade (
    id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES Student(id),
    subject_id INTEGER REFERENCES Subject(id),
    grade INTEGER NOT NULL CHECK (grade >= 2 AND grade <= 5),
    date DATE NOT NULL
);

-- Индексы для оптимизации запросов
CREATE INDEX idx_student_group_id ON Student(group_id);
CREATE INDEX idx_grade_student_id ON Grade(student_id);
CREATE INDEX idx_grade_subject_id ON Grade(subject_id);

-- Заполнение таблиц данными

-- Заполнение таблицы StudentGroup
INSERT INTO StudentGroup (name) VALUES ('PIN-43'), ('M-12');

-- Заполнение таблицы Student
INSERT INTO Student (name, group_id) VALUES 
('Иванов Иван Иванович', 1), 
('Петров Петр Петрович', 1), 
('Сидоров Сидор Сидорович', 1), 
('Кузнецов Николай Николаевич', 1),
('Смирнов Сергей Сергеевич', 2), 
('Попов Павел Павлович', 2), 
('Васильев Василий Васильевич', 2), 
('Алексеев Алексей Алексеевич', 2);

-- Заполнение таблицы Subject
INSERT INTO Subject (name) VALUES 
('Math'), ('Physics'), ('Chemistry'), ('Biology'), 
('History'), ('Literature'), ('Art'), ('Computer Science');

-- Заполнение таблицы Teacher
INSERT INTO Teacher (name) VALUES 
('Эйнштейн Альберт'), 
('Кюри Мария'), 
('Менделеев Дмитрий'), 
('Дарвин Чарльз'), 
('Тесла Никола'), 
('Ньютон Исаак'), 
('Фейнман Ричард'), 
('Тьюринг Алан');

-- Заполнение таблицы Subject_Teacher
INSERT INTO Subject_Teacher (subject_id, teacher_id) VALUES 
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 3), (7, 4), (8, 4);

-- Заполнение таблицы Grade
INSERT INTO Grade (student_id, subject_id, grade, date) VALUES 
(1, 1, 4, '2023-09-15'), (1, 1, 5, '2023-11-15'),
(1, 2, 3, '2023-10-01'), (1, 2, 4, '2024-02-10'),
(2, 2, 3, '2023-09-20'), (2, 2, 4, '2024-01-18'),
(2, 3, 4, '2023-12-01'), (2, 3, 5, '2024-03-15'),
(3, 3, 2, '2023-10-05'), (3, 3, 3, '2024-02-20'),
(3, 4, 2, '2023-11-25'), (3, 4, 3, '2024-04-05'),
(4, 4, 3, '2023-09-10'), (4, 4, 4, '2024-01-30'),
(4, 5, 4, '2023-10-15'), (4, 5, 5, '2024-05-10'),
(5, 5, 5, '2023-11-05'), (5, 5, 4, '2024-03-25'),
(5, 6, 3, '2023-12-15'), (5, 6, 5, '2024-02-05'),
(6, 6, 2, '2023-09-12'), (6, 6, 4, '2024-01-15'),
(6, 7, 4, '2023-11-20'), (6, 7, 5, '2024-04-15'),
(7, 7, 3, '2023-10-18'), (7, 7, 4, '2024-05-01'),
(7, 8, 2, '2023-11-08'), (7, 8, 3, '2024-03-20'),
(8, 8, 3, '2023-09-18'), (8, 8, 5, '2024-02-25'),
(8, 1, 4, '2023-12-10'), (8, 1, 5, '2024-05-15');
