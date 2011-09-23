SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='MYSQL40';


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE  TABLE IF NOT EXISTS `region` (
  `region_id` TINYINT UNSIGNED NOT NULL ,
  `region_code` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`region_id`) ,
  UNIQUE INDEX `uq_region` (`region_code` ASC) )
ENGINE = InnoDB
COMMENT = '地域';


-- -----------------------------------------------------
-- Table `area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `area` ;

CREATE  TABLE IF NOT EXISTS `area` (
  `area_id` SMALLINT UNSIGNED NOT NULL ,
  `area_code` VARCHAR(31) NOT NULL ,
  `region_id` TINYINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`area_id`) ,
  INDEX `fk_area_region1` (`region_id` ASC) ,
  UNIQUE INDEX `uq_area` (`area_code` ASC) ,
  CONSTRAINT `fk_area_region1`
    FOREIGN KEY (`region_id` )
    REFERENCES `region` (`region_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region_i18n` ;

CREATE  TABLE IF NOT EXISTS `region_i18n` (
  `region_id` TINYINT UNSIGNED NOT NULL ,
  `culture` CHAR(2) NOT NULL ,
  `name` VARCHAR(31) NOT NULL ,
  PRIMARY KEY (`region_id`, `culture`) ,
  INDEX `fk_region_i18n_region` (`region_id` ASC) ,
  CONSTRAINT `fk_region_i18n_region`
    FOREIGN KEY (`region_id` )
    REFERENCES `region` (`region_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `area_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `area_i18n` ;

CREATE  TABLE IF NOT EXISTS `area_i18n` (
  `area_id` SMALLINT UNSIGNED NOT NULL ,
  `culture` CHAR(2) NOT NULL ,
  `name` VARCHAR(31) NOT NULL ,
  PRIMARY KEY (`area_id`, `culture`) ,
  INDEX `fk_area_i18n_area1` (`area_id` ASC) ,
  CONSTRAINT `fk_area_i18n_area1`
    FOREIGN KEY (`area_id` )
    REFERENCES `area` (`area_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `point`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `point` ;

CREATE  TABLE IF NOT EXISTS `point` (
  `point_id` SMALLINT UNSIGNED NOT NULL ,
  `point_code` VARCHAR(31) NOT NULL ,
  `area_id` SMALLINT UNSIGNED NOT NULL ,
  `lat` DECIMAL(9,6) UNSIGNED NOT NULL ,
  `lng` DECIMAL(9,6) UNSIGNED NOT NULL ,
  PRIMARY KEY (`point_id`) ,
  INDEX `fk_point_area1` (`area_id` ASC) ,
  UNIQUE INDEX `uq_point` (`point_code` ASC) ,
  CONSTRAINT `fk_point_area1`
    FOREIGN KEY (`area_id` )
    REFERENCES `area` (`area_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `point_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `point_i18n` ;

CREATE  TABLE IF NOT EXISTS `point_i18n` (
  `point_id` SMALLINT UNSIGNED NOT NULL ,
  `culture` CHAR(2) NOT NULL ,
  `name` VARCHAR(31) NOT NULL ,
  PRIMARY KEY (`point_id`, `culture`) ,
  INDEX `fk_point_i18n_point1` (`point_id` ASC) ,
  CONSTRAINT `fk_point_i18n_point1`
    FOREIGN KEY (`point_id` )
    REFERENCES `point` (`point_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amedas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `amedas` ;

CREATE  TABLE IF NOT EXISTS `amedas` (
  `point_id` SMALLINT UNSIGNED NOT NULL ,
  `observed_at` DATETIME NOT NULL ,
  `temperature` DECIMAL(5,1) NOT NULL ,
  `rain_fall` DECIMAL(5,1) UNSIGNED NOT NULL ,
  `wind_direction` TINYINT UNSIGNED NOT NULL ,
  `wind_speed` DECIMAL(5,1) UNSIGNED NOT NULL ,
  `day_light` DECIMAL(3,1) UNSIGNED NOT NULL ,
  `depth_of_snow` DECIMAL(3,1) UNSIGNED NOT NULL ,
  `moisture` DECIMAL(4,1) UNSIGNED NOT NULL ,
  `air_pressure` DECIMAL(5,1) UNSIGNED NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  PRIMARY KEY (`point_id`, `observed_at`) ,
  INDEX `fk_observation_point1` (`point_id` ASC) ,
  CONSTRAINT `fk_observation_point1`
    FOREIGN KEY (`point_id` )
    REFERENCES `point` (`point_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `temperature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `temperature` ;

CREATE  TABLE IF NOT EXISTS `temperature` (
  `point_id` SMALLINT UNSIGNED NOT NULL ,
  `observed_at` DATETIME NOT NULL ,
  `value` DECIMAL(5,1) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  PRIMARY KEY (`point_id`, `observed_at`) ,
  INDEX `fk_temperature_point1` (`point_id` ASC) ,
  CONSTRAINT `fk_temperature_point1`
    FOREIGN KEY (`point_id` )
    REFERENCES `point` (`point_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
