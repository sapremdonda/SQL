-- ==========================================
-- NOTES APP DATABASE SCHEMA & QUERIES
-- ==========================================

-- 1. CREATE: Build the structure for the notes
-- Note: Using AUTO_INCREMENT for MySQL. (If using PostgreSQL, swap to 'SERIAL')
CREATE TABLE notes (
    note_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    category VARCHAR(50) DEFAULT 'General',
    is_pinned BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. INSERT: Add some sample data so the teacher has something to look at
INSERT INTO notes (title, content, category, is_pinned) 
VALUES
    ('SQL Basics', 'SELECT extracts data, INSERT adds it, UPDATE changes it.', 'Study', TRUE),
    ('Grocery List', 'Milk, Eggs, Bread, Coffee (the good kind)', 'Personal', FALSE),
    ('Project Ideas', 'Build a mini social media app with Vue and Tailwind.', 'Coding', TRUE),
    ('Weekend Plans', 'Catch up on sleep, maybe hike if it does not rain.', 'Personal', FALSE);

-- ==========================================
-- DEMONSTRATION QUERIES (For Review)
-- ==========================================

-- 3. READ: Get everything
SELECT * FROM notes;

-- 4. READ: Filter by a specific category
SELECT title, content, created_at 
FROM notes 
WHERE category = 'Study';

-- 5. READ: Order the notes (Pinned first, then newest)
SELECT title, category, is_pinned 
FROM notes 
ORDER BY is_pinned DESC, created_at DESC;

-- 6. UPDATE: Modify an existing note
UPDATE notes 
SET content = 'Milk, Eggs, Bread, Coffee, AND OATMEAL!', updated_at = CURRENT_TIMESTAMP
WHERE title = 'Grocery List';

-- 7. DELETE: Remove a note we no longer need
DELETE FROM notes 
WHERE title = 'Weekend Plans';
