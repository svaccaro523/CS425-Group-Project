drop table pricing;
drop table orders;
drop table supplier;
drop table product;
drop table customer;
drop table staffMember;
drop table warehouse;
drop table address;

CREATE TABLE product(
  productID      INT,
  category       VARCHAR(16),
  alcoholContent NUMERIC(4,2),  
  pSize          INT,
  name           VARCHAR(16),
  calories       INT,
  servingSize    INT,
  fatContent     INT,
  sodiumContent  INT,
  PRIMARY KEY (productID)
);

CREATE TABLE pricing(
  productID   INT,
  st          VARCHAR(2) NOT NULL,
  price       NUMERIC(5,2), 
  PRIMARY KEY (productID, st),
  FOREIGN KEY (productID) REFERENCES product,
  CHECK (price>=0)
);

CREATE TABLE customer(
  customerID     INT,
  currentBalance NUMERIC(6,2),
  customerName   VARCHAR(32),
  age            INT,
  ccNumber       NUMERIC(16,0),
  PRIMARY KEY(customerID),
  CHECK (age>=0)
);

CREATE TABLE address
(
  addressID      INT,
  city           VARCHAR(16),
  st             CHAR(2) NOT NULL,
  zip            NUMERIC(5,0),
  streetName     VARCHAR(32),
  streetNumber   NUMERIC(3,0),
  aptNo          NUMERIC(3,0),
  PRIMARY KEY (addressID)
);

CREATE TABLE orders(
  customerID    INT,
  productID     INT,
  orderID       INT, 
  addressID     INT,
  quantity      INT,
  totalCost     NUMERIC(6,2),
  status        VARCHAR(8),  
  month         INT,
  day           INT,
  year          INT,
  PRIMARY KEY (customerID, productID, orderID),
  FOREIGN KEY (customerID) REFERENCES customer,
  FOREIGN KEY (productID) REFERENCES product,	
  FOREIGN KEY (addressID) REFERENCES address,
  CHECK (month BETWEEN 1 AND 12),
  CHECK (day BETWEEN 1 AND 31),
  CHECK (year BETWEEN 1950 AND 2050)
);


CREATE TABLE supplier
(
  name         VARCHAR (32),
  price        NUMERIC (5,2),
  addressID    INT,
  warehouseID  INT,
  productID    INT,
  PRIMARY KEY (name),
  FOREIGN KEY (addressID) REFERENCES address,
  FOREIGN KEY (productID) REFERENCES product,
  CHECK (price>=0)
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
  firstName     VARCHAR (32) NOT NULL,
  lastName      VARCHAR (32) NOT NULL,
  jobTitle      VARCHAR (16) NOT NULL,
  salary        NUMERIC (6,2),
  warehouseID   INT,
  PRIMARY KEY (employeeID),
  FOREIGN KEY(addressID) REFERENCES address,
  FOREIGN KEY(warehouseID) REFERENCES warehouse,
  CHECK (salary>=0)
);

CREATE INDEX usa
ON pricing(st);

CREATE INDEX orderFulfillment 
ON orders(status);

CREATE INDEX ac
ON product(name, alcoholContent);
