/* drop table consistsOf; */
drop table pricing;
drop table orders;
drop table product;
drop table customer;
drop table supplier;
drop table staffMember;
drop table warehouse;
drop table address;

CREATE TABLE product(
  productID      INT,
  category       VARCHAR(50),
  alcoholContent NUMERIC(4,2),  
  pSize          INT,
  name           VARCHAR(50),
  calories       INT,
  servingSize    INT,
  fatContent     INT,
  sodiumContent  INT,
  PRIMARY KEY (productID)
);


CREATE TABLE pricing(
  productID   INT,
  state       VARCHAR(50),
  price       INT, 
  PRIMARY KEY (productID, state),
  FOREIGN KEY (productID) REFERENCES product
);


CREATE TABLE customer(
  customerID     INT NOT NULL,
  currentBalance NUMERIC(6,2),
  customerName   VARCHAR(80),
  age            INT,
  ccNumber       NUMERIC(16,0),
  PRIMARY KEY(customerID)
);

CREATE TABLE orders(
  customerID    INT NOT NULL,
  productID     INT NOT NULL,
  orderID       INT NOT NULL, 
  totalCost     NUMERIC(6,2),
  status        VARCHAR(10),
  month         INT,
  day           INT,
  year          INT,
  PRIMARY KEY (customerID, productID, orderID),
  FOREIGN KEY (customerID) REFERENCES customer,
  FOREIGN KEY (productID) REFERENCES product	
);

/*
CREATE TABLE consistsOf(
  customerID   INT NOT NULL,
  productID    INT NOT NULL,
  orderID      INT NOT NULL, 
  quantity     INT,
  PRIMARY KEY (customerID, productID, orderID),
  FOREIGN KEY (orderID) REFERENCES orders,
  FOREIGN KEY (customerID) REFERENCES customer,
  FOREIGN KEY (productID) REFERENCES product
);

*/

CREATE TABLE address
(
  addressID      INT,
  city           VARCHAR(50),
  state          CHAR(2),
  zip            NUMERIC(5,0),
  streetName     VARCHAR(50),
  streetNumber   NUMERIC(3,0),
  aptNo          NUMERIC(3,0),
  PRIMARY KEY (addressID)
);

CREATE TABLE supplier
(
  name         VARCHAR (50),
  price        NUMERIC (5,2),
  addressID    INT,
  warehouseID  INT,
  PRIMARY KEY (name),
  FOREIGN KEY (addressID) REFERENCES address
);

CREATE TABLE warehouse(
  WarehouseID       INT,
  AddressID         INT,
  storageCapacity   INT,
  PRIMARY KEY (warehouseID),
  FOREIGN KEY (addressID) REFERENCES address 
);

CREATE TABLE staffMember
(
  employeeID    NUMERIC (5,2),
  addressID     INT,
  firstName     VARCHAR (50),
  lastName      VARCHAR (50),
  jobTitle      VARCHAR (50),
  salary        NUMERIC (6,2),
  warehouseID   INT,
  PRIMARY KEY (employeeID),
  FOREIGN KEY(addressID) REFERENCES address,
  FOREIGN KEY(warehouseID) REFERENCES warehouse
);
