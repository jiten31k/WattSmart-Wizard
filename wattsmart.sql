-- WattSmart Wizard MySQL Schema

-- Users Table: Stores user data
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('household', 'industry') NOT NULL,
    signup_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Devices Table: Stores device data monitored
CREATE TABLE Devices (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    device_name VARCHAR(50) NOT NULL,
    device_type ENUM('AC', 'Heater', 'Refrigerator', 'Washer', 'Cooler', 'Others') NOT NULL,
    rated_power_kW FLOAT NOT NULL,
    installation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Energy Consumption Table: Tracks energy usage data
CREATE TABLE EnergyConsumption (
    consumption_id INT AUTO_INCREMENT PRIMARY KEY,
    device_id INT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    power_usage_kW FLOAT NOT NULL,
    energy_cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (device_id) REFERENCES Devices(device_id) ON DELETE CASCADE
);

-- Notifications Table: Stores alerts for users about energy use
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    notification_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Recommendations Table: Stores AI-generated energy-saving recommendations
CREATE TABLE Recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    recommendation TEXT NOT NULL,
    recommended_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Energy Audit Report Table: Stores detailed audit information
CREATE TABLE EnergyAuditReports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    report_data TEXT NOT NULL,
    generated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
