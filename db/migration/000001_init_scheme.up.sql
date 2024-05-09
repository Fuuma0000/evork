# ブックマークテーブル (ユーザーが作品をブックマークする)
CREATE TABLE `bookmarks` (
  `user_id` INTEGER UNSIGNED NOT NULL,
  `work_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 所属テーブル
CREATE TABLE `affiliations` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# イベントテーブル
CREATE TABLE `events` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `password` Varchar(255),
  `is_requires_password` BOOLEAN NOT NULL DEFAULT false,
  `start_at` TIMESTAMP,
  `end_at` TIMESTAMP,
  `need_proofreading` BOOLEAN NOT NULL DEFAULT false, # 校閲が必要かどうか
  `icon_url` VARCHAR(255),
  `description` TEXT,
  `detail` Text,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# ジャンルテーブル
CREATE TABLE `genres` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 職種テーブル
CREATE TABLE `occupations` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 権限テーブル
CREATE TABLE `authorities` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 使用技術テーブル
CREATE TABLE `technologies` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `users` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `firebase_uid` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `affiliation_id` INTEGER UNSIGNED NOT NULL DEFAULT 1,
  `enrollment_year` INTEGER NOT NULL,
  `graduation_year` INTEGER NOT NULL,
  `is_job_hunt_completed` BOOLEAN NOT NULL DEFAULT false,
  `self_introduction` TEXT NOT NULL DEFAULT '',
  `icon_url` VARCHAR(255),
  `show_profile_in_public_event` BOOLEAN NOT NULL DEFAULT false,
  `show_profile_in_shared_url` BOOLEAN NOT NULL DEFAULT false,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# ユーザーと職種の中間テーブル
CREATE TABLE `user_occupations` (
  `user_id` INTEGER UNSIGNED NOT NULL,
  `occupation_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `occupation_id`)
);

# ユーザは複数のURLを持つことができる
CREATE TABLE `user_urls` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `user_id` INTEGER UNSIGNED NOT NULL,
  `url_name` VARCHAR(30) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 作品テーブル
CREATE TABLE `works` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `event_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 作品データテーブル
CREATE TABLE `work_data` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `work_id` INTEGER UNSIGNED NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `work_url` VARCHAR(255),
  `movie_url` VARCHAR(255),
  `system_diagram_url` VARCHAR(255),
  `thumbnail_url` VARCHAR(255),
  `detail` TEXT,
  `is_approved` BOOLEAN NOT NULL DEFAULT false,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 作品データとジャンルの中間テーブル
CREATE TABLE `work_data_genres` (
  `work_data_id` INTEGER UNSIGNED NOT NULL,
  `genre_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`work_data_id`, `genre_id`)
);

# 作品データと技術の中間テーブル
CREATE TABLE `work_data_technologies` (
  `work_data_id` INTEGER UNSIGNED NOT NULL,
  `technology_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`work_data_id`, `technology_id`)
);

# 作品データとユーザーの中間テーブル
CREATE TABLE `work_data_users` (
  `work_data_id` INTEGER UNSIGNED NOT NULL,
  `user_id` INTEGER UNSIGNED NOT NULL,
  `role_explanation` VARCHAR(50) NOT NULL DEFAULT '',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`work_data_id`, `user_id`)
);

# 使用ツールテーブル
CREATE TABLE `tools` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# イベントとユーザと権限の中間テーブル
CREATE TABLE `event_user_authorities` (
  `event_id` INTEGER UNSIGNED NOT NULL,
  `user_id` INTEGER UNSIGNED NOT NULL,
  `authority_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_id`, `user_id`, `authority_id`)
);

# 作品データと画像の中間テーブル
CREATE TABLE `work_data_images` (
  `id` INTEGER UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `work_data_id` INTEGER UNSIGNED NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `order` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# 作品データと使用ツールの中間テーブル
CREATE TABLE `work_data_tools` (
  `work_data_id` INTEGER UNSIGNED NOT NULL,
  `tool_id` INTEGER UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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

ALTER TABLE
  `bookmarks`
ADD
  CONSTRAINT `Bookmark_work_id_fkey` FOREIGN KEY (`work_id`) REFERENCES `works` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `bookmarks`
ADD
  CONSTRAINT `Bookmark_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `users`
ADD
  CONSTRAINT `User_affiliations_id_fkey` FOREIGN KEY (`affiliation_id`) REFERENCES `affiliations` (`id`) ON DELETE
SET
  NULL ON UPDATE CASCADE;

ALTER TABLE
  `user_occupations`
ADD
  CONSTRAINT `User_occupation_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `user_occupations`
ADD
  CONSTRAINT `User_occupation_occupation_id_fkey` FOREIGN KEY (`occupation_id`) REFERENCES `occupations` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `user_urls`
ADD
  CONSTRAINT `User_url_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `works`
ADD
  CONSTRAINT `Work_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data`
ADD
  CONSTRAINT `Work_data_work_id_fkey` FOREIGN KEY (`work_id`) REFERENCES `works` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_genres`
ADD
  CONSTRAINT `Work_data_genre_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_genres`
ADD
  CONSTRAINT `Work_data_genre_genre_id_fkey` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_technologies`
ADD
  CONSTRAINT `Work_data_technology_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_technologies`
ADD
  CONSTRAINT `Work_data_technology_technology_id_fkey` FOREIGN KEY (`technology_id`) REFERENCES `technologies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_users`
ADD
  CONSTRAINT `Work_data_user_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_users`
ADD
  CONSTRAINT `Work_data_user_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `event_user_authorities`
ADD
  CONSTRAINT `Event_user_authority_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `event_user_authorities`
ADD
  CONSTRAINT `Event_user_authority_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `event_user_authorities`
ADD
  CONSTRAINT `Event_user_authority_authority_id_fkey` FOREIGN KEY (`authority_id`) REFERENCES `authorities` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_images`
ADD
  CONSTRAINT `Work_data_image_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_tools`
ADD
  CONSTRAINT `Work_data_tool_work_data_id_fkey` FOREIGN KEY (`work_data_id`) REFERENCES `work_data` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE
  `work_data_tools`
ADD
  CONSTRAINT `Work_data_tool_tool_id_fkey` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
