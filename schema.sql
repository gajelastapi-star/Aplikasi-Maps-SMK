CREATE TABLE IF NOT EXISTS students (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username_normalized VARCHAR(191) NOT NULL UNIQUE,
    username_display VARCHAR(191) NOT NULL,
    secondary_username_normalized VARCHAR(191) NULL,
    secondary_username_display VARCHAR(191) NULL,
    password VARCHAR(50) NOT NULL,
    name VARCHAR(191) NOT NULL,
    class_name VARCHAR(100) NOT NULL,
    jurusan VARCHAR(100) NOT NULL,
    absen_no VARCHAR(20) NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    bio VARCHAR(191) NOT NULL DEFAULT 'SISWA SMK NEGERI 2 SRAGEN',
    active_session_token VARCHAR(128) NULL,
    active_session_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_students_jurusan ON students (jurusan);
CREATE INDEX idx_students_class_name ON students (class_name);

CREATE TABLE IF NOT EXISTS attendance_reports (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    absen_no VARCHAR(20) NOT NULL,
    name VARCHAR(191) NOT NULL,
    class_name VARCHAR(100) NOT NULL,
    jurusan VARCHAR(100) NOT NULL,
    lat DOUBLE NULL,
    lng DOUBLE NULL,
    photo LONGTEXT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    active_until BIGINT NULL,
    timestamp BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_attendance_student (student_id),
    INDEX idx_attendance_timestamp (timestamp),
    INDEX idx_attendance_class_name (class_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS system_settings (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default settings
INSERT INTO system_settings (setting_key, setting_value) VALUES
('allow_outside_absence', 'false')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
