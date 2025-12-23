-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer_address` (
  `address_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `address` TEXT NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `pincode` CHAR(6) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer_subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer_subscription` (
  `subscription_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `plan_name` VARCHAR(40) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`subscription_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_item` (
  `order_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `item_price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`order_id`, `item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`delivery_assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`delivery_assignment` (
  `assignment_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `partner_id` INT NOT NULL,
  `assigned_time` TIMESTAMP NOT NULL,
  `delivered_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`assignment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`review` (
  `review_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `review_text` VARCHAR(300) NULL,
  `review_date` DATE NOT NULL,
  PRIMARY KEY (`review_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`coupon_redemption`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`coupon_redemption` (
  `redemption_id` INT NOT NULL,
  `coupon_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`redemption_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment` (
  `payment_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `payment_mode` VARCHAR(20) NOT NULL,
  `payment_date` TIMESTAMP NOT NULL,
  `amount` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rating` (
  `rating_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`rating_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `order_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  `order_time` TIMESTAMP NOT NULL DEFAULT DEFAULT CURRENT_TIMESTAMP,
  `total_amount` DECIMAL(8,2) NOT NULL,
  `order_status` VARCHAR(20) NOT NULL,
  `order_item_order_id` INT NOT NULL,
  `order_item_item_id` INT NOT NULL,
  `delivery_assignment_assignment_id` INT NOT NULL,
  `review_review_id` INT NOT NULL,
  `coupon_redemption_redemption_id` INT NOT NULL,
  `payment_payment_id` INT NOT NULL,
  `rating_rating_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `order_item_order_id`, `order_item_item_id`),
  INDEX `fk_orders_order_item1_idx` (`order_item_order_id` ASC, `order_item_item_id` ASC) VISIBLE,
  INDEX `fk_orders_delivery_assignment1_idx` (`delivery_assignment_assignment_id` ASC) VISIBLE,
  INDEX `fk_orders_review1_idx` (`review_review_id` ASC) VISIBLE,
  INDEX `fk_orders_coupon_redemption1_idx` (`coupon_redemption_redemption_id` ASC) VISIBLE,
  INDEX `fk_orders_payment1_idx` (`payment_payment_id` ASC) VISIBLE,
  INDEX `fk_orders_rating1_idx` (`rating_rating_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_order_item1`
    FOREIGN KEY (`order_item_order_id` , `order_item_item_id`)
    REFERENCES `mydb`.`order_item` (`order_id` , `item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_delivery_assignment1`
    FOREIGN KEY (`delivery_assignment_assignment_id`)
    REFERENCES `mydb`.`delivery_assignment` (`assignment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_review1`
    FOREIGN KEY (`review_review_id`)
    REFERENCES `mydb`.`review` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_coupon_redemption1`
    FOREIGN KEY (`coupon_redemption_redemption_id`)
    REFERENCES `mydb`.`coupon_redemption` (`redemption_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_payment1`
    FOREIGN KEY (`payment_payment_id`)
    REFERENCES `mydb`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_rating1`
    FOREIGN KEY (`rating_rating_id`)
    REFERENCES `mydb`.`rating` (`rating_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`support_ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`support_ticket` (
  `ticket_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `issue_type` VARCHAR(45) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `created_on` DATE NOT NULL,
  PRIMARY KEY (`ticket_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `customer_id` INT NOT NULL,
  `full_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `dob` DATE NOT NULL,
  `gender` ENUM('M', 'F', 'O') NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `customer_address_address_id` INT NOT NULL,
  `customer_subscription_subscription_id` INT NOT NULL,
  `orders_order_id` INT NOT NULL,
  `support_ticket_ticket_id` INT NOT NULL,
  `coupon_redemption_redemption_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_customer_address_idx` (`customer_address_address_id` ASC) VISIBLE,
  INDEX `fk_customer_customer_subscription1_idx` (`customer_subscription_subscription_id` ASC) VISIBLE,
  INDEX `fk_customer_orders1_idx` (`orders_order_id` ASC) VISIBLE,
  INDEX `fk_customer_support_ticket1_idx` (`support_ticket_ticket_id` ASC) VISIBLE,
  INDEX `fk_customer_coupon_redemption1_idx` (`coupon_redemption_redemption_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_customer_address`
    FOREIGN KEY (`customer_address_address_id`)
    REFERENCES `mydb`.`customer_address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_customer_subscription1`
    FOREIGN KEY (`customer_subscription_subscription_id`)
    REFERENCES `mydb`.`customer_subscription` (`subscription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_orders1`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `mydb`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_support_ticket1`
    FOREIGN KEY (`support_ticket_ticket_id`)
    REFERENCES `mydb`.`support_ticket` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_coupon_redemption1`
    FOREIGN KEY (`coupon_redemption_redemption_id`)
    REFERENCES `mydb`.`coupon_redemption` (`redemption_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menu_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu_item` (
  `item_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `is_veg` TINYINT(1) NOT NULL,
  `availability` TINYINT(1) NOT NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menu_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu_category` (
  `category_id` INT NOT NULL,
  `category_name` VARCHAR(30) NOT NULL,
  `menu_item_item_id` INT NOT NULL,
  PRIMARY KEY (`category_id`),
  INDEX `fk_menu_category_menu_item1_idx` (`menu_item_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_category_menu_item1`
    FOREIGN KEY (`menu_item_item_id`)
    REFERENCES `mydb`.`menu_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`menu` (
  `menu_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  `created_on` DATE NOT NULL,
  `menu_category_category_id` INT NOT NULL,
  PRIMARY KEY (`menu_id`),
  INDEX `fk_menu_menu_category1_idx` (`menu_category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_menu_category1`
    FOREIGN KEY (`menu_category_category_id`)
    REFERENCES `mydb`.`menu_category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`restaurant_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`restaurant_branch` (
  `branch_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  `open_time` TIME NOT NULL,
  `close_time` TIME NOT NULL,
  `menu_menu_id` INT NOT NULL,
  PRIMARY KEY (`branch_id`),
  INDEX `fk_restaurant_branch_menu1_idx` (`menu_menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_branch_menu1`
    FOREIGN KEY (`menu_menu_id`)
    REFERENCES `mydb`.`menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuisine` (
  `cuisine_id` INT NOT NULL,
  `cuisine_id` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`cuisine_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`restaurant_cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`restaurant_cuisine` (
  `restaurant_id` INT NOT NULL,
  `restaurant_cuisinecol` INT NOT NULL,
  `cuisine_cuisine_id` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `restaurant_cuisinecol`, `cuisine_cuisine_id`),
  INDEX `fk_restaurant_cuisine_cuisine1_idx` (`cuisine_cuisine_id` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_cuisine_cuisine1`
    FOREIGN KEY (`cuisine_cuisine_id`)
    REFERENCES `mydb`.`cuisine` (`cuisine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`restaurant` (
  `restaurant_id` INT NOT NULL,
  `restaurant_name` VARCHAR(50) NOT NULL,
  `fssai_no` CHAR(14) NOT NULL,
  `contact_no` CHAR(10) NOT NULL,
  `restaurant_branch_branch_id` INT NOT NULL,
  `restaurant_cuisine_restaurant_id` INT NOT NULL,
  `restaurant_cuisine_restaurant_cuisinecol` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `restaurant_cuisine_restaurant_id`, `restaurant_cuisine_restaurant_cuisinecol`),
  INDEX `fk_restaurant_restaurant_branch1_idx` (`restaurant_branch_branch_id` ASC) VISIBLE,
  INDEX `fk_restaurant_restaurant_cuisine1_idx` (`restaurant_cuisine_restaurant_id` ASC, `restaurant_cuisine_restaurant_cuisinecol` ASC) VISIBLE,
  CONSTRAINT `fk_restaurant_restaurant_branch1`
    FOREIGN KEY (`restaurant_branch_branch_id`)
    REFERENCES `mydb`.`restaurant_branch` (`branch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_restaurant_cuisine1`
    FOREIGN KEY (`restaurant_cuisine_restaurant_id` , `restaurant_cuisine_restaurant_cuisinecol`)
    REFERENCES `mydb`.`restaurant_cuisine` (`restaurant_id` , `restaurant_cuisinecol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`delivery_partner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`delivery_partner` (
  `partner_id` INT NOT NULL,
  `partner_name` VARCHAR(45) NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `vehicle_type` VARCHAR(20) NOT NULL,
  `joining_date` DATE NOT NULL,
  `delivery_assignment_assignment_id` INT NOT NULL,
  PRIMARY KEY (`partner_id`),
  INDEX `fk_delivery_partner_delivery_assignment1_idx` (`delivery_assignment_assignment_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_partner_delivery_assignment1`
    FOREIGN KEY (`delivery_assignment_assignment_id`)
    REFERENCES `mydb`.`delivery_assignment` (`assignment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`coupon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`coupon` (
  `coupon_id` INT NOT NULL,
  `coupon_code` VARCHAR(20) NOT NULL,
  `discount_percent` INT NOT NULL,
  `coupon_redemption_redemption_id` INT NOT NULL,
  PRIMARY KEY (`coupon_id`),
  INDEX `fk_coupon_coupon_redemption1_idx` (`coupon_redemption_redemption_id` ASC) VISIBLE,
  CONSTRAINT `fk_coupon_coupon_redemption1`
    FOREIGN KEY (`coupon_redemption_redemption_id`)
    REFERENCES `mydb`.`coupon_redemption` (`redemption_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
