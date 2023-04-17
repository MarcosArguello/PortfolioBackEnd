-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema porfoliodb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema porfoliodb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `porfoliodb` DEFAULT CHARACTER SET utf8 ;
USE `porfoliodb` ;

-- -----------------------------------------------------
-- Table `porfoliodb`.`persona_db`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`persona_db` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  `sobre_mi` VARCHAR(200) NULL,
  `url_foto` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`tipo_empleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`tipo_empleo` (
  `id` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`empresa` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `url_logo` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`experiencia_laboral` (
  `id` INT NOT NULL,
  `nombre_empresa` VARCHAR(45) NULL,
  `es_trabajo_actual` TINYINT NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `descripcion` VARCHAR(200) NULL,
  `persona_db_id` INT NOT NULL,
  `tipo_empleo_id` INT NOT NULL,
  `empresa_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_db_id`, `tipo_empleo_id`, `empresa_id`),
  INDEX `fk_experiencia_laboral_persona_db_idx` (`persona_db_id` ASC) VISIBLE,
  INDEX `fk_experiencia_laboral_tipo_empleo1_idx` (`tipo_empleo_id` ASC) VISIBLE,
  INDEX `fk_experiencia_laboral_empresa1_idx` (`empresa_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona_db`
    FOREIGN KEY (`persona_db_id`)
    REFERENCES `porfoliodb`.`persona_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_laboral_tipo_empleo1`
    FOREIGN KEY (`tipo_empleo_id`)
    REFERENCES `porfoliodb`.`tipo_empleo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_laboral_empresa1`
    FOREIGN KEY (`empresa_id`)
    REFERENCES `porfoliodb`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`educacion` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `persona_db_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_db_id`),
  INDEX `fk_educacion_persona_db1_idx` (`persona_db_id` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona_db1`
    FOREIGN KEY (`persona_db_id`)
    REFERENCES `porfoliodb`.`persona_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`intitucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`intitucion` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `url_logo` VARCHAR(100) NULL,
  `educacion_id` INT NOT NULL,
  `educacion_persona_db_id` INT NOT NULL,
  PRIMARY KEY (`id`, `educacion_id`, `educacion_persona_db_id`),
  INDEX `fk_intitucion_educacion1_idx` (`educacion_id` ASC, `educacion_persona_db_id` ASC) VISIBLE,
  CONSTRAINT `fk_intitucion_educacion1`
    FOREIGN KEY (`educacion_id` , `educacion_persona_db_id`)
    REFERENCES `porfoliodb`.`educacion` (`id` , `persona_db_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`habilidad` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`programa` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `habilidad_id` INT NOT NULL,
  PRIMARY KEY (`id`, `habilidad_id`),
  INDEX `fk_programa_habilidad1_idx` (`habilidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_programa_habilidad1`
    FOREIGN KEY (`habilidad_id`)
    REFERENCES `porfoliodb`.`habilidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`red_social`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`red_social` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `url_link` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`proyecto` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `url_foto` VARCHAR(100) NULL,
  `persona_db_id` INT NOT NULL,
  `empresa_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_db_id`, `empresa_id`),
  INDEX `fk_proyecto_persona_db1_idx` (`persona_db_id` ASC) VISIBLE,
  INDEX `fk_proyecto_empresa1_idx` (`empresa_id` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona_db1`
    FOREIGN KEY (`persona_db_id`)
    REFERENCES `porfoliodb`.`persona_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyecto_empresa1`
    FOREIGN KEY (`empresa_id`)
    REFERENCES `porfoliodb`.`empresa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`habilidad_has_persona_db`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`habilidad_has_persona_db` (
  `habilidad_id` INT NOT NULL,
  `persona_db_id` INT NOT NULL,
  PRIMARY KEY (`habilidad_id`, `persona_db_id`),
  INDEX `fk_habilidad_has_persona_db_persona_db1_idx` (`persona_db_id` ASC) VISIBLE,
  INDEX `fk_habilidad_has_persona_db_habilidad1_idx` (`habilidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_has_persona_db_habilidad1`
    FOREIGN KEY (`habilidad_id`)
    REFERENCES `porfoliodb`.`habilidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habilidad_has_persona_db_persona_db1`
    FOREIGN KEY (`persona_db_id`)
    REFERENCES `porfoliodb`.`persona_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `porfoliodb`.`persona_db_has_red_social`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `porfoliodb`.`persona_db_has_red_social` (
  `persona_db_id` INT NOT NULL,
  `red_social_id` INT NOT NULL,
  PRIMARY KEY (`persona_db_id`, `red_social_id`),
  INDEX `fk_persona_db_has_red_social_red_social1_idx` (`red_social_id` ASC) VISIBLE,
  INDEX `fk_persona_db_has_red_social_persona_db1_idx` (`persona_db_id` ASC) VISIBLE,
  CONSTRAINT `fk_persona_db_has_red_social_persona_db1`
    FOREIGN KEY (`persona_db_id`)
    REFERENCES `porfoliodb`.`persona_db` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_db_has_red_social_red_social1`
    FOREIGN KEY (`red_social_id`)
    REFERENCES `porfoliodb`.`red_social` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
