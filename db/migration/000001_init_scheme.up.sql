# ブックマークテーブル (ユーザーが作品をブックマークする)
CREATE TABLE `bookmarks` (
  `work_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# 所属テーブル
CREATE TABLE `affiliations` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# イベントテーブル
CREATE TABLE `events` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `password` Varchar(255),
  `is_requires_password` bool DEFAULT false,
  `start_at` DATETIME(0),
  `end_at` DATETIME(0),
  `need_proofreading` bool DEFAULT false,
  `icon_url` VARCHAR(255),
  `description` TEXT,
  `detail` Text,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# ジャンルテーブル
CREATE TABLE `genres` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# 職種テーブル
CREATE TABLE `occupations` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

CREATE TABLE `authorities` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

CREATE TABLE `technologies` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

CREATE TABLE `users` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `firebase_uid` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(50),
  `affiliation_id` INTEGER,
  `enrollment_year` INTEGER,
  `graduation_year` INTEGER,
  `is_job_hunt_completed` BOOLEAN DEFAULT false,
  `self_introduction` TEXT,
  `icon_url` VARCHAR(255),
  `show_profile_in_public_event` BOOLEAN DEFAULT false,
  `show_profile_in_shared_url` BOOLEAN DEFAULT false,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# ユーザーと職種の中間テーブル
CREATE TABLE `user_occupations` (
  `user_id` INTEGER NOT NULL,
  `occupation_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  PRIMARY KEY (`user_id`, `occupation_id`)
);

# ユーザは複数のURLを持つことができる
CREATE TABLE `user_urls` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INTEGER NOT NULL,
  `url_name` VARCHAR(30) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# 作品テーブル
CREATE TABLE `works` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `event_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# 作品データテーブル
CREATE TABLE `work_data` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `work_id` INTEGER NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `catch_copy` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `work_url` VARCHAR(255),
  `movie_url` VARCHAR(255),
  `system_diagram_url` VARCHAR(255),
  `thumbnail_url` VARCHAR(255),
  `detail` TEXT,
  `is_approved` BOOLEAN NOT NULL DEFAULT false,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# 作品データとジャンルの中間テーブル
CREATE TABLE `work_data_genres` (
  `work_data_id` INTEGER NOT NULL,
  `genre_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  PRIMARY KEY (`work_data_id`, `genre_id`)
);

# 作品データと技術の中間テーブル
CREATE TABLE `work_data_technologies` (
  `work_data_id` INTEGER NOT NULL,
  `technology_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  PRIMARY KEY (`work_data_id`, `technology_id`)
);

# 作品データとユーザーの中間テーブル
CREATE TABLE `work_data_users` (
  `work_data_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `role_explanation` VARCHAR(50),
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  PRIMARY KEY (`work_data_id`, `user_id`)
);

# 使用ツールテーブル
CREATE TABLE `tools` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# イベントとユーザと権限の中間テーブル
CREATE TABLE `event_user_authorities` (
  `event_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `authority_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  PRIMARY KEY (`event_id`, `user_id`, `authority_id`)
);

# 作品データと画像の中間テーブル
CREATE TABLE `work_data_images` (
  `id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `work_data_id` INTEGER NOT NULL,
  `url` VARCHAR(255),
  `order` TINYINT,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0))
);

# 作品データと使用ツールの中間テーブル
CREATE TABLE `work_data_tools` (
  `work_data_id` INTEGER NOT NULL,
  `tool_id` INTEGER NOT NULL,
  `created_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  `updated_at` DATETIME(0) DEFAULT (CURRENT_TIMESTAMP(0)),
  PRIMARY KEY (`work_data_id`, `tool_id`)
);

CREATE INDEX `Bookmark_user_id_idx` ON `bookmarks` (`user_id`);

CREATE INDEX `Bookmark_work_id_idx` ON `bookmarks` (`work_id`);

CREATE UNIQUE INDEX `email` ON `users` (`email`);

CREATE INDEX `User_occupation_occupation_id_idx` ON `user_occupations` (`occupation_id`);

CREATE INDEX `User_occupation_user_id_idx` ON `user_occupations` (`user_id`);

CREATE INDEX `User_url_user_id_idx` ON `user_urls` (`user_id`);

CREATE INDEX `Work_event_id_idx` ON `works` (`event_id`);

CREATE INDEX `Work_data_work_id_idx` ON `work_data` (`work_id`);

CREATE INDEX `Work_data_genre_genre_id_idx` ON `work_data_genres` (`genre_id`);

CREATE INDEX `Work_data_genre_work_data_id_idx` ON `work_data_genres` (`work_data_id`);

CREATE INDEX `Work_data_technology_technology_id_idx` ON `work_data_technologies` (`technology_id`);

CREATE INDEX `Work_data_technology_work_data_id_idx` ON `work_data_technologies` (`work_data_id`);

CREATE INDEX `Work_data_user_user_id_idx` ON `work_data_users` (`user_id`);

CREATE INDEX `Work_data_user_work_data_id_idx` ON `work_data_users` (`work_data_id`);

CREATE INDEX `Event_user_authority_event_id_idx` ON `event_user_authorities` (`event_id`);

CREATE INDEX `Event_user_authority_authority_id_idx` ON `event_user_authorities` (`authority_id`);

CREATE INDEX `Event_user_authority_user_id_idx` ON `event_user_authorities` (`user_id`);

CREATE INDEX `Work_data_image_work_data_id_idx` ON `work_data_images` (`work_data_id`);

CREATE INDEX `Work_data_tool_tool_id_idx` ON `work_data_tools` (`tool_id`);

CREATE INDEX `Work_data_tool_work_data_id_idx` ON `work_data_tools` (`work_data_id`);

ALTER TABLE `bookmarks` ADD CONSTRAINT `Bookmark_work_id_fkey` FOREIGN KEY (`work_id`) REFERENCES `works` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `bookmarks` ADD CONSTRAINT `Bookmark_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `users` ADD CONSTRAINT `User_affiliations_id_fkey` FOREIGN KEY (`affiliation_id`) REFERENCES `affiliations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `user_occupations` ADD CONSTRAINT `User_occupation_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `user_occupations` ADD CONSTRAINT `User_occupation_occupation_id_fkey` FOREIGN KEY (`occupation_id`) REFERENCES `occupations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `user_urls` ADD CONSTRAINT `User_url_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `works` ADD CONSTRAINT `Work_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data` ADD CONSTRAINT `Work_data_work_id_fkey` FOREIGN KEY (`work_id`) REFERENCES `works` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_genres` ADD CONSTRAINT `Work_data_genre_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_genres` ADD CONSTRAINT `Work_data_genre_genre_id_fkey` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_technologies` ADD CONSTRAINT `Work_data_technology_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_technologies` ADD CONSTRAINT `Work_data_technology_technology_id_fkey` FOREIGN KEY (`technology_id`) REFERENCES `technologies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_users` ADD CONSTRAINT `Work_data_user_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_users` ADD CONSTRAINT `Work_data_user_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `event_user_authorities` ADD CONSTRAINT `Event_user_authority_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `event_user_authorities` ADD CONSTRAINT `Event_user_authority_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `event_user_authorities` ADD CONSTRAINT `Event_user_authority_authority_id_fkey` FOREIGN KEY (`authority_id`) REFERENCES `authorities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_images` ADD CONSTRAINT `Work_data_image_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_tools` ADD CONSTRAINT `Work_data_tool_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `work_data_tools` ADD CONSTRAINT `Work_data_tool_tool_id_fkey` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
